;; Personal configuration for org-mode

;; Deal with .org files as an agenda
;; org-mode activation
(require 'org-install)

;; http://orgmode.org/worg/org-tutorials/orgtutorial_dto.html
;; The following lines are always needed.  Choose your own keys.
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; (setq org-startup-indented "hidestars odd")
