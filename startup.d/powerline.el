(defun vc-branch ()
  "Get git branch."
  (if (stringp vc-mode)
      (let ((b (replace-regexp-in-string (format "^ %s" (vc-backend buffer-file-name)) " " vc-mode)))
	(if (string-match "[:@]" b)
	    (format "[] %s " (substring b 2))
	  " "
	  ))
    " "))

(require 'powerline)
(powerline-default-theme)
