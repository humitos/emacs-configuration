;; Highlight current line
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Cursor-Display.html#index-highlight-current-line-613
(global-hl-line-mode 1)

;; Highlight brackets
;; http://www.emacswiki.org/emacs/ShowParenMode
(show-paren-mode t)

;; Highlight indentation
;; http://www.emacswiki.org/emacs/HighlightIndentation
(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation)

;; Line numbering
(setq linum-format "%4d")
(global-linum-mode 1)
