;; https://github.com/justbur/emacs-vdiff
(require 'vdiff)
(define-key vdiff-mode-map (kbd "C-c") vdiff-mode-prefix-map)


;; https://github.com/justbur/emacs-vdiff-magit
(require 'vdiff-magit)
(define-key magit-mode-map "e" 'vdiff-magit-dwim)
(define-key magit-mode-map "E" 'vdiff-magit-popup)
(setcdr (assoc ?e (plist-get magit-dispatch-popup :actions))
        '("vdiff dwim" 'vdiff-magit-dwim))
(setcdr (assoc ?E (plist-get magit-dispatch-popup :actions))
        '("vdiff popup" 'vdiff-magit-popup))

;; This flag will default to using ediff for merges. vdiff-magit does not yet
;; support 3-way merges. Please see the docstring of this variable for more
;; information
;; (setq vdiff-magit-use-ediff-for-merges nil)

;; Whether vdiff-magit-dwim runs show variants on hunks.  If non-nil,
;; vdiff-magit-show-staged or vdiff-magit-show-unstaged are called based on what
;; section the hunk is in.  Otherwise, vdiff-magit-dwim runs vdiff-magit-stage
;; when point is on an uncommitted hunk.  (setq vdiff-magit-dwim-show-on-hunks
;; nil)

;; Whether vdiff-magit-show-stash shows the state of the index.
;; (setq vdiff-magit-show-stash-with-index t)

;; Only use two buffers (working file and index) for vdiff-magit-stage
;; (setq vdiff-magit-stage-is-2way nil)
