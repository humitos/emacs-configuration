;; Packages installed using `use-package'
;; (if the configuration is long enough it has it's own `startup.d/<package>.el' filename)

;; https://github.com/rranelli/auto-package-update.el
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
             ("C-c g g" . browse-at-remote))

;; https://github.com/emacsmirror/nlinum
(use-package nlinum
             ;; FIXME: this is currently failing for some `use-package' reason
             :disabled
             :hook (prog-mode text-mode)
             :init
             (setq nlinum-format "%4d \u2502") ;; line numbers style
             )

;; https://github.com/domtronn/all-the-icons.el
;; To install the fonts, I ran:
;; $ cd $HOME/.fonts
;; $ ln -s ../all-the-icons/fonts all-the-icons
(use-package all-the-icons)

;; FIXME: not available in MELPA
;; (use-package any-ini-mode
;;              :mode ("\\.ini\\'" "\\.rc\\'"))


;; https://github.com/abo-abo/avy
(use-package avy
             :bind
             ("C-c C-c" . avy-goto-char-timer)
             :config
             (setq avy-background t)
             ;; respect case
             (setq avy-case-fold-search nil)
             )


;; https://github.com/steckerhalter/discover-my-major
(use-package discover-my-major)


;; https://github.com/spotify/dockerfile-mode
(use-package dockerfile-mode
             :mode "Dockerfile\\'")


;; https://github.com/magnars/expand-region.el
(use-package expand-region
             :bind
             ("C-=" . er/expand-region))

;; https://github.com/magnars/smart-forward.el
(use-package smart-forward
             :bind
             ("C-s-<up>" . smart-up)
             ("C-s-<down>" . smart-down)
             ("C-s-<left>" . smart-backward)
             ("C-s-<right>" . smart-forward))
