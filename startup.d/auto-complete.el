;; Personal configuration for Autocomplete

;; https://github.com/auto-complete/auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)
(setq-default ac-sources nil)

;; auto-complete for .rst files
(defun my-ac-rst-mode ()
  (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffer))
(add-hook 'rst-mode 'my-ac-rst-mode)

