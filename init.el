;; init.el configuration file

;; Set path for all the libraries/plugins/packages installed
(add-to-list 'load-path (concat user-emacs-directory "packages"))

;; Set path for startup.d
(add-to-list 'load-path (concat user-emacs-directory "vendor/startupd.el"))

;; Load all my personal configurations
(require 'startupd)
;; Set path for personal configurations
(setq startupd-path (concat user-emacs-directory "startup.d/"))
(startupd-load-files)
