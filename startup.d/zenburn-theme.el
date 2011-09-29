;; Personal configuration for zenburn-theme.el

;; Set the color theme
;; https://github.com/bbatsov/zenburn-emacs
;; http://www.emacswiki.org/emacs/ColorThemeZenburn

;; FIXME: I need to auto-accept the question about "Are you sure that
;; you want to excecute the theme Lisp code?"
(add-to-list 'custom-theme-load-path "~/.emacs.d/vendor/zenburn-emacs")
;; (color-theme-zenburn)
(load-theme 'zenburn)
;; (funcall 'zenburn)
