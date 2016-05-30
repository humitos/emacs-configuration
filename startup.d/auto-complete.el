;; Personal configuration for Autocomplete

;; https://github.com/auto-complete/auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)
(setq-default ac-sources nil)

;; Disable auto-complete mode on python-mode because it cause problems
;; with company-mode that it's used in elpy
(setq ac-modes (delq 'python-mode ac-modes))
(setq ac-modes (delq 'elpy-mode ac-modes))

;; auto-complete for .rst files
(defun my-ac-rst-mode ()
  (add-to-list 'ac-sources 'ac-source-words-in-same-mode-buffer))
(add-hook 'rst-mode 'my-ac-rst-mode)
