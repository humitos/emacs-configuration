(require 'projectile)
(projectile-global-mode)

;; http://projectile.readthedocs.io/en/latest/configuration/#caching
(setq projectile-enable-caching t)

;; http://projectile.readthedocs.io/en/latest/configuration/#mode-line-indicator
(setq projectile-mode-line '(:eval (format " [%s]" (projectile-project-name))))


(setq projectile-ignored-projects '("elpy" ".emacs.d"))
(setq projectile-globally-ignored-directories '("undohist"))
(setq projectile-globally-ignored-file-suffixes
      '("~"
	"#"
	"orig"
	"bak"
	"gitignore"
	))

;; https://github.com/bbatsov/projectile/issues/133#issuecomment-97118653
;; sudo apt-get install exuberant-ctags
(setq projectile-tags-command "ctags-exuberant -Re -f \"%s\" %s")
