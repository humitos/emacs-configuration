;; http://tuhdo.github.io/helm-intro.html

(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (global-unset-key (kbd "C-c C-f"))
(define-key elpy-mode-map (kbd "C-c C-f") 'helm-projectile-find-file)
(global-set-key (kbd "C-c C-f") 'helm-projectile-find-file)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t
      helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t
      helm-locate-fuzzy-match     t
      helm-M-x-fuzzy-match        t
      helm-semantic-fuzzy-match   t
      helm-imenu-fuzzy-match      t
      helm-apropos-fuzzy-match    t
      helm-lisp-fuzzy-completion  t
      helm-etags-fuzzy-match      t
      )

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      ;; helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

;; helm-projectile integration
(require 'helm-projectile)
(helm-projectile-on)

;; disable regex search from elpy
(global-unset-key (kbd "C-c C-s"))
;; enable regex search using projectile and helm
(global-set-key (kbd "C-c C-s") 'helm-projectile-ag)
(define-key elpy-mode-map (kbd "C-c C-s") 'helm-projectile-ag)

;; helm-occur in the buffer (default symbol)
(global-set-key (kbd "C-c s") 'helm-occur)


;; TODO: this is valid for helm-ag not for helm-projectile-ag
;; https://github.com/syohex/emacs-helm-ag
(setq helm-ag-insert-at-point 'symbol)
(setq helm-ag-fuzzy-match t)
(setq helm-ag-use-grep-ignore-list t)
(setq helm-ag-use-agignore t)

(if (not (getenv "DOCKER"))
    (setq helm-ag-base-command (concat emacs-user-directory "vendor/the_silver_searcher/" "ag --nocolor --nogroup")))

;; the command helm-projects-find-file does a locate in these directories
(setq helm-locate-project-list
      '("~/mozio/mozio"
	"~/mozio/ondemand"
	"~/mozio/mozio-commons"
	"~/mozio/data-entry"
	))

;; firefox bookmarks in helm
(require 'helm-firefox)

;; Disable line numbers in helm buffers
(when linum-mode
  (add-hook 'helm-after-initialize-hook (lambda ()
					  (with-helm-buffer
					    (linum-mode 0)))))


;; https://github.com/hatschipuh/helm-better-defaults
(require 'helm-swoop)
(require 'helm-flx)
(helm-flx-mode +1)
(require 'helm-fuzzier)
(helm-fuzzier-mode 1)

;; (require 'smex)
;; (require 'helm-smex)
;; (global-set-key [remap execute-extended-command] #'helm-smex)
;; (global-set-key (kbd "M-X") #'helm-smex-major-mode-commands)

;; The following snippet will configure helm to always pop up at the
;; bottom.
(setq helm-split-window-in-side-p t)

(add-to-list 'display-buffer-alist
             '("\\`\\*helm.*\\*\\'"
               (display-buffer-in-side-window)
               (inhibit-same-window . t)
               (window-height . 0.4)))

(setq helm-swoop-split-with-multiple-windows nil
      helm-swoop-split-direction 'split-window-vertically
      helm-swoop-split-window-function 'helm-default-display-buffer)

;; The following snippet will let you provide input in the header line
;; and hide the mode-lines above.
;; (setq helm-echo-input-in-header-line t)

;; (defvar bottom-buffers nil
;;   "List of bottom buffers before helm session.
;;     Its element is a pair of `buffer-name' and `mode-line-format'.")

;; (defun bottom-buffers-init ()
;;   (setq-local mode-line-format (default-value 'mode-line-format))
;;   (setq bottom-buffers
;;         (cl-loop for w in (window-list)
;;                  when (window-at-side-p w 'bottom)
;;                  collect (with-current-buffer (window-buffer w)
;;                            (cons (buffer-name) mode-line-format)))))


;; (defun bottom-buffers-hide-mode-line ()
;;   (setq-default cursor-in-non-selected-windows nil)
;;   (mapc (lambda (elt)
;;           (with-current-buffer (car elt)
;;             (setq-local mode-line-format nil)))
;;         bottom-buffers))


;; (defun bottom-buffers-show-mode-line ()
;;   (setq-default cursor-in-non-selected-windows t)
;;   (when bottom-buffers
;;     (mapc (lambda (elt)
;;             (with-current-buffer (car elt)
;;               (setq-local mode-line-format (cdr elt))))
;;           bottom-buffers)
;;     (setq bottom-buffers nil)))

;; (defun helm-keyboard-quit-advice (orig-func &rest args)
;;   (bottom-buffers-show-mode-line)
;;   (apply orig-func args))


;; (add-hook 'helm-before-initialize-hook #'bottom-buffers-init)
;; (add-hook 'helm-after-initialize-hook #'bottom-buffers-hide-mode-line)
;; (add-hook 'helm-exit-minibuffer-hook #'bottom-buffers-show-mode-line)
;; (add-hook 'helm-cleanup-hook #'bottom-buffers-show-mode-line)
;; (advice-add 'helm-keyboard-quit :around #'helm-keyboard-quit-advice)


;; The header lines for the sources are only useful if there are more
;; then a single source. The following snippet will hide the header
;; line if there is only one.
(setq helm-display-header-line nil)

(defvar helm-source-header-default-background (face-attribute 'helm-source-header :background))
(defvar helm-source-header-default-foreground (face-attribute 'helm-source-header :foreground))
(defvar helm-source-header-default-box (face-attribute 'helm-source-header :box))

(defun helm-toggle-header-line ()
  (if (> (length helm-sources) 1)
      (set-face-attribute 'helm-source-header
                          nil
                          :foreground helm-source-header-default-foreground
                          :background helm-source-header-default-background
                          :box helm-source-header-default-box
                          :height 1.0)
    (set-face-attribute 'helm-source-header
                        nil
                        :foreground (face-attribute 'helm-selection :background)
                        :background (face-attribute 'helm-selection :background)
                        :box nil
                        :height 0.1)))


(add-hook 'helm-before-initialize-hook 'helm-toggle-header-line)


;; And finally this will hide the minibuffer while helm is active
(defun helm-hide-minibuffer-maybe ()
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
                              `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))

(add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe)


;; The following snippet will advice the helm source function to enable the flx fuzzy match in all sources.
;; (defun my-helm-make-source (f &rest args)
;;   (nconc args '(:fuzzy-match t))
;;   (apply f args))

;; (advice-add 'helm-make-source :around 'my-helm-make-source)

;; show relative path when using helm-grep (C-c C-s)
(setq helm-grep-file-path-style 'relative)
(setq helm-grep-ignored-directories (add-to-list 'helm-grep-ignored-directories "undohist"))
(setq helm-grep-ignored-files (add-to-list 'helm-grep-ignored-files "*.orig"))
(setq helm-grep-preferred-ext ".py")


;; search in dash documentation locally
(require 'helm-dash)


;; When using "C-c h e" match in all the text (including filename)
(setq helm-etags-match-part-only 'all)

;; Define the length of the helm buffer
(setq helm-buffer-max-length 50)
