;; https://www.emacswiki.org/emacs/RecentFiles
(require 'recentf)

;; allow 15 menu items in the recent file list
(setq recentf-max-menu-items 35)
(setq recentf-max-saved-items 500)

;; https://github.com/bbatsov/emacs.d/blob/master/init.el
;; disable recentf-cleanup on Emacs start, because it can cause
;; problems with remote files
(setq recentf-auto-cleanup 'never)

;; save the list each 5 minutes (default it's when emacs is killed)
;; (run-at-time nil (* 5 60) 'recentf-save-list)

(recentf-mode +1)
