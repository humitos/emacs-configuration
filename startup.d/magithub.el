;; https://github.com/vermiculus/magithub
(require 'magithub)

(load "~/.ghub.el")

;; API timeout before asking to go offline
(setq magithub-api-timeout 5)

(magithub-feature-autoinject t)

