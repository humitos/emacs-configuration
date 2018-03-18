;; https://www.emacswiki.org/emacs/EightyColumnRule
(require 'whitespace)
(setq whitespace-style '(face tabs spaces trailing lines-tail space-before-tab newline indentation empty space-after-tab space-mark tab-mark newline-mark))
(add-hook 'prog-mode-hook 'whitespace-mode)
