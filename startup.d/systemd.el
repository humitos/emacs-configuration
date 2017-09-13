;; https://github.com/holomorph/systemd-mode
(require 'systemd)

;; https://wiki.archlinux.org/index.php/Emacs#Syntax_highlighting_for_systemd_Files
(add-to-list 'auto-mode-alist '("\\.service\\'" . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.timer\\'" . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.target\\'" . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.mount\\'" . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.automount\\'" . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.slice\\'" . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.socket\\'" . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.path\\'" . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.netdev\\'" . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.network\\'" . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.link\\'" . systemd-mode))
(add-to-list 'auto-mode-alist '("\\.automount\\'" . systemd-mode))
