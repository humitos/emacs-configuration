;; Test to automate build

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
      '("humitos" "manuel" "kaufmann" "argenpython" "argentina en python" "Argentina en Python")))

(add-hook 'circe-server-connected-hook 'enable-circe-notifications)

;; (defun irc-connect ()
;;   (progn
;;     (circe "Freenode")
;;     (delete-other-windows)))

;; (irc-connect)

(setq lui-fill-column 80)

;; Fluid-width windows
;; https://github.com/jorgenschaefer/circe/wiki/Configuration#fluid-width-windows
(setq
 lui-time-stamp-position 'right-margin
 lui-fill-type nil)

(setf (cdr (assoc 'continuation fringe-indicator-alist)) nil)
(defun my-lui-setup ()
  (setq
   fringes-outside-margins t
   right-margin-width 15
   word-wrap t
   wrap-prefix "    "))
(add-hook 'lui-mode-hook 'my-lui-setup)

;; https://github.com/jorgenschaefer/circe/wiki/Configuration#tab-completion
(setq helm-mode-no-completion-in-region-in-modes
      '(circe-channel-mode
        circe-query-mode
        circe-server-mode))

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

;; switch between current buffer and CIRCE channel
(defvar circe-previous-buffer nil)
(defun switch-circe-channel-and-back (channel)
  "Switch to CIRCE CHANNEL buffer and back"
  (let ((current-buffer (current-buffer))
        (channel-buffer (get-buffer channel)))
    (if (eq current-buffer channel-buffer)
        (progn
          (switch-to-buffer circe-previous-buffer))
      (progn
        (setq circe-previous-buffer current-buffer)
        (switch-to-buffer channel-buffer)))))

(defun switch-circe-pyar-and-back ()
  (interactive)
  (switch-circe-channel-and-back "#pyar"))

(defun switch-circe-rtfd-and-back ()
  (interactive)
  (switch-circe-channel-and-back "#readthedocs"))

(global-set-key (kbd "<f12>") 'switch-circe-pyar-and-back)
(global-set-key (kbd "S-<f12>") 'switch-circe-rtfd-and-back)
