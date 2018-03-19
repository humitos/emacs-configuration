;; https://github.com/anachronic/importmagic.el

(require 'importmagic)

(add-hook 'python-mode-hook 'importmagic-mode)

;; disable elpy hotkey to importmagic since it was disabled
;; https://github.com/jorgenschaefer/elpy/issues/1230
(global-unset-key (kbd "C-c RET"))

(setq importmagic-style-configuration-alist
  '((multiline . parentheses)
    (max_columns . 80)))

(define-key importmagic-mode-map (kbd "C-c RET") 'importmagic-fix-symbol-at-point)

