;; https://github.com/cpaulik/emacs-material-theme

(add-to-list 'custom-theme-load-path (concat emacs-user-directory "vendor/emacs-material-theme"))
(load-theme 'material t) ;; load material theme


;; I need to load these settings here, because they are overiden by
;; the "(load-theme 'material t)" function

;; git-gutter background configuration for material theme
(set-face-background 'git-gutter:unchanged "#263238")
(set-face-background 'git-gutter:added "#263238")
(set-face-background 'git-gutter:deleted "#263238")
(set-face-background 'git-gutter:modified "#263238")
