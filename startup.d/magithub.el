;; https://github.com/vermiculus/magithub
(require 'magit)
(require 'magithub)

(load "~/.ghub.el")

;; API timeout before asking to go offline
(setq magithub-api-timeout 3)

(setq magithub-cache-class-refresh-seconds-alist
      '((:issues . 600)
        (:ci-status . 3600)
        (:repo-demographics . 86400)
        (:user-demographics . 86400)
        (:label . 3600)))

(magithub-feature-autoinject t)
