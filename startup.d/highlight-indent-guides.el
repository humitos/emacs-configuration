;; https://github.com/DarthFennec/highlight-indent-guides

(require 'highlight-indent-guides)

(setq highlight-indent-guides-method 'character)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
