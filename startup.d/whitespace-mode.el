;; https://www.emacswiki.org/emacs/EightyColumnRule
(use-package whitespace
  :hook (prog-mode . whitespace-mode)
  :config
  (setq whitespace-style '(face tabs spaces trailing lines-tail space-before-tab newline indentation empty space-after-tab space-mark tab-mark newline-mark)))
