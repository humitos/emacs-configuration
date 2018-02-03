;; https://github.com/jaypei/emacs-neotree
(require 'neotree)

(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; every time when the neotree window is opened, it will try to find
;; current file and jump to node
(setq neo-smart-open t)

;; specifies the width of the NeoTree window
(setq neo-window-width 45)
