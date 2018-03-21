;; https://github.com/bmag/imenu-list

(require 'imenu-list)

(setq imenu-list-focus-after-activation t)
(global-set-key (kbd "C-'") #'imenu-list-smart-toggle)
