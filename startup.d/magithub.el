;; https://github.com/vermiculus/magithub
(use-package magithub
  :after (magit magit-popup)
  ;; https://github.com/vermiculus/magithub/issues/286#issuecomment-366540058
  :requires magithub-completion
  :config
  (load "~/.ghub.el")

  ;; API timeout before asking to go offline
  (setq magithub-api-timeout 3)

  (setq magithub-cache-class-refresh-seconds-alist
        '((:issues . 600)
          (:ci-status . 3600)
          (:repo-demographics . 86400)
          (:user-demographics . 86400)
          (:label . 3600)))

  ;; https://github.com/vermiculus/magithub/pull/142
  (setq magithub-api-available-check-frequency 600)

  (magithub-feature-autoinject t)

  ;; redefine it to remove "My notes" section
  (setq magithub-issue-details-hook
        '(magithub-issue-detail-insert-created
          magithub-issue-detail-insert-updated
          magithub-issue-detail-insert-author
          magithub-issue-detail-insert-assignees
          magithub-issue-detail-insert-labels
          magithub-issue-detail-insert-body-preview))

  ;; https://github.com/vermiculus/magithub/issues/166#issuecomment-351537763
  (with-eval-after-load 'magithub ;; magithub limit filters
    (require 'parse-time)

    (defmacro magithub--time-number-of-days-since-string (iso8601)
      `(time-to-number-of-days
        (time-since
         (parse-iso8601-time-string
          (concat ,iso8601 "+00:00")))))

    (defun issue-filter-to-days (days type)
      `(lambda (issue)
         (let ((created_at (magithub--time-number-of-days-since-string
                            (alist-get 'created_at issue)))
               (updated_at (magithub--time-number-of-days-since-string
                            (alist-get 'updated_at issue))))
           (or (< created_at ,days) (< updated_at ,days)))))

    (defun magithub-filter-maybe (&optional limit)
      "Add filters to magithub only if number of issues is greter than LIMIT."
      (let ((max-issues (length (ignore-errors (magithub-issues))))
            (max-pull-requests (length (ignore-errors (magithub-pull-requests))))
            (limit (or limit 15)))
        (when (> max-issues limit)
          (add-to-list (make-local-variable 'magithub-issue-issue-filter-functions)
                       (issue-filter-to-days limit "issues")))
        (when (> max-pull-requests limit)
          (add-to-list (make-local-variable 'magithub-issue-pull-request-filter-functions)
                       (issue-filter-to-days limit "pull-requests")))))

    (add-to-list 'magit-status-mode-hook #'magithub-filter-maybe))

  ;; (defun issue-number-greater-than (issue)
  ;;   (> (alist-get 'number issue) 3000))

  ;; ;; https://github.com/vermiculus/magithub/issues/166#issuecomment-345459704
  ;; (setq magithub-issue-issue-filter-functions '(issue-number-greater-than))
  )
