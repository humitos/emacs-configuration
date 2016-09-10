;; https://www.emacswiki.org/emacs/WindMove
(defun ignore-error-wrapper (fn)
  "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
  (lexical-let ((fn fn))
    (lambda ()
      (interactive)
      (ignore-errors
        (funcall fn)))))

(global-set-key (kbd "C-c <left>") (ignore-error-wrapper 'windmove-left))
(global-set-key (kbd "C-c <right>") (ignore-error-wrapper 'windmove-right))
(global-set-key (kbd "C-c <up>") (ignore-error-wrapper 'windmove-up))
(global-set-key (kbd "C-c <down>") (ignore-error-wrapper 'windmove-down))
