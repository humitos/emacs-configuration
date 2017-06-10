(require 'py-autopep8)
(setq py-autopep8-options '((concat "--global-config=" emacs-user-directory "autopep8rc")))
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
