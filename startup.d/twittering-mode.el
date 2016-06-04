(require 'twittering-mode)
(setq twittering-use-master-password t)

;; my personal style of the timeline
(setq twittering-status-format
      "%i %RT{(RT)} %FACE[bold]{%S},  %@:\n%FOLD[  ]{%T %r%R%QT{\n+----\n%FOLD[|]{%i %S,  %@:\n%FOLD[  ]{%T %r%R}}\n+----}}\n ")

;; remove linum-mode in twittering-mode
(add-hook 'twittering-mode-hook (lambda () (linum-mode 0)))
