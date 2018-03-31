;; Packages installed using `use-package'
;; (if the configuration is long enough it has it's own `startup.d/<package>.el' filename)

;; https://github.com/rranelli/auto-package-update.el
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (setq auto-package-update-prompt-before-update t)
  (auto-package-update-maybe))

;; https://github.com/rmuslimov/browse-at-remote
(use-package browse-at-remote
  :config
  (setq browse-at-remote-prefer-symbolic nil)
  :bind
  ("C-c g g" . browse-at-remote))

;; https://github.com/emacsmirror/nlinum
(use-package nlinum
  :hook
  ((prog-mode . nlinum-mode)
   (text-mode . nlinum-mode))
  :init
  (setq nlinum-format "%4d \u2502") ;; line numbers style
  )

;; https://github.com/domtronn/all-the-icons.el
;; To install the fonts, I ran:
;; $ cd $HOME/.fonts
;; $ ln -s ../all-the-icons/fonts all-the-icons
(use-package all-the-icons)

;; FIXME: not available in MELPA
;; (use-package any-ini-mode
;;              :mode ("\\.ini\\'" "\\.rc\\'"))


;; https://github.com/abo-abo/avy
(use-package avy
  :bind
  ("C-c C-c" . avy-goto-char-timer)
  :config
  (setq avy-background t)
  ;; respect case
  (setq avy-case-fold-search nil)
  )


;; https://github.com/steckerhalter/discover-my-major
(use-package discover-my-major)


;; https://github.com/spotify/dockerfile-mode
(use-package dockerfile-mode
  :mode "Dockerfile\\'")


;; https://github.com/magnars/expand-region.el
(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

;; https://github.com/magnars/smart-forward.el
(use-package smart-forward
  :bind
  ("C-s-<up>" . smart-up)
  ("C-s-<down>" . smart-down)
  ("C-s-<left>" . smart-backward)
  ("C-s-<right>" . smart-forward))


;; https://github.com/Floobits/floobits-emacs
(use-package floobits)


;; https://github.com/defunkt/gist.el
(use-package gist)


;; https://github.com/pidu/git-timemachine
(use-package git-timemachine)


;; https://github.com/antham/helm-backup
(use-package helm-backup
  :config
  (setq helm-backup-excluded-entries
        '("/home/humitos/.emacs.d/recentf"
          "/home/humitos/mozio/mozio/.*"
          "/home/humitos/mozio/ondemand/.*"
          "/home/humitos/mozio/data-entry/.*"
          ))
  :hook
  (after-save . helm-backup-versioning))


;; https://github.com/expez/company-quickhelp
(use-package company-quickhelp
  :after company)


;; https://github.com/company-mode/company-statistics
(use-package company-statistics
  :after company
  :config
  (setq company-statistics-size 10000))

;; https://github.com/PythonNut/company-flx
(use-package company-flx
  :after flx)


;; https://github.com/lewang/flx
(use-package flx)


;; https://github.com/areina/helm-dash
(use-package helm-dash
  :after helm
  :config
  ;; use firefox to open the documentation
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "firefox")
  (setq helm-dash-browser-func 'browse-url-generic)
  (setq helm-dash-docsets-path (concat emacs-user-directory "docsets")))


;; https://github.com/flycheck/flycheck
(use-package flycheck)

;; https://github.com/yasuyk/helm-flycheck
(use-package helm-flycheck
  :after (helm flycheck))


;; https://github.com/emacs-helm/helm-ls-git
(use-package helm-ls-git
  :bind
  ("C-x f" . helm-browse-project))


;; https://github.com/DarthFennec/highlight-indent-guides
(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character))


;; https://github.com/Fanael/highlight-numbers
(use-package highlight-numbers
  :hook (elpy-mode . highlight-numbers-mode))


;; https://github.com/nschum/highlight-symbol.el
(use-package highlight-symbol
  :hook (prog-mode . highlight-symbol-mode)
  :config
  (setq highlight-symbol-idle-delay 0.2)
  (setq highlight-symbol-ignore-list
        '("False" "True" "None" "self" "def" "import" "from" "if" "else" "for"
          "while" "class" "print" "and" "not" "is" "param" "rtype" "async"
          "with")))


;; https://github.com/purcell/less-css-mode.git
(use-package less-css-mode)


;; https://github.com/jrblevin/markdown-mode
(use-package markdown-mode
  :mode "\\.text\\'"
  :mode "\\.md\\'"
  :mode "\\.markdown\\'")


