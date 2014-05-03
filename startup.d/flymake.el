;; Personal configuration for flymake-python
;; https://github.com/akaihola/flymake-python

(add-to-list 'load-path "~/.emacs.d") ;; check path

(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.emacs.d/vendor/flymake-python/pyflymake.py" (list local-file))))
      ;;     check path

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))
;; Set logging for DEBUG
(setq flymake-log-level 1)

;; Load flymake automatically
(add-hook 'find-file-hook 'flymake-find-file-hook)

(delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)
