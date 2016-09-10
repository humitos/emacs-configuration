;; https://github.com/gregsexton/origami.el
(require 'origami)

(define-key origami-mode-map (kbd "C-c f a") 'origami-toggle-all-nodes)
(define-key origami-mode-map (kbd "C-c f e") 'origami-recursively-toggle-node)


(global-origami-mode 1)
