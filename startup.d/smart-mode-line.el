;; https://github.com/Malabarba/smart-mode-line
(use-package smart-mode-line
  :config
  (setq sml/theme 'respectful)
  (setq sml/no-confirm-load-theme t)
  (setq rm-blacklist
        (format "^ ?\\(%s\\)$"
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
                             "WSC!?"
                             "ws"
                             "SP"
                             "DS"
                             "Undo-Tree"
                             "Anzu"
                             "ARev")
                           "\\|")))
  (sml/setup))
