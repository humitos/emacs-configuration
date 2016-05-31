(require 'projectile)
(projectile-global-mode)

;; http://projectile.readthedocs.io/en/latest/configuration/#caching
(setq projectile-enable-caching t)

;; http://projectile.readthedocs.io/en/latest/configuration/#mode-line-indicator
(setq projectile-mode-line '(:eval (format " [%s]" (projectile-project-name))))

;; (setq projectile-globally-ignored-directories '("undohist"))
;; (setq projectile-globally-ignored-file-suffixes '("*~"))
