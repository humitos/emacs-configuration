;; https://github.com/emacs-evil/evil
(use-package evil
  :init
  (setq evil-want-integration nil)
  (evil-mode 1)
  ;; Disable evil on Circe
  (evil-set-initial-state 'circe-mode 'emacs)
  (evil-set-initial-state 'circe-server-mode 'emacs)
  (evil-set-initial-state 'circe-channel-mode 'emacs)
  ;; Disable evil on Timemachig
  (evil-set-initial-state 'git-timemachine-mode 'emacs)
  ;; Disable evil on imenu-list
  (evil-set-initial-state 'imenu-list-mode 'emacs)
  ;; Disable evil on Fundamental buffers
  (evil-set-initial-state 'fundamental-mode 'emacs)
  ;; Disable evil on Help buffers
  (evil-set-initial-state 'help-mode 'emacs)
  ;; Disable evil on Twittering Edit Status
  (evil-set-initial-state 'twittering-edit-mode 'emacs)
  ;; Disable evil on Magithub Edit Status
  (evil-set-initial-state 'magithub-edit-mode 'emacs)
  :bind
  (()
   :map evil-insert-state-map
   ;; use C-g to exit the INSERT mode
   ("C-g" . evil-force-normal-state)
   ;; interferes with yasnippet
   ([tab] . nil)

   :map evil-normal-state-map
   ;; call `helm-find-files' easily from NORMAL mode
   ("g f" . helm-find-files)

   ;; call `helm-mini' easily from NORMAL mode
   ("g b" . helm-mini)

   ;; call `helm-etags-select' easily from NORMAL mode
   ("g t" . helm-etags-select)

   ;; scroll with SPC in NORMAL mode
   ("SPC" . evil-scroll-down)
   ("S-SPC" . evil-scroll-up)

   ;; unset "M-." since it's used in elpy
   ("M-." .  nil))
  :config
  ;; https://github.com/emacs-evil/evil#underscore-_-is-not-a-word-character
  ;; Add the "_" as a word character
  (modify-syntax-entry ?_ "w")
  (setq evil-move-cursor-back nil)
  (setq evil-want-fine-undo t))



;; https://github.com/emacs-evil/evil-collection
(use-package evil-collection
  :after (evil neotree)
  :pin melpa
  :config
  (require 'evil-collection-neotree)
  (evil-collection-neotree-setup)
  ;; quick look with TAB key instead of "g O"
  (evil-define-key 'normal neotree-mode-map (kbd "<tab>") 'neotree-quick-look)

  ;; (require 'evil-collection-helm)
  ;; (evil-collection-helm-setup)
  )


;; https://github.com/hlissner/evil-snipe
(use-package evil-snipe
  :after evil
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1))


;; https://github.com/redguardtoo/evil-matchit
(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))


;; https://github.com/redguardtoo/evil-nerd-commenter
(use-package evil-nerd-commenter
  :after evil
  :config
  ;; Copied this code from `evil-nerd-commenter.el' because the
  ;; `evilnc-default-hotkeys' define some keys that interferes with
  ;; `helm-projectile'
  ;; Default Emacs mode comment key
  (global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)

  ;; Install key bindings for evil
  (eval-after-load 'evil
    '(progn
       (define-key evil-normal-state-map ",ci" 'evilnc-comment-or-uncomment-lines)
       (define-key evil-visual-state-map ",ci" 'evilnc-comment-or-uncomment-lines)
       (define-key evil-normal-state-map ",cl" 'evilnc-quick-comment-or-uncomment-to-the-line)
       (define-key evil-normal-state-map ",ll" 'evilnc-quick-comment-or-uncomment-to-the-line)
       (define-key evil-normal-state-map ",cc" 'evilnc-copy-and-comment-lines)
       (define-key evil-visual-state-map ",cc" 'evilnc-copy-and-comment-lines)
       (define-key evil-normal-state-map ",cp" 'evilnc-comment-or-uncomment-paragraphs)))

       ;; (define-key evil-normal-state-map ",cr" 'comment-or-uncomment-region)
       ;; (define-key evil-normal-state-map ",cv" 'evilnc-toggle-invert-comment-line-by-line)))

  ;; Install operator for evil text objects
  (eval-after-load 'evil-nerd-commenter-operator
    '(progn
       ;; operator to comment at text objects
       (define-key evil-normal-state-map ",." 'evilnc-copy-and-comment-operator)
       (define-key evil-visual-state-map ",." 'evilnc-copy-and-comment-operator)
       (define-key evil-normal-state-map ",," 'evilnc-comment-operator)
       (define-key evil-visual-state-map ",," 'evilnc-comment-operator)

       ;; comment itself is text object
       (define-key evil-inner-text-objects-map evilnc-comment-text-object 'evilnc-inner-comment)
       (define-key evil-outer-text-objects-map evilnc-comment-text-object 'evilnc-outer-commenter)))
    )


;; https://github.com/syohex/emacs-evil-anzu
(use-package evil-anzu
  :after (evil anzu))
