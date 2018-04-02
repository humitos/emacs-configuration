;; https://github.com/magit/magit
(use-package magit
  :bind ("C-x g" . magit-status)
  :config
  ;; start *Magit* buffer maximized
  ;; http://stackoverflow.com/a/36603726
  (defun display-buffer-full-screen (buffer alist)
    (delete-other-windows)
    (set-window-dedicated-p nil nil)
    (set-window-buffer nil buffer)
    (get-buffer-window buffer))

  (setq magit-display-buffer-function
        (lambda (buffer)
          (if magit-display-buffer-noselect
              (magit-display-buffer-traditional buffer)
            (display-buffer buffer '(display-buffer-full-screen)))))

  ;; try to show differences as diff-highlight (yeah, it's kind of poor)
  (setq magit-diff-refine-hunk t))
