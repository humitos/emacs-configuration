;; Personal configuration for Magit

;; http://www.emacswiki.org/emacs/Magit
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; change magit diff colors
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green")
     (set-face-foreground 'magit-diff-del "#700000")
     (when (not window-system)
       (set-face-background 'magit-item-highlight "black"))))

;; Disable Native VC
(setq vc-handled-backends nil)
