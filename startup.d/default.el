;; Remove startup message
(setq inhibit-startup-message t)

;; Open TODO.org at startup
(find-file "/home/humitos/Dropbox/TODO.org")

;; Save the session
(desktop-save-mode 1)


;; http://gastonramos.wordpress.com/2014/10/09/emacs-show-trailing-whitespace
;; show trailing whitespaces
;; (show-ws-toggle-show-trailing-whitespace)
;; remove trailing whitespaces
;; (global-set-key (kbd "C-c x") 'whitespace-cleanup)
