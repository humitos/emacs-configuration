;; https://github.com/emacsmirror/nlinum
(require 'nlinum)

;; enable line numbers globally
;; (global-nlinum-mode t)

;; enable nlinum in prog and text mode only
(add-hook 'prog-mode-hook 'nlinum-mode)
(add-hook 'text-mode-hook 'nlinum-mode)

(setq nlinum-format "%4d \u2502") ;; line numbers style
