;; https://www.emacswiki.org/emacs/RecentFiles
(require 'recentf)

;; allow 100 items in the recent file list
(setq recentf-max-menu-items 100)

;; save the list each 5 minutes (default it's when emacs is killed)
;; (run-at-time nil (* 5 60) 'recentf-save-list)

(recentf-mode 1)
