;; https://github.com/jixiuf/ctags-update
(require 'ctags-update)
(autoload 'turn-on-ctags-auto-update-mode "ctags-update" "turn on `ctags-auto-update-mode'." t)
(add-hook 'elpy-mode-hook 'turn-on-ctags-auto-update-mode)

(if (getenv "DOCKER")
    (setq ctags-update-command "ctags")
  (setq ctags-update-command (concat emacs-user-directory  "vendor/ctags/ctags")))

(setq ctags-update-other-options (list (concat "--options=" emacs-user-directory ".ctags")))
(setq ctags-update-delay-seconds (* 5 60)) ;; 5 minutes
