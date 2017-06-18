;; https://github.com/yasuyk/helm-flycheck
(require 'helm-flycheck)

(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))
