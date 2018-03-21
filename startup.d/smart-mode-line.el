;; https://github.com/Malabarba/smart-mode-line
(require 'smart-mode-line)
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
                           "ARev")
                         "\\|")))

(sml/setup)
