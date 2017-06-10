;; Remove startup message
(setq inhibit-startup-message t)

;; insert-file-contents: Recursive load:
;; "/usr/share/emacs/25.1/lisp/jka-compr.el.gz",
;; "/usr/share/emacs/25.1/lisp/emacs-lisp/debug.el.gz",
;; "/usr/share/emacs/25.1/lisp/jka-compr.el.gz",
;; "/usr/share/emacs/25.1/lisp/jka-compr.el.gz",
;; "/usr/share/emacs/25.1/lisp/jka-compr.el.gz",
;; "/usr/share/emacs/25.1/lisp/jka-compr.el.gz",
;; "/usr/share/emacs/25.1/lisp/hl-line.el.gz"
;; https://github.com/purcell/emacs.d/issues/340
(setq load-file-rep-suffixes '(""))

;; Open TODO.org at startup
;; (find-file "/home/humitos/Dropbox/TODO.org")

;; Save the session
(desktop-save-mode 1)

(setq desktop-base-file-name ".emacs-desktop")

(setq desktop-globals-to-save
      '(
        desktop-missing-file-warning
        ;; tags-file-name
        ;; tags-table-list
        search-ring
        regexp-(setq )earch-ring
        register-alist file-name-history))

;; https://www.emacswiki.org/emacs/Desktop#toc2
(setq desktop-buffers-not-to-save
      (concat "\\("
              "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
              "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
              "\\)$"))
(add-to-list 'desktop-modes-not-to-save 'dired-mode)
(add-to-list 'desktop-modes-not-to-save 'Info-mode)
(add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
(add-to-list 'desktop-modes-not-to-save 'fundamental-mode)

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

;; highlight visualization on parenthesis matching
(show-paren-mode +1)

;; remove menu bar
(menu-bar-mode -1)

;; remove scroll bar
(scroll-bar-mode -1)
;; use `setq' for compatibility with Emacs 24.5.1
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Scroll-Bars.html
(setq horizontal-scroll-bar-mode nil)

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

;; kill the whole line (including new line char) when `kill-line' is
;; ran from the beggining of the line
(setq kill-whole-line t)


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

;; https://github.com/philippe-grenet/exordium
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Do not ask "Keep current list of tags tables also?" when moving to
;; another directory that also have a TAGS file
;; http://emacs.stackexchange.com/questions/14802/never-keep-current-list-of-tags-tables-also
(setq tags-add-tables nil)

;; save the time where emacs started
(setq emacs-start-time (current-time))


;; https://github.com/bbatsov/emacs.d/blob/master/init.el
;; warn when opening files bigger than 10MB
(setq large-file-warning-threshold 1000000)


;; https://github.com/bbatsov/emacs.d/blob/master/init.el
;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; no blinking cursor
(blink-cursor-mode -1)

;; https://github.com/bbatsov/emacs.d/blob/master/init.el
;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; https://github.com/bbatsov/emacs.d/blob/master/init.el
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Need to have this font installed
;; https://github.com/adobe-fonts/source-code-pro
;; (set-frame-font "Source Code Pro-13")

;; My default font
(set-frame-font "Menlo:pixelsize=15")


;; cutting and pasting uses the primary selection
(setq select-enable-primary t)
;; uses the clipboard
(setq select-enable-clipboard t)

;; kill the current buffer instead of asking which one to close
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; increase the line-spacing
(setq-default line-spacing 3)

;; cycle between the mark ring (C-u C-<SPC>) just by C-<SPC>
(setq set-mark-command-repeat-pop t)

;; increase the mark ring
(setq mark-ring-max 200)
