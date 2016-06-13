;; init.el configuration file

;; Load all extra libraries from externals
;; (add-to-list 'load-path "~/.emacs.d/vendor")
;; (let ((default-directory "~/.emacs.d/vendor"))
;;  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path (concat user-emacs-directory "packages"))
(let ((default-directory (concat user-emacs-directory "packages")))
  (normal-top-level-add-subdirs-to-load-path))

;; Set path for startup.d
(add-to-list 'load-path (concat user-emacs-directory "vendor/startupd.el"))

;; Load all my personal configurations
(require 'startupd)
;; Set path for personal configurations
(setq startupd-path (concat user-emacs-directory "startup.d/"))
(startupd-load-files)
