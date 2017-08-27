(require 'server)

;; save the position inside the file
(setq server-visit-hook (quote (save-place-find-file-hook)))

;; end an emacsclient session
(add-hook 'server-switch-hook
	  (lambda ()
	    (when (current-local-map)
	      (use-local-map (copy-keymap (current-local-map))))
	    (when server-buffer-clients
	      (local-set-key (kbd "C-x k") 'server-edit))))


;; start the server
;; `emacs --daemon` in /home/humitos/.config/autostart/emacs-server.desktop
;;
;; [Desktop Entry]
;; Hidden=false
;; StartupNotify=true
;; Type=Application
;; Comment=Emacs Server (daemon)
;; Terminal=true
;; GenericName=Emacs Server
;; X-GNOME-Autostart-enabled=true
;; Version=1.0
;; Categories=Utility;
;; Exec=emacs --daemon
;; Name=Emacs Server
(if (not (server-running-p))
    (server-start))
