;; https://github.com/juergenhoetzel/pkgbuild-mode
(require 'pkgbuild-mode)

(setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode))
                              auto-mode-alist))
