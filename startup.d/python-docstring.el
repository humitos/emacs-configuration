;; https://github.com/glyph/python-docstring-mode

(require 'python-docstring)

(setq python-docstring-script
      (expand-file-name "vendor/python-docstring-mode/docstring_wrap.py" emacs-user-directory))

(python-docstring-mode t)
