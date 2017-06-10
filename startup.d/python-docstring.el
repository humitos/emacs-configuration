;; https://github.com/glyph/python-docstring-mode

(require 'python-docstring)

(setq python-docstring-script
      (expand-file-name "vendor/python-docstring-mode/docstring_wrap.py" emacs-user-directory))

;; do not use double spaces when formatting text
(setq python-docstring-sentence-end-double-space nil)

;; enable it in all the python-mode buffers
(defun python-docstring-mode-hook ()
  (python-docstring-mode t))
(add-hook 'python-mode-hook 'python-docstring-mode-hook)
