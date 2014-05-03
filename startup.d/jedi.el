;; Jedi
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)

(setq jedi:server-command '("/home/humitos/.emacs.d/vendor/emacs-jedi/jediepcserver.py"))

(setq jedi:complete-on-dot t)

(setq jedi:get-in-function-call-delay 500)
