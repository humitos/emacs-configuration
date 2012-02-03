;; http://jblevins.org/projects/deft/
(when (require 'deft nil 'noerror) 
   (setq
      deft-extension "org"
      deft-directory "~/Org/deft/"
      deft-text-mode 'org-mode)
   (global-set-key (kbd "<f9>") 'deft))
