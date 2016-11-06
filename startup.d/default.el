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

;; use spaces by default to indent
(setq-default indent-tabs-mode nil)

;; load my mate.el script to remind me to drink a mate :)
(load-file (concat emacs-user-directory "mate.el"))

;; set maximun number of kills
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Kill-Ring.html
(setq kill-ring-max 100)


;; It is the opposite of fill-paragraph
;; https://www.emacswiki.org/emacs/UnfillParagraph
(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))

;; Handy key definition
(define-key global-map (kbd "M-Q") 'unfill-paragraph)

;; ispell/aspell presonal dictionary file
(setq ispell-personal-dictionary (concat emacs-user-directory ".ispell.es.pws"))

;; Enable flyspell on rst-mode
(add-hook 'rst-mode-hook (lambda () flyspell-mode))


