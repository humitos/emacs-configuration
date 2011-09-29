;; Personal configuration for Ibuffer
;; http://www.emacswiki.org/emacs/IbufferMode
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000) (format "%7.3fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000000) (format "%7.3fM" (/ (buffer-size) 1000000.0)))
   (t (format "%8d" (buffer-size)))))

;; Modify the default ibuffer-formats
(setq ibuffer-formats
      '((mark modified read-only " "
	      (name 18 18 :left :elide)
	      " "
	      (size-h 9 -1 :right)
	      " "
	      (mode 16 16 :left :elide)
	      " "
	      filename-and-process)))

;; Group ibuffers
;; http://emacs-fu.blogspot.com/2010/02/dealing-with-many-buffers-ibuffer.html
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("Org" ;; all org-related buffers
		(mode . org-mode))
	       ("Mail"
		(or  ;; mail-related buffers
		 (mode . message-mode)
		 (mode . mail-mode)
		 ;; etc.; all your mail related modes
		 ))
	       ("Python"
		(mode . python-mode))
	       ("HTML"
		(mode . html-mode))
	       ("Javascript"
		(mode . js-mode))
	       ("CSS"
		(mode . css-mode))
	       ("Emacs"
		(mode . emacs-lisp-mode))
	       ;; ("Programming" ;; prog stuff not already in MyProjectX
	       ;; 	(or
	       ;; 	 (mode . c-mode)
	       ;; 	 (mode . perl-mode)
	       ;; 	 (mode . python-mode)
	       ;; 	 (mode . emacs-lisp-mode)
	       ;; 	 ;; etc
	       ;; 	 ))
	       ("ERC"   (mode . erc-mode))
	       ))))

;; Apply deafult ibuffer grouping
(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))
