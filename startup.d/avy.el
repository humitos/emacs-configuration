;; https://github.com/abo-abo/avy
(require 'avy)

(setq avy-background t)
;; respect case
(setq avy-case-fold-search nil)
(global-set-key (kbd "C-c C-c") 'avy-goto-char-timer)
