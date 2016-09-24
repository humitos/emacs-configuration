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
;; (setq projectile-tags-command "ctags-exuberant -Re --python-kinds=-iv -f \"%s\" %s")

;; https://github.com/universal-ctags/ctags
;; Build from source: https://github.com/universal-ctags/ctags/blob/master/docs/autotools.rst
;;   $ ./autogen.sh
;;   $ ./configure --prefix=`pwd`/build
;;   $ make
;;   $ make install
(setq projectile-tags-command
      (concat emacs-user-directory
              "vendor/ctags/build/bin/ctags"
              (concat " --options=" emacs-user-directory ".ctags")
              " -f \"%s\" %s"))
