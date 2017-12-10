;; https://github.com/glynnforrest/salt-mode
;; https://github.com/glynnforrest/mmm-jinja2

(require 'salt-mode)
(require 'mmm-jinja2)

(add-to-list 'auto-mode-alist '("\\.jinja2\\'" . html-mode))
(mmm-add-mode-ext-class 'html-mode "\\.jinja2\\'" 'jinja2)

(add-to-list 'auto-mode-alist '("\\.jinja\\'" . html-mode))
(mmm-add-mode-ext-class 'html-mode "\\.jinja\\'" 'jinja2)
