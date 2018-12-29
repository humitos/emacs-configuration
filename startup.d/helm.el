;; https://github.com/emacs-helm/helm
;; http://tuhdo.github.io/helm-intro.html
;; https://github.com/hatschipuh/helm-better-defaults
(use-package helm-swoop
  :disabled
  :after helm
  :config
  (setq helm-swoop-split-with-multiple-windows nil
        helm-swoop-split-direction 'split-window-vertically
        helm-swoop-split-window-function 'helm-default-display-buffer))


;; https://github.com/antham/helm-backup
(use-package helm-backup
  :after helm
  :config
  (setq helm-backup-excluded-entries
        '("/home/humitos/.emacs.d/recentf"
          ))
  :hook
  (after-save . helm-backup-versioning))


(use-package helm-flx
  :pin melpa
  :after (helm flx)
  :config (helm-flx-mode +1))


;; https://github.com/nonsequitur/smex
(use-package smex
  :disabled)
;; https://github.com/ptrv/helm-smex
(use-package helm-smex
  :disabled
  :after (helm smex))


;; https://github.com/emacs-helm/helm-firefox
(use-package helm-firefox
  :commands helm-firefox-bookmarks
  :after helm)


;; https://github.com/bbatsov/helm-projectile
(use-package helm-projectile
  :after (helm projectile)
  :bind
  ("C-c C-f" . helm-projectile-find-file)
  ;; use a simpler shortcut to switch between current project opened buffers
  ("C-c b" . helm-projectile-switch-to-buffer)
  ("C-c p p " . helm-projectile-switch-project)
  :init
  ;; helm-projectile integration
  (helm-projectile-on))


;; https://github.com/yasuyk/helm-flycheck
(use-package helm-flycheck
  :commands helm-flycheck
  :after (helm flycheck))


;; https://github.com/emacs-helm/helm-ls-git
(use-package helm-ls-git
  :after helm
  :bind
  ("C-x f" . helm-browse-project))


;; https://github.com/areina/helm-dash
(use-package helm-dash
  :disabled
  :after helm
  :config
  (setq helm-dash-browser-func 'browse-url-generic)
  (setq helm-dash-docsets-path (concat emacs-user-directory "docsets")))


;; https://github.com/syohex/emacs-helm-pydoc
;; (use-package helm-pydoc
;;  :pin melpa
;;  :after helm)


;;; https://github.com/syohex/emacs-helm-ag
(use-package helm-ag
  :after helm
  :bind
  ;; enable regex search using projectile and helm
  ("C-c C-s" . helm-do-ag-project-root)
  :config
  (setq helm-ag-insert-at-point 'symbol)
  (setq helm-ag-fuzzy-match t)
  (setq helm-ag-use-grep-ignore-list t)
  (setq helm-ag-use-agignore t)

  (if (getenv "DOCKER")
      (setq helm-ag-base-command (concat emacs-user-directory "ack --nocolor --nogroup"))
    (setq helm-ag-base-command "ag --nocolor --nogroup --literal"))
    ;; (setq helm-ag-base-command (concat emacs-user-directory "vendor/the_silver_searcher/" "ag --nocolor --nogroup --literal")))
    ;; (setq helm-ag-base-command "rg --no-heading"))
 )


(use-package helm
  :init
  (require 'helm-config)
  (helm-mode 1)
  :bind
  ("M-x" . helm-M-x)
  ("C-x r b" . helm-filtered-bookmarks)
  ("C-x C-f" . helm-find-files)
  ;; (global-unset-key (kbd "C-c C-f"))
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
  ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
  ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
  ("C-c h" . helm-command-prefix)
  ("C-x c" . nil)
  ("C-x C-b" . helm-bookmarks)
  ;; helm-occur in the buffer (default symbol)
  ("C-c s" . helm-occur)
  :config
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

  (setq helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match    t
        helm-locate-fuzzy-match     t
        helm-M-x-fuzzy-match        t
        helm-semantic-fuzzy-match   t
        helm-imenu-fuzzy-match      t
        helm-apropos-fuzzy-match    t
        helm-lisp-fuzzy-completion  t
        helm-etags-fuzzy-match      nil
        )

  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

  (setq helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
        helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
        helm-ff-file-name-history-use-recentf t)

  ;; disable regex search from elpy
  ;; (global-unset-key (kbd "C-c C-s"))

  ;; the command helm-projects-find-file does a locate in these directories
  (setq helm-locate-project-list
        '("~/mozio/mozio"
          "~/mozio/ondemand"
          "~/mozio/mozio-commons"
          "~/mozio/data-entry"
          ))

  ;; The following snippet will configure helm to always pop up at the
  ;; bottom.
  (setq helm-split-window-in-side-p t)

  (add-to-list 'display-buffer-alist
               '("\\`\\*helm.*\\*\\'"
                 (display-buffer-in-side-window)
                 (inhibit-same-window . t)
                 (window-height . 0.4)))

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

  ;; show relative path when using helm-grep (C-c C-s)
  (setq helm-grep-file-path-style 'relative)
  (setq helm-grep-ignored-directories (add-to-list 'helm-grep-ignored-directories "undohist"))
  (setq helm-grep-ignored-files (add-to-list 'helm-grep-ignored-files "*.orig"))
  (setq helm-grep-preferred-ext ".py")

  ;; When using "C-c h e" match in all the text (including filename)
  (setq helm-etags-match-part-only 'tag)

  ;; Define the length of the helm buffer
  (setq helm-buffer-max-length 50)


  ;; filter this buffers from helm options
  (setq helm-boring-buffer-regexp-list
        '("\\ "
          "\\*helm"
          "\\*Echo Area"
          "\\*Minibuf"
          "\\*epc con"
          "\\*Flycheck"
          "\\*Backtrace"
          "\\*company-documentation"))

  (setq helm-buffers-favorite-modes
        '(python-mode
          web-mode
          rst-mode
          emacs-lisp-mode
          text-mode))
  )
