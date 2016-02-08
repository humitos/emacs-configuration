;; init.el configuration file

;; Load all extra libraries from externals
;; (add-to-list 'load-path "~/.emacs.d/vendor")
;; (let ((default-directory "~/.emacs.d/vendor"))
;;  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path "~/.emacs.d/packages")
(let ((default-directory "~/.emacs.d/packages"))
  (normal-top-level-add-subdirs-to-load-path))

;; Set path for startup.d
(add-to-list 'load-path "~/.emacs.d")

;; Load all my personal configurations
(require 'startupd)
;; Set path for personal configurations
(setq startupd-path "~/.emacs.d/startup.d/")
(startupd-load-files)

