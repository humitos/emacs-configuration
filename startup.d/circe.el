;; https://github.com/jorgenschaefer/circe
(require 'circe)

;; Auto-connect / Join to IRC
;; load nick and password from another file
;; http://www.emacswiki.org/emacs/ErcNickserv
(load "~/.ercpass.el")

(setq circe-use-cycle-completion t)

;; hide the join/part spam
;; https://github.com/jorgenschaefer/circe/wiki/Configuration#hiding-the-joinpart-spam
(setq circe-reduce-lurker-spam t)

;; long text paste safer
;; https://github.com/jorgenschaefer/circe/wiki/Configuration#automatic-pasting
(require 'lui-autopaste)
(add-hook 'circe-channel-mode-hook 'enable-lui-autopaste)


;; prompt
;; https://github.com/jorgenschaefer/circe/wiki/Configuration#channel-name-in-the-prompt
(defun my-circe-prompt ()
  (lui-set-prompt
   (concat (propertize ">>>")
           'face 'circe-prompt-face)
           " "))
;; (add-hook 'circe-chat-mode-hook 'my-circe-prompt)

;; (lui-set-prompt (concat (propertize ">>> " 'face 'circe-prompt-face) " "))


;; gray out bot text
;; https://github.com/jorgenschaefer/circe/wiki/Configuration#gray-out-bot-text
(defvar my-circe-bot-list '("lalita"))
(defun my-circe-message-option-bot (nick &rest ignored)
  (when (member nick my-circe-bot-list)
    '((text-properties . (face circe-fool-face
                          lui-do-not-track t)))))
(add-hook 'circe-message-option-functions 'my-circe-message-option-bot)

;; use spanish spellchecker for PyAr
;; https://github.com/jorgenschaefer/circe/wiki/Configuration#spell-checker
(setq lui-flyspell-p t)
(setq lui-flyspell-alist '(("#pyar" "es")
                           ("*" "american")))


;; logging
(setq lui-logging-directory (concat user-emacs-directory "circe/logs/"))
(load "lui-logging" nil t)
(enable-lui-logging-globally)

;; disable linum-mode in circe
(add-hook 'circe-mode-hook
	  '(lambda () (nlinum-mode -1)))

;; track bar for unread messages
(require 'lui-track-bar)
(setq lui-track-bar-behavior 'before-switch-to-buffer)
(enable-lui-track-bar)


;; circe-notifications
;; https://github.com/eqyiel/circe-notifications
(autoload 'enable-circe-notifications "circe-notifications" nil t)

(eval-after-load "circe-notifications"
  '(setq circe-notifications-watch-strings
      '("humitos")))

(add-hook 'circe-server-connected-hook 'enable-circe-notifications)

;; (defun irc-connect ()
;;   (progn
;;     (circe "Freenode")
;;     (delete-other-windows)))

;; (irc-connect)

(setq lui-fill-column 120)


(require 'lui-format)
(require 'lui-irc-colors)
(require 'lui-logging)


(setq circe-format-server-topic "*** Topic change by {userhost}: {topic-diff}")
(setq circe-network-options
      `(("Freenode"
         :nick ,freenode-nick
         :channels ("#pyar" "#readthedocs" "#python")
         :nickserv-password ,freenode-password)))

(circe "Freenode")

