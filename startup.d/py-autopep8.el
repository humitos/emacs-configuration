(require 'py-autopep8)
(setq py-autopep8-options '((concat "--global-config=" emacs-user-directory "autopep8rc")))
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
