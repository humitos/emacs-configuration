;; Remove startup message
(setq inhibit-startup-message t)

;; Open TODO.org at startup
;; (find-file "/home/humitos/Dropbox/TODO.org")

;; Save the session
(desktop-save-mode 1)

;; http://gastonramos.wordpress.com/2014/10/09/emacs-show-trailing-whitespace
;; show trailing whitespaces
;; (show-ws-toggle-show-trailing-whitespace)
;; remove trailing whitespaces
;; (global-set-key (kbd "C-c x") 'whitespace-cleanup)

(global-linum-mode -1) ;; disable line numbers globally
;; (setq linum-format "%4d \u2502") ;; line numbers style

;; saves the location of the point when you kill a buffer and returns
;; to it next time you visit the associated file.
(require 'saveplace)
(setq-default save-place t)

;; Mouse yanking inserts at the point instead of the location of the
;; click.
(setq mouse-yank-at-point t)

;; require-final-newline is set to avoid problems with crontabs, etc.
(setq require-final-newline t)

;; prevents stale elisp bytecode from shadowing more up-to-date source
;; files.
(setq load-prefer-newer t)

;; starts emacs maximized
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; show line and column number in the status bar
(setq line-number-mode t)
(setq column-number-mode t)

;; disable C-z (minimize window)
(global-unset-key "\^z")

;; '(show-paren-mode t)

;; remove menu bar
(menu-bar-mode -1)

;; remove scroll bar
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)

;; do not show tooltips for mouse
(tooltip-mode -1)

;; replace text on selected region
(delete-selection-mode 1)

;; highlight current line
(global-hl-line-mode 1)

;; remove tool bar
(tool-bar-mode -1)

;; do not ask for "yes" or "no" but "y" and "n" instead
(defalias 'yes-or-no-p 'y-or-n-p)
