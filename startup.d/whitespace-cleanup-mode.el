;; https://github.com/purcell/whitespace-cleanup-mode
(require 'whitespace-cleanup-mode)

;; this doesn't enable it globally
;; (whitespace-cleanup-mode 1)

;; enable this plugin by mode
(add-hook 'python-mode-hook 'whitespace-cleanup-mode)
(add-hook 'web-mode-hook 'whitespace-cleanup-mode)
(add-hook 'rst-mode-hook 'whitespace-cleanup-mode)
