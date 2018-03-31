;; https://github.com/emacs-helm/helm
;; http://tuhdo.github.io/helm-intro.html

;; https://github.com/areina/helm-dash
;; search in dash documentation locally
(use-package helm-dash
  :after helm)


  ;; https://github.com/hatschipuh/helm-better-defaults
(use-package helm-swoop
  :after helm
  :config
  (setq helm-swoop-split-with-multiple-windows nil
        helm-swoop-split-direction 'split-window-vertically
        helm-swoop-split-window-function 'helm-default-display-buffer))


(use-package helm-flx
  :after (helm flx))


(use-package helm-fuzzier
  :after helm)


;; https://github.com/nonsequitur/smex
(use-package smex
  :disabled)
;; https://github.com/ptrv/helm-smex
(use-package helm-smex
  :disabled
  :after (helm smex))


;; https://github.com/emacs-helm/helm-firefox
(use-package helm-firefox
  :after helm)


;; https://github.com/bbatsov/helm-projectile
(use-package helm-projectile
  :after (helm projectile)
  :bind
  ("C-c C-f" . helm-projectile-find-file)
  ;; use a simpler shortcut to switch between current project opened buffers
  ("C-c b" . helm-projectile-switch-to-buffer)
  :config
  ;; helm-projectile integration
  (helm-projectile-on))


(use-package helm
  :config
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
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  (global-set-key (kbd "C-x b") 'helm-mini)
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
  ;; helm-occur in the buffer (default symbol)
  (global-set-key (kbd "C-c s") 'helm-occur)

 ;; the command helm-projects-find-file does a locate in these directories
  (setq helm-locate-project-list
        '("~/mozio/mozio"
          "~/mozio/ondemand"
          "~/mozio/mozio-commons"
          "~/mozio/data-entry"
          ))

  ;; Disable line numbers in helm buffers
  ;; (when nlinum-mode
  ;;   (add-hook 'helm-after-initialize-hook (lambda ()
  ;;                                      (with-helm-buffer
  ;;                                        (nlinum-mode 0)))))


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
  (setq helm-etags-match-part-only 'all)

  ;; Define the length of the helm buffer
  (setq helm-buffer-max-length 50)

  (global-set-key (kbd "C-x C-b") 'helm-bookmarks)

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
  (require 'helm-config))
