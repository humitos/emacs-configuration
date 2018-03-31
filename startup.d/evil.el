;; https://github.com/emacs-evil/evil
(use-package evil
  :init
  (setq evil-want-integration nil)
  (evil-mode 1)
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
                                        ;
  :config
  ;; Disable evil on Circe
  (evil-set-initial-state 'circe-mode 'emacs)
  ;; Disable evil on imenu-list
  (evil-set-initial-state 'imenu-list-mode 'emacs)

  (setq evil-move-cursor-back nil)
  (setq evil-want-fine-undo t))



;; https://github.com/emacs-evil/evil-collection
(use-package evil-collection
  :after evil
  :config
  (require 'evil-collection-neotree)
  (evil-collection-neotree-setup)
  ;; quick look with TAB key instead of "g O"
  (evil-define-key 'normal neotree-mode-map
    (kbd "<tab>") 'neotree-quick-look)

  (require 'evil-collection-helm)
  (evil-collection-helm-setup)
  )


;; https://github.com/hlissner/evil-snipe
(use-package evil-snipe
  :after evil
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1))
