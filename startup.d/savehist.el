(require 'savehist)

;; http://emacs-fu.blogspot.com/2009/05/saving-history-between-sessions.html
;; http://stackoverflow.com/questions/1229142/how-can-i-save-my-mini-buffer-history-in-emacs
(setq savehist-additional-variables
      '(search-ring regexp-search-ring kill-ring))

;; file where to save these things
(setq savehist-file (concat emacs-user-directory "savehist"))

;; activate the mode after configured
(savehist-mode t)
