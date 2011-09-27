(setenv "PYMACS_PYTHON" "python2.7")

;; Load all emacs modules from a folder
;; https://github.com/fgallina/startupd.el
(add-to-list 'load-path "/home/humitos/.emacs.d")
(require 'startupd)
(setq startupd-path "/home/humitos/.emacs.d/modules/")
(startupd-load-files)

;; Python Mode
;; python.el ; Fabian Ezequiel Gallina
;; https://github.com/fgallina/python.el
(require 'python)

;; http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode/
;; http://www.emacswiki.org/emacs/InteractivelyDoThings#toc2
;; ido-mode activation
(require 'ido)
(ido-mode 1)

;; Deal with .org files as an agenda
;; org-mode activation
(require 'org-install)

;; http://orgmode.org/worg/org-tutorials/orgtutorial_dto.html
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; (setq org-startup-indented "hidestars odd")

;; Set some differents web modes into the same file depending on the cursor position
;; https://github.com/fgallina/multi-web-mode
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
		  (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
		  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)

;; pyflakes: check the python code on the fly
;; http://plope.com/Members/chrism/flymake-mode
;; http://cvs.savannah.gnu.org/viewvc/*checkout*/emacs/emacs/lisp/progmodes/flymake.el?revision=1.63
(when (load "flymake" t) 
  (defun flymake-pyflakes-init () 
    (let* ((temp-file (flymake-init-create-temp-buffer-copy 
		       'flymake-create-temp-inplace)) 
	   (local-file (file-relative-name 
			temp-file 
			(file-name-directory buffer-file-name)))) 
      (list "pyflakes" (list local-file)))) 
  
  (add-to-list 'flymake-allowed-file-name-masks 
	       '("\\.py\\'" flymake-pyflakes-init))) 

;; disable flymake for HTML
;; http://stackoverflow.com/questions/4095153/how-to-disable-emacs-flymake-for-html-mode
(delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)
(add-hook 'find-file-hook 'flymake-find-file-hook)


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
(setq erc-log-channels-directory "~/.erc/logs/")

;; Save log on part channel
(setq erc-save-buffer-on-part t)

;; Save log on channel activity
(setq erc-save-buffer-on-part nil
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
      '(("freenode.net" "#logn-ar"))) ; "#logn" "#pyar")))
(erc-tls :server "chat.freenode.net" :port 7000 :nick freenode-nick :password freenode-password :full-name freenode-full-name)


;; Ibuffer
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

;; Magit
;; http://www.emacswiki.org/emacs/Magit
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; change magit diff colors
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     (when (not window-system)
       (set-face-background 'magit-item-highlight "black"))))

;; Disable Native VC
(setq vc-handled-backends nil)




;; Autocomplete
;; http://www.emacswiki.org/emacs/download/auto-complete.el
(require 'auto-complete)
(global-auto-complete-mode t)

;; YASnippet
;; http://code.google.com/p/yasnippet/
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")



;; http://www.enigmacurry.com/2009/01/21/autocompleteel-python-code-completion-in-emacs/
;; Initialize Pymacs                                                                                           
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;; Initialize Rope                                                                                             
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;; Initialize Yasnippet                                                                                        
;Don't map TAB to yasnippet                                                                                    
;In fact, set it to something we'll never use because                                                          
;we'll only ever trigger it indirectly.                                                                        
(setq yas/trigger-key (kbd "C-c <kp-multiply>"))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;; ;;; Auto-completion                                                                                            
;; ;;;  Integrates:                                                                                               
;; ;;;   1) Rope                                                                                                  
;; ;;;   2) Yasnippet                                                                                             
;; ;;;   all with AutoComplete.el                                                                                 
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         

(defun prefix-list-elements (list prefix)
  (let (value)
    (nreverse
     (dolist (element list value)
      (setq value (cons (format "%s%s" prefix element) value))))))

(defvar ac-source-rope
  '((candidates
     . (lambda ()
         (prefix-list-elements (rope-completions) ac-target))))
  "Source for Rope")

(defun ac-python-find ()
  "Python `ac-find-function'."
  (require 'thingatpt)
  (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
    (if (null symbol)
        (if (string= "." (buffer-substring (- (point) 1) (point)))
            (point)
          nil)
      symbol)))

(defun ac-python-candidate ()
  "Python `ac-candidates-function'"
  (let (candidates)
    (dolist (source ac-sources)
      (if (symbolp source)
          (setq source (symbol-value source)))
      (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
             (requires (cdr-safe (assq 'requires source)))
             cand)
        (if (or (null requires)
                (>= (length ac-target) requires))
            (setq cand
                  (delq nil
                        (mapcar (lambda (candidate)
                                  (propertize candidate 'source source))
                                (funcall (cdr (assq 'candidates source)))))))
        (if (and (> ac-limit 1)
                 (> (length cand) ac-limit))
            (setcdr (nthcdr (1- ac-limit) cand) nil))
        (setq candidates (append candidates cand))))
    (delete-dups candidates)))

(add-hook 'python-mode-hook
          (lambda ()
                 (auto-complete-mode 1)
                 (set (make-local-variable 'ac-sources)
                      (append ac-sources '(ac-source-rope)))
                 (set (make-local-variable 'ac-find-function) 'ac-python-find)
                 (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
                 (set (make-local-variable 'ac-auto-start) t)))

(global-set-key (kbd "C-x c") 'auto-complete)


;; Ryan's python specific tab completion                                                                        
(defun ryan-python-tab ()
  ; Try the following:                                                                                         
  ; 1) Do a yasnippet expansion                                                                                
  ; 2) Do a Rope code completion                                                                               
  ; 3) Do an indent                                                                                            
  (interactive)
  (if (eql (ac-start) 0)
      (python-indent-line)))

(defadvice ac-start (before advice-turn-on-auto-start activate)
  (set (make-local-variable 'ac-auto-start) t))
(defadvice ac-cleanup (after advice-turn-off-auto-start activate)
  (set (make-local-variable 'ac-auto-start) nil))

(define-key python-mode-map "\t" 'ryan-python-tab)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;; ;;; End Auto Completion                                                                                        
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'auto-complete-python)

;; http://www.emacswiki.org/SmartOperator
;; (require 'smart-operator)
;; (smart-operator-mode 1)

;; http://www.emacswiki.org/emacs/AutoPairs
(require 'autopair)


;; http://www.emacswiki.org/emacs/FlymakeCSS
;; README: look at the bottom of the page, where talk about 'cssutils'
;;         from Python
;; pip install cssutils
(defun flymake-css-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "cssparse" (list local-file))))
(add-to-list 'flymake-allowed-file-name-masks
	     '("\\.css$" flymake-css-init))
(add-to-list 'flymake-err-line-patterns
	     '("\\(.*\\) \\[\\([0-9]+\\):\\([0-9]+\\): \\(.*\\)\\]"
	       nil 2 3 1))
(add-hook 'css-mode-hook
	  (lambda () (flymake-mode t)))


;; A new theme for emacs
;; http://slinky.imukuppi.org/zenburnpage/
;; (require 'zenburn)

;; Changing the Title's Window
;; http://emacs-fu.blogspot.com/2011/01/setting-frame-title.html
(setq frame-title-format
      '("emacs%@" (:eval (system-name)) ": " (:eval (if (buffer-file-name)
							(abbreviate-file-name (buffer-file-name))
						      "%b")) " [%*]"))

;; Unique names for buffer, instead views.py and views.py<2> use views.py:account,
;;   views.py:schedule and views.py:client
;; http://emacs-fu.blogspot.com/2009/11/making-buffer-names-unique.html
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html
(require 'uniquify) 
(setq 
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")


;; Showing Popups
;; http://emacs-fu.blogspot.com/2009/11/showing-pop-ups.html
