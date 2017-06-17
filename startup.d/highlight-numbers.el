(require 'highlight-numbers)

(add-hook 'elpy-mode-hook
          (lambda () (highlight-numbers-mode +1)))