;; https://github.com/jaypei/emacs-neotree
(use-package neotree
  :bind ([f8] . neotree-toggle)
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))

  ;; every time when the neotree window is opened, it will try to find
  ;; current file and jump to node
  (setq neo-smart-open t)

  ;; specifies the width of the NeoTree window
  (setq neo-window-width 45))


;; https://github.com/Wilfred/pip-requirements.el
(use-package pip-requirements)


;; https://github.com/juergenhoetzel/pkgbuild-mode
(use-package pkgbuild-mode
  :mode "\\PKGBUILD\\'")


;; https://github.com/glyph/python-docstring-mode
(use-package python-docstring
  :hook (python-mode . python-docstring-mode)
  :config
  ;; do not use double spaces when formatting text
  (setq python-docstring-sentence-end-double-space nil))


;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


;; https://github.com/xuchunyang/region-state.el
(use-package region-state
  :config
  (region-state-mode +1))

;; https://github.com/pashky/restclient.el
(use-package restclient
  :mode "\\.restclient\\'")


;; https://github.com/glynnforrest/salt-mode
(use-package salt-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.jinja2\\'" . html-mode))
  (mmm-add-mode-ext-class 'html-mode "\\.jinja2\\'" 'jinja2)

  (add-to-list 'auto-mode-alist '("\\.jinja\\'" . html-mode))
  (mmm-add-mode-ext-class 'html-mode "\\.jinja\\'" 'jinja2))


;; https://github.com/Fuco1/smartparens
(use-package smartparens
  :hook (prog-mode . smartparens-mode))


;; https://github.com/naiquevin/sphinx-doc.el
(use-package sphinx-doc
  :hook (python-mode . sphinx-doc-mode))


;; https://github.com/holomorph/systemd-mode
(use-package systemd
  ;; https://wiki.archlinux.org/index.php/Emacs#Syntax_highlighting_for_systemd_Files
  :mode "\\.service\\'"
  :mode "\\.timer\\'"
  :mode "\\.target\\'"
  :mode "\\.mount\\'"
  :mode "\\.automount\\'"
  :mode "\\.slice\\'"
  :mode "\\.socket\\'"
  :mode "\\.path\\'"
  :mode "\\.netdev\\'"
  :mode "\\.network\\'"
  :mode "\\.link\\'"
  :mode "\\.automount\\'")


;; https://github.com/mcandre/vimrc-mode
(use-package vimrc-mode
  :mode "\\.vim\\(rc\\)?\\'")


;; https://github.com/benma/visual-regexp-steroids.el/
(use-package visual-regexp-steroids
  :bind
  ;; redefine C-M-% to use visual regexp replace
  ("C-M-%" . vr/replace)
  :config
  (setq vr/engine 'python)
  ;; limit number of matches shown in visual feedback
  (setq vr/default-feedback-limit 100))


;; https://github.com/purcell/whitespace-cleanup-mode
(use-package whitespace-cleanup-mode
  :hook (prog-mode rst-mode))


;; https://github.com/yoshiki/yaml-mode
(use-package yaml-mode
  :mode "\\.yml$")

;; https://github.com/joaotavora/yasnippet
(use-package yasnippet
  :config
  ;; (setq yas-snippet-dirs
  ;;       (list (concat emacs-user-directory "my-snippets")  ;; personal snippets
  ;;             ;; (concat emacs-user-directory "vendor/elpy/snippets")     ;; elpy collection
  ;;             (concat emacs-user-directory "vendor/yasnippet/snippets/snippets")     ;; default snippet collection
  ;;             (concat emacs-user-directory "vendor/yasnippet/yasmate/snippets")     ;; default snippet collection
  ;;             ))
  (yas-global-mode 1))


;; https://github.com/rooney/zencoding
(use-package zencoding-mode
  ;; auto-start on any markup modes
  :hook web-mode
  ;; use C-j to expand the option directly instead of showing the
  ;; preview and selecting by hitting RET
  :bind (:map zencoding-mode-keymap
              ("C-j" . zencoding-expand-yas)))


;; https://github.com/ajc/nginx-mode
(use-package nginx-mode
  :mode "/nginx/sites-\\(?:available\\|enabled\\)/")


;; https://github.com/bmag/imenu-list
(use-package imenu-list
  :bind
  ("C-'" . imenu-list-smart-toggle)
  :config
  (setq imenu-list-focus-after-activation t))
