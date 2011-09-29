;; Emacs INIT configuration file

(setenv "PYMACS_PYTHON" "python2.7")

;; Load all emacs modules from a folder
;; https://github.com/fgallina/startupd.el
(add-to-list 'load-path "/home/humitos/.emacs.d")
(require 'startupd)
(setq startupd-path "/home/humitos/.emacs.d/modules/")
(startupd-load-files)

;; Those script are downloaded from
;; https://github.com/errge/emacs-goodies-el
(setq startupd-path "/home/humitos/.emacs.d/modules/emacs-goodies/debian-el/")
(startupd-load-files)
;; (setq startupd-path "/home/humitos/.emacs.d/modules/emacs-goodies/devscripts-el/")
;; (startupd-load-files)
(setq startupd-path "/home/humitos/.emacs.d/modules/emacs-goodies/dpkg-dev-el/")
(startupd-load-files)
;; (setq startupd-path "/home/humitos/.emacs.d/modules/emacs-goodies/gnus-bonus-el/")
;; (startupd-load-files)
;; (setq startupd-path "/home/humitos/.emacs.d/modules/emacs-goodies/vm-bonus-el/")
;; (startupd-load-files)

;; Disabled because casuse an error on Emacs exit
;; (setq startupd-path "/home/humitos/.emacs.d/modules/emacs-goodies/emacs-goodies-el/")
;; (startupd-load-files)


;; Set the color theme
;; https://github.com/bbatsov/zenburn-emacs
;; http://www.emacswiki.org/emacs/ColorThemeZenburn

;; FIXME: I need to auto-accept the question about "Are you sure that
;; you want to excecute the theme Lisp code?"
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'zenburn)

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

;; Flymake for Python : checks your code on-the-fly
;; https://github.com/akaihola/flymake-python
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.emacs.d/pyflymake.py" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; automatically load flymake
(add-hook 'find-file-hook 'flymake-find-file-hook)

;; Adding to the variable the regexps that matches warning messages
;; (setq flymake-log-level 1)

;; disable flymake for HTML
;; http://stackoverflow.com/questions/4095153/how-to-disable-emacs-flymake-for-html-mode
(delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)
(add-hook 'find-file-hook 'flymake-find-file-hook)

;; Key binding to go to Next and Previous error with Flymake
(global-set-key [f10] 'flymake-goto-prev-error)
(global-set-key [f11] 'flymake-goto-next-error)

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
;; (erc-tls :server "chat.freenode.net"
;; 	 :port 7000
;; 	 :nick freenode-nick
;; 	 :password freenode-password
;; 	 :full-name freenode-full-name)


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
     (set-face-foreground 'magit-diff-add "green")
     (set-face-foreground 'magit-diff-del "#700000")
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

;; http://www.emacswiki.org/SmartOperator
;; (require 'smart-operator)
;; (smart-operator-mode 1)

;; http://www.emacswiki.org/emacs/AutoPairs
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers

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

;; Highlight current line
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Cursor-Display.html#index-highlight-current-line-613
(global-hl-line-mode 1)

;; Highlight brackets
;; http://www.emacswiki.org/emacs/ShowParenMode
(show-paren-mode t)

;; Highlight indentation
;; http://www.emacswiki.org/emacs/HighlightIndentation
(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation)

;; Line numbering
(setq linum-format "%4d")
(global-linum-mode 1)

;; Adding hook to automatically open a rope project if there is one
;; in the current or in the upper level directory
;; https://github.com/gabrielelanaro/emacs-for-python/blob/master/epy-python.el#L30
(add-hook 'python-mode-hook
	  (lambda ()
	    (cond ((file-exists-p ".ropeproject")
		   (rope-open-project default-directory))
		  ((file-exists-p "../.ropeproject")
		   (rope-open-project (concat default-directory "..")))
		  ((file-exists-p "../../.ropeproject")
		   (rope-open-project (concat default-directory "../../")))
		  ((file-exists-p "../../../.ropeproject")
		   (rope-open-project (concat default-directory "../../../")))
		  )))


;; Vimrc generic mode
;; http://stackoverflow.com/questions/4236808/syntax-highlight-a-vimrc-file-in-emacs
(define-generic-mode 'vimrc-generic-mode
    '()
    '()
    '(("^[\t ]*:?\\(!\\|ab\\|map\\|unmap\\)[^\r\n\"]*\"[^\r\n\"]*\\(\"[^\r\n\"]*\"[^\r\n\"]*\\)*$"
       (0 font-lock-warning-face))
      ("\\(^\\|[\t ]\\)\\(\".*\\)$"
      (2 font-lock-comment-face))
      ("\"\\([^\n\r\"\\]\\|\\.\\)*\""
       (0 font-lock-string-face)))
    '("/vimrc\\'" "\\.vim\\(rc\\)?\\'")
    '((lambda ()
        (modify-syntax-entry ?\" ".")))
    "Generic mode for Vim configuration files.")
