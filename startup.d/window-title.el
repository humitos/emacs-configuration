;; Changing the Title's Window
;; http://emacs-fu.blogspot.com/2011/01/setting-frame-title.html
(setq frame-title-format
      '((:eval (if (buffer-file-name)
		   (abbreviate-file-name (buffer-file-name))
		 "%b"))))
