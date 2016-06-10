;; Personal configuration for ERC

;; Using ERC as IRC Client inside Emacs
;; http://www.emacswiki.org/emacs/ERC
;; http://www.emacswiki.org/emacs/ErcSSL
(require 'tls)
(require 'erc)

;; Using SSL to connect to freenode.net because of my ISP
(setq tls-program '("openssl s_client -connect %h:%p -no_ssl2 -ign_eof
                                      -CAfile /etc/ssl/certs
                                      -cert /etc/ssl/certs" ))

;; Save logs here
(setq erc-log-channels-directory "~/.emacs.d/erc/logs/")

;; Save log on channel activity
(setq erc-save-buffer-on-part t
      erc-save-queries-on-quit nil
      erc-log-write-after-send t
      erc-log-write-after-insert t)

;; Don't ask me if I want to save the logs when I leave emacs
(defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
(save-some-buffers t (lambda () (when (eq major-mode 'erc-mode) t))))

;; Auto-connect / Join to IRC
;; load nick and password from another file
;; http://www.emacswiki.org/emacs/ErcNickserv
(load "~/.ercpass.el")

;; Content of "~/.ercpass.el"
;; (setq freenode-password "your-password-goes-here")
;; (setq freenode-nick "your-password-goes-here")
;; (setq freenode-full-name "your-password-goes-here")

(setq erc-autojoin-channels-alist
      '(("freenode.net" "#pyar"))) ; "#logn" "#pyar")))

(erc-tls :server "irc.freenode.net"
	 :port 7000
	 :nick freenode-nick
	 :password freenode-password
	 :full-name freenode-full-name)

;; https://www.emacswiki.org/emacs/ErcConfiguration
;; use a different prompt
(setq erc-prompt ">>> ")

;; disable linum-mode in erc-mode
(add-hook 'erc-mode-hook
	  '(lambda () (linum-mode -1)))

;; connect to channels in background instead of showing the buffer
;; immediately
(setq erc-join-buffer 'bury)

;; buttonize unproper URLs
(setq erc-button-url-regexp
      "\\([-a-zA-Z0-9_=!?#$@~`%&*+\\/:;,]+\\.\\)+[-a-zA-Z0-9_=!?#$@~`%&*+\\/:;,]*[-a-zA-Z0-9\\/]")


;; https://www.emacswiki.org/emacs/ErcFilling
;; use a width of 120 lines
(setq erc-fill-column 120)

;; colorize nicknames
;; https://github.com/leathekd/erc-hl-nicks
(require 'erc-hl-nicks)
