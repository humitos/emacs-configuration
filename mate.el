;; TODO list:
;; 1. add ability to call it interactively
;; 2. add ability to say another thing
;; 3. add ability to view all the list of timer
;; 4. add ability to stop each of them
;; 5. add ability to stop all at once
;; 6. add ability to do not repeat the alert
;; 7. use different variables for espeak cmd, notify-send, icon, notify-timer and language


(global-set-key (kbd "C-c m") 'mate-start-stop)

(defun mate-start-stop ()
  "Start or stop the current timer"
  (interactive)
  (if (eq mate-say-cancel-id nil)
      (progn
	(mate-say-start)
	(message "Mate: Timer started."))
    (progn
      (mate-say-stop)
      (setq mate-say-cancel-id nil)
      (message "Mate: Timer stopped."))))

(defun mate-say (notify)
  "Use espeak to say 'mate' and show a notification using 'notify' if NOTIFY"
  (call-process "espeak" nil 0 nil "-v" "es" "Mate")
  (if (eq notify t)
      (call-process "notify-send" nil 0 nil "-i" "terminal" "-t" "3000" "Mate" "Cebar un mate")))

(defvar mate-say-cancel-id nil
  "ID of the timer to be cancelled")

(defun mate-say-start ()
  "Start the timer to call `mate-say` function"
  (setq mate-say-cancel-id (run-with-timer nil 180 'mate-say t)))

(defun mate-say-stop ()
  "Cancel the timer to stop calling `mate-say` function"
  (cancel-timer mate-say-cancel-id))
