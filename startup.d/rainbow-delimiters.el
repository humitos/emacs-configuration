;; Persona configuration for rainbow-delimiters
;; https://github.com/jlr/rainbow-delimiters

(require 'rainbow-delimiters)
;; (global-rainbow-delimiters-mode)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
