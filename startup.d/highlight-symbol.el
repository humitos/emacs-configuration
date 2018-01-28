(require 'highlight-symbol)

(setq highlight-symbol-idle-delay 0.2)

(setq highlight-symbol-ignore-list
      '("False" "True" "None" "self" "def" "import" "from" "if" "else" "for"
        "while" "class" "print" "and" "not" "is" "param" "rtype" "async"
        "with"))

(add-hook 'prog-mode-hook 'highlight-symbol-mode)
