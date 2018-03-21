;; https://github.com/emacs-evil/evil
(setq evil-want-integration nil)
(require 'evil)

(require 'evil-collection-neotree)
(evil-collection-neotree-setup)
;; quick look with TAB key instead of "g O"
(evil-define-key 'normal neotree-mode-map
  (kbd "<tab>") 'neotree-quick-look)

(require 'evil-collection-helm)
(evil-collection-helm-setup)

;; use C-g to exit the INSERT mode
(define-key evil-insert-state-map (kbd "C-g") 'evil-force-normal-state)

;; call `helm-find-files' easily from NORMAL mode
(define-key evil-normal-state-map (kbd "g f") 'helm-find-files)

;; call `helm-mini' easily from NORMAL mode
(define-key evil-normal-state-map (kbd "g b") 'helm-mini)

;; call `helm-etags-select' easily from NORMAL mode
(define-key evil-normal-state-map (kbd "g t") 'helm-etags-select)

;; scroll with SPC in NORMAL mode
(define-key evil-normal-state-map (kbd "SPC") 'evil-scroll-down)
(define-key evil-normal-state-map (kbd "S-SPC") 'evil-scroll-up)

;; Disable evil on Circe
(evil-set-initial-state 'circe-mode 'emacs)
;; Disable evil on imenu-list
(evil-set-initial-state 'imenu-list-mode 'emacs)

(setq evil-move-cursor-back nil)
(setq evil-want-fine-undo t)

(evil-mode 1)
