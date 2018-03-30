;; Packages installed using `use-package'
;; (if the configuration is long enough it has it's own `startup.d/<package>.el' filename)

; https://github.com/rranelli/auto-package-update.el
(use-package auto-package-update
             :config
             (setq auto-package-update-delete-old-versions t)
             (setq auto-package-update-hide-results t)
             (setq auto-package-update-prompt-before-update t)
             (auto-package-update-maybe))

;; https://github.com/rmuslimov/browse-at-remote
(use-package browse-at-remote
             :config
             (setq browse-at-remote-prefer-symbolic nil)
             :bind
             (("C-c g g" . browse-at-remote)))
