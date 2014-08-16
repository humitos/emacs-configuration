(require 'yasnippet)
(define-key yas-minor-mode-map [(tab)] nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-i") 'yas-expand)

(setq yas-snippet-dirs
      '("~/.emacs.d/my-snippets"                 ;; personal snippets
        "~/.emacs.d/vendor/yasnippet/snippets"   ;; default snippet collection
        ))

(yas-global-mode 1)
