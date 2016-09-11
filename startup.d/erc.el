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

(setq erc-modules '(autoaway autojoin completion log move-to-prompt
		    netsplit spelling hl-nicks keep-place fill
		    button match track readonly networks
		    notifications ring noncommands irccontrols
		    stamp menu list scrolltobottom))

(setq erc-input-line-position -2)

;; Kill the ERC buffers after /quit
(setq erc-kill-server-buffer-on-quit t)
(setq erc-kill-queries-on-quit t)

;; If I post while status is "away", set me as back. (i.e. unset /away)
;; http://home.thep.lu.se/~karlf/emacs.html
(setq erc-auto-discard-away t)

;; https://www.emacswiki.org/emacs/ErcAutoAway
(setq erc-autoaway-idle-seconds 600)

;; Always reconnect
;; https://github.com/vikraman/.emacs.d/blob/master/elisp/erc-init.el
(setq erc-server-auto-reconnect t)
(setq erc-server-reconnect-attempts t)

;; Open query buffers in the current window
(setq erc-query-display 'buffer)

;; Do not ask "Active processes exist; kill them and exit anyway? (yes
;; or no)" for ERC server buffer
;; https://github.com/hendrikvanantwerpen/.emacs.d/blob/master/el-get-user/inits/init-erc.el
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Query-Before-Exit.html
(add-hook 'erc-after-connect
          '(lambda (server nick)
             (set-process-query-on-exit-flag (get-buffer-process (current-buffer)) nil)))

;; Save logs here
(setq erc-log-channels-directory(concat user-emacs-directory "erc/logs/"))

;; Enable logging
(setq erc-enable-logging 'erc-log-all-but-server-buffers)

;; Save log on channel activity
(setq erc-save-buffer-on-part t
      erc-save-queries-on-quit nil
      erc-log-write-after-send t
      erc-log-write-after-insert t)

(setq erc-timestamp-only-if-changed-flag nil
      erc-timestamp-format "%H:%M "
      erc-fill-prefix "      "
      erc-insert-timestamp-function 'erc-insert-timestamp-left)

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
      '(("freenode.net" "#pyar")))

;; https://www.emacswiki.org/emacs/ErcConfiguration
;; use a different prompt
(setq erc-prompt ">>> ")

;; use "_" at the end if the nick is already taken
(setq erc-nick-uniquifier "_")

;; try to connect using a different nickname
(setq erc-try-new-nick-p t)

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

;; do not bother me with useless notifications
;; https://www.emacswiki.org/emacs/ErcChannelTracking
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"))
(setq erc-track-exclude-server-buffer t)

;; connect to the server
(erc-tls :server "irc.freenode.net"
	 :port 7000
	 :nick freenode-nick
	 :password freenode-password
	 :full-name freenode-full-name)


;; https://www.emacswiki.org/emacs/ErcBar
;; display a bar before all the unread messages
(eval-after-load 'erc-track
  '(progn
     (defun erc-bar-move-back (n)
       "Moves back n message lines. Ignores wrapping, and server messages."
       (interactive "nHow many lines ? ")
       (re-search-backward "^.*<.*>" nil t n))

     (defun erc-bar-update-overlay ()
       "Update the overlay for current buffer, based on the content of
erc-modified-channels-alist. Should be executed on window change."
       (interactive)
       (let* ((info (assq (current-buffer) erc-modified-channels-alist))
	      (count (cadr info)))
	 (if (and info (> count erc-bar-threshold))
	     (save-excursion
	       (end-of-buffer)
	       (when (erc-bar-move-back count)
		 (let ((inhibit-field-text-motion t))
		   (move-overlay erc-bar-overlay
				 (line-beginning-position)
				 (line-end-position)
				 (current-buffer)))))
	   (delete-overlay erc-bar-overlay))))

     (defvar erc-bar-threshold 1
       "Display bar when there are more than erc-bar-threshold unread messages.")
     (defvar erc-bar-overlay nil
       "Overlay used to set bar")
     (setq erc-bar-overlay (make-overlay 0 0))
     (overlay-put erc-bar-overlay 'face '(:underline "white"))
     ;;put the hook before erc-modified-channels-update
     (defadvice erc-track-mode (after erc-bar-setup-hook
				      (&rest args) activate)
       ;;remove and add, so we know it's in the first place
       (remove-hook 'window-configuration-change-hook 'erc-bar-update-overlay)
       (add-hook 'window-configuration-change-hook 'erc-bar-update-overlay))
     (add-hook 'erc-send-completed-hook (lambda (str)
					  (erc-bar-update-overlay)))))

;; Rename server buffers to reflect the current network name instead
;; of SERVER:PORT. (e.g. "freenode" instead of "irc.freenode.net:6667"). This
;; is useful when using a bouncer like ZNC where you have multiple
;; connections to the same server.
(setq erc-rename-buffers t)

;; Hide JOIN PART and QUIT server messages from the channel buffer since they are annoying and not so useful
;; http://wiki.xkcd.com/irc/Hide_join_part_messages
;; (setq erc-hide-list '("JOIN" "PART" "QUIT"))
(setq erc-lurker-hide-list '("JOIN" "PART" "QUIT"))
(setq erc-lurker-threshold-time 3600)  ;; hide only if the user was idle for this time

;; switch between current buffer and ERC channel
(defvar erc-previous-buffer nil)
(defun switch-erc-channel-and-back (channel)
  "Switch to ERC CHANNEL buffer and back"
  (let ((current-buffer (current-buffer))
        (channel-buffer (get-buffer channel)))
    (if (eq current-buffer channel-buffer)
        (progn
          (switch-to-buffer erc-previous-buffer))
      (progn
        (setq erc-previous-buffer current-buffer)
        (switch-to-buffer channel-buffer)))))

(defun switch-erc-pyar-and-back ()
  (interactive)
  (switch-erc-channel-and-back "#pyar"))

(global-set-key (kbd "<f12>") 'switch-erc-pyar-and-back)


;; do not move the cursor to the top
;; http://stackoverflow.com/questions/22310357/stop-emacs-erc-from-recentering
(add-to-list 'erc-mode-hook
             (lambda ()
               (set (make-local-variable 'scroll-conservatively) 100)))
