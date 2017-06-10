;; https://github.com/company-mode/company-statistics
(require 'company-statistics)
(setq company-statistics-size 10000)
(add-hook 'after-init-hook 'company-statistics-mode)
