;; init.el configuration file

;; MELPA.org repository for `package.el' and `use-package' macro
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/"))))
)
(package-initialize)

;; https://github.com/jwiegley/use-package
(eval-when-compile
  (add-to-list 'load-path (concat emacs-user-directory "vendor/use-package"))
  ;; Always check the package is installed and available
  (setq use-package-always-ensure t)
  (setq use-package-verbose t)
  (setq use-package-expand-minimally t) ;; debug
  ;; (setq use-package-always-pin "melpa-stable")
  (require 'use-package))

;; Set path for all the libraries/plugins/packages installed
(add-to-list 'load-path (concat emacs-user-directory "packages"))

;; Set path for startup.d
(add-to-list 'load-path (concat emacs-user-directory "vendor/startupd.el"))

;; Load all my personal configurations
(require 'startupd)
;; Set path for personal configurations
(setq startupd-path (concat emacs-user-directory "startup.d/"))
(startupd-load-files)
