; save the position inside the file
(setq server-visit-hook (quote (save-place-find-file-hook)))

; end an emacsclient session
(add-hook 'server-switch-hook
	  (lambda ()
	    (when (current-local-map)
	      (use-local-map (copy-keymap (current-local-map))))
	    (when server-buffer-clients
	      (local-set-key (kbd "C-x k") 'server-edit))))

; start the server
(server-start)
