;; https://github.com/rooney/zencoding
(require 'zencoding-mode)

;; auto-start on any markup modes
(add-hook 'web-mode-hook 'zencoding-mode)

;; use C-j to expand the option directly instead of showing the
;; preview and selecting by hitting RET
(define-key zencoding-mode-keymap (kbd "C-j") 'zencoding-expand-yas)
