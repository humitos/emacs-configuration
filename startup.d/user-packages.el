;; Packages installed using `use-package'
;; (if the configuration is long enough it has it's own `startup.d/<package>.el' filename)

;; https://github.com/rranelli/auto-package-update.el
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (if (not (getenv "DOCKER"))
      (setq auto-package-update-prompt-before-update t))
  (auto-package-update-maybe))

;; https://github.com/rmuslimov/browse-at-remote
(use-package browse-at-remote
  :pin melpa
  :config
  (setq browse-at-remote-prefer-symbolic nil)
  :bind
  ("C-c g g" . browse-at-remote))


;; https://github.com/emacsmirror/nlinum
(use-package nlinum-hl
  :pin melpa
  :init
  ;; HACK: this needs to be inthe `:init' since it's not updated once
  ;; the mode is enabled
  (setq nlinum-format "%4d \u2502")
  :hook
  ((prog-mode . nlinum-mode)
   (text-mode . nlinum-mode)))

;; https://github.com/domtronn/all-the-icons.el
;; To install the fonts, I ran:
;; M-x all-the-icons-install-fonts
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
  :mode "Dockerfile")


;; https://github.com/magnars/expand-region.el
(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

;; https://github.com/magnars/smart-forward.el
(use-package smart-forward
  :pin melpa
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


;; https://github.com/company-mode/company-mode
(use-package company
  :hook (prog-mode . company-mode)
  :config
  ;; https://github.com/jorgenschaefer/elpy/issues/1015#issuecomment-257070312
  (setq company-minimum-prefix-length 3)

  ;; show quick-access numbers for the first ten candidates (M-<number>
  ;; selects the specific option)
  (setq company-show-numbers t)

  ;; all characters from `company-auto-complete-chars' trigger insertion
  ;; of the selected completion candidate
  (setq company-auto-complete nil)

  (setq company-auto-complete-chars '(?\( ?\) ?.))

  ;; align annotations to the right tooltip border
  (setq company-tooltip-align-annotations t))


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
  :pin melpa
  :after (flx company))


;; https://github.com/lewang/flx
(use-package flx)


; https://github.com/flycheck/flycheck
(use-package flycheck
  :config
  ;; Run flycheck only when the file is saved, idle or new line
  (setq flycheck-check-syntax-automatically '(save idle-change new-line))

  ;; Wait idle seconds before running flycheck
  (setq flycheck-idle-change-delay 2)
  )

;; https://github.com/DarthFennec/highlight-indent-guides
(use-package highlight-indent-guides
  :pin melpa
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character))


;; https://github.com/Fanael/highlight-numbers
(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode))


;; https://github.com/wolray/symbol-overlay
(use-package symbol-overlay
  :hook (prog-mode . symbol-overlay-mode)
  :config
  (setq symbol-overlay-idle-time 0.2))


;; https://github.com/purcell/less-css-mode.git
(use-package less-css-mode)


;; https://github.com/jrblevin/markdown-mode
(use-package markdown-mode
  :mode "\\.text\\'"
  :mode "\\.md\\'"
  :mode "\\.markdown\\'")


;; https://github.com/jaypei/emacs-neotree
(use-package neotree
  :after all-the-icons
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
  :pin melpa
  :hook (python-mode . python-docstring-mode)
  :config
  ;; do not use double spaces when formatting text
  (setq python-docstring-sentence-end-double-space nil))


;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


;; https://github.com/xuchunyang/region-state.el
(use-package region-state
  :pin melpa
  :config
  (region-state-mode +1))

;; https://github.com/pashky/restclient.el
(use-package restclient
  :pin melpa
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
  :pin melpa
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


;; https://github.com/AndreaCrotti/yasnippet-snippets
(use-package yasnippet-snippets
  :after yasnippet)


;; https://github.com/rooney/zencoding
(use-package zencoding-mode
  :pin melpa
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


;; https://github.com/mooz/js2-mode
(use-package js2-mode
  :mode "\\.js\\.")


;; https://github.com/joshwnj/json-mode
(use-package json-mode
  :mode "\\.json\\'")


;; https://github.com/dryman/toml-mode.el
(use-package toml-mode
  :pin melpa
  :mode "\\.toml")


;; https://github.com/galaunay/howdoi.el
(use-package howdoi
  ;; FIXME: doesn't work properly. Answer are not shown at all.
  :disabled)


;; https://github.com/anachronic/importmagic.el
(use-package importmagic
  ;; TODO: re-enable this package when it does not consumes 100% CPU
  ;; immediately a Python file is opened (maybe I can remove the hook)
  ;; :disabled
  ;; :hook (python-mode . importmagic-mode)
  :bind
  (()
   :map python-mode-map
   ("C-c RET" . importmagic-fix-symbol-at-point))
  :config
  (setq importmagic-style-configuration-alist
        '((multiline . parentheses)
          (max_columns . 80))))


;; https://github.com/syohex/emacs-anzu
(use-package anzu
  :config
  (setq anzu-replace-to-string-separator (if (char-displayable-p ?→) " → " " -> "))
  (setq anzu-minimum-input-length 2)
  (define-key isearch-mode-map [remap isearch-query-replace]  #'anzu-isearch-query-replace)
  (define-key isearch-mode-map [remap isearch-query-replace-regexp] #'anzu-isearch-query-replace-regexp)
  (global-anzu-mode +1))


;; https://github.com/magit/git-modes
(use-package gitattributes-mode)
(use-package gitconfig-mode)
(use-package gitignore-mode)


;; https://github.com/Malabarba/aggressive-indent-mode
(use-package aggressive-indent
  :config
  (add-to-list 'aggressive-indent-excluded-modes 'elpy-mode))


;; https://github.com/tarsius/hl-todo
(use-package hl-todo
  :hook (prog-mode . hl-todo-mode))


;; https://github.com/pretty-mode/pretty-mode
(use-package pretty-mode)
