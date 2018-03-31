;; https://github.com/Malabarba/smart-mode-line

(use-package powerline
  :disabled)

(use-package smart-mode-line
  :disabled
  ;; :after (powerline projectile)
  :config
  (setq sml/theme 'respectful)
  (setq sml/no-confirm-load-theme t)
  (setq rm-blacklist
        (format "^ \\(%s\\)$"
                (mapconcat #'identity
                           '("Fly.*"
                             "Projectile.*"
                             "PgLn"
                             "Helm"
                             "hl-s"
                             "Golden"
                             "snipe"
                             "Elpy"
                             "ctagsU"
                             "GG"
                             "Hi"
                             "Spnxd"
                             "WSC"
                             "ws"
                             "SP"
                             "DS"
                             "Undo-Tree"
                             "ARev")
                           "\\|")))
  (sml/setup))
