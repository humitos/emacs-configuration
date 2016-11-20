;; Personal configuration for Magit

;; http://www.emacswiki.org/emacs/Magit
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; Magit requires at least GNU Emacs 24.4 and Git 1.9.4.

;; change magit diff colors
;; (eval-after-load 'magit
;;   '(progn
;;      (set-face-foreground 'magit-diff-add "green")
;;      (set-face-foreground 'magit-diff-del "#700000")
;;      (when (not window-system)
;;        (set-face-background 'magit-item-highlight "black"))))

;; Disable Native VC
(setq vc-handled-backends nil)

;; start *Magit* buffer maximized
;; http://stackoverflow.com/a/36603726
(defun display-buffer-full-screen (buffer alist)
  (delete-other-windows)
  (set-window-dedicated-p nil nil)
  (set-window-buffer nil buffer)
  (get-buffer-window buffer))

(setq magit-display-buffer-function
      (lambda (buffer)
        (if magit-display-buffer-noselect
            (magit-display-buffer-traditional buffer)
          (display-buffer buffer '(display-buffer-full-screen)))))

;; try to show differences as diff-highlight (yeah, it's kind of poor)
(setq magit-diff-refine-hunk t)
