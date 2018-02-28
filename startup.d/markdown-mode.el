;; https://github.com/jrblevin/markdown-mode
(require 'markdown-mode)

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(custom-set-faces
 '(markdown-header-face-1 ((t (:inherit font-lock-function-name-face :weight bold))))
 '(markdown-header-face-2 ((t (:inherit font-lock-function-name-face :weight bold))))
 '(markdown-header-face-3 ((t (:inherit font-lock-function-name-face :weight bold))))
 '(markdown-header-face-4 ((t (:inherit font-lock-function-name-face :weight bold))))
 '(markdown-header-face-5 ((t (:inherit font-lock-function-name-face :weight bold))))
 '(markdown-header-face-6 ((t (:inherit font-lock-function-name-face :weight bold)))))
