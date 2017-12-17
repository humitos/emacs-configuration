;; https://www.gnu.org/software/emacs/manual/html_mono/ediff.html

;; https://oremacs.com/2015/01/17/setting-up-ediff/

;; Don't use the weird setup with the control panel in a separate frame
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Split the windows horizontally instead of vertically
(setq ediff-split-window-function 'split-window-horizontally)

;; Restoring the windows after Ediff quits
(winner-mode)
(add-hook 'ediff-after-quit-hook-internal 'winner-undo)
