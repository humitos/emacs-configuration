(require 'git-gutter)

;; Don't need log/message.
(custom-set-variables
 '(git-gutter:verbosity 0))

;; If you would like to use git-gutter.el and linum-mode
(git-gutter:linum-setup)

(custom-set-variables
 '(git-gutter:unchanged-sign "  ") ;; two spaces
 '(git-gutter:modified-sign "MM")
 '(git-gutter:added-sign "++")     ;; multiple character is OK
 '(git-gutter:deleted-sign "--")

 ;; change name of minor-mode in mode line. first character should be a
 ;; space
 '(git-gutter:lighter " GG")
 )

;; background for solarized theme
(set-face-background 'git-gutter:unchanged "#263238")
(set-face-background 'git-gutter:added "#263238")
(set-face-background 'git-gutter:deleted "#263238")
(set-face-background 'git-gutter:modified "#263238")

;; show git status (add, remove, etc lines) next to the row numbers
(global-git-gutter-mode +1)
