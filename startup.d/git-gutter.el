;; show git status (add, remove, etc lines) next to the row numbers
(global-git-gutter-mode +1)


;; Hide gutter if there are no changes
(custom-set-variables
 '(git-gutter:hide-gutter nil))

;; Don't need log/message.
(custom-set-variables
 '(git-gutter:verbosity 0))

;; If you would like to use git-gutter.el and linum-mode
;; (git-gutter:linum-setup)

(custom-set-variables
 '(git-gutter:modified-sign "MM") ;; two space
 '(git-gutter:added-sign "++")    ;; multiple character is OK
 '(git-gutter:deleted-sign "--"))

;; change name of minor-mode in mode line. first character should be a
;; space
(custom-set-variables
 '(git-gutter:lighter " GG"))


(custom-set-variables
 '(git-gutter:unchanged-sign "  "))
;; background for solarized theme
(set-face-background 'git-gutter:unchanged "#263238")
(set-face-background 'git-gutter:added "#263238")
(set-face-background 'git-gutter:deleted "#263238")
(set-face-background 'git-gutter:modified "#263238")
