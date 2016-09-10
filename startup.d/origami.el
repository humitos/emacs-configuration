;; https://github.com/gregsexton/origami.el
(require 'origami)

(define-key origami-mode-map (kbd "C-c f a") 'origami-toggle-all-nodes)
;; http://stackoverflow.com/questions/916797/emacs-global-set-key-to-c-tab
(define-key origami-mode-map (kbd "<C-tab>") 'origami-recursively-toggle-node)

(global-origami-mode 1)
