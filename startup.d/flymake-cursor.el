;; Personal configuration for flymake-cursor
;; https://github.com/illusori/emacs-flymake-cursor

(eval-after-load 'flymake '(require 'flymake-cursor))

;; You can customize the behaviour of flymake-cursor.el with the
;; flymake-cursor group in customize mode, or you can edit the
;; following custom variables directly:

;; sets the delay before an error is displayed in the minibuffer.
(setq flymake-cursor-error-display-delay 0)
;; sets how many errors to display in the minibuffer at once.
(setq flymake-cursor-number-of-errors-to-display 2)
;; sets whether flymake-cursor should automatically enable itself whenever flymake is enabled.
(setq flymake-cursor-auto-enable t)
