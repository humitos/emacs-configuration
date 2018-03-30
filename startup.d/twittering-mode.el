;; https://github.com/hayamiz/twittering-mode
(use-package twittering-mode
             :bind
             ;; launch twittering-mode with F10
             ("<f10>" . 'twit)
             :init
             ;; remove linum-mode in twittering-mode
             ;; (when (require 'nlinum-mode nil 'noerror)
             ;;   (add-hook 'twittering-mode-hook (lambda () (nlinum-mode 0))))
             :config
             ;; https://emacs.stackexchange.com/questions/35138/using-a-master-password-gnupg-with-twittering-mode
             ;; $ gpg --generate-key
             (setq twittering-use-master-password t)

             ;; my personal style of the timeline
             (setq twittering-status-format
                   "%i %FACE[bold]{%S} %RT{(RT)}, %@:\n%FOLD[   ]{%T %r%R%QT{\n+--------------------\n%FOLD[|]{%i %S, %@:\n%FOLD[   ]{%T %r%R}}\n+--------------------}}\n ")

             ;; inherit mentions and hashtags on editing a reply
             (setq twittering-edit-skeleton 'inherit-any)
             )

;; unlock the gpg agent at login
;; https://github.com/cruegge/pam-gnupg
