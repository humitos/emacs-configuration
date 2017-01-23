(require 'yasnippet)

(setq yas-snippet-dirs
      (list (concat emacs-user-directory "my-snippets")  ;; personal snippets
	    (concat emacs-user-directory "vendor/yasnippet/snippets")     ;; default snippet collection
	    ))
(yas-global-mode 1)

;; (define-key yas-minor-mode-map [(tab)] nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map (kbd "C-i") 'yas-expand)
;; (define-key yas-minor-mode-map (kbd "C-i") nil)
