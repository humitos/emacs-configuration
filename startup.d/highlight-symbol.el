(require 'highlight-symbol)

(setq highlight-symbol-idle-delay 0.5)

(setq highlight-symbol-ignore-list
      '("False" "True" "None" "self" "def" "import" "from" "if" "else" "for"
        "while" "class" "print" "and" "not" "is" "param" "type" "rtype" "async"))

(add-hook 'elpy-mode-hook 'highlight-symbol-mode)
