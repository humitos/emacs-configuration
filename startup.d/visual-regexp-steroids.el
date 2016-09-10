;; https://github.com/benma/visual-regexp-steroids.el/
(require 'visual-regexp-steroids)

(setq vr/engine 'python)
(setq vr/command-python (concat "python " emacs-user-directory "vendor/visual-regexp-steroids.el/regexp.py"))
