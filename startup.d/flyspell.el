;; https://www.emacswiki.org/emacs/FlySpell

;; do not emit a message when checking words
(setq flyspell-issue-message-flag nil)

;; do not ask if we want to save the personal dictionary
(setq ispell-silently-savep t)

;; activate flyspell-prog-mode when opening a elpy-mode buffer
(add-hook 'elpy-mode-hook
          (lambda ()
            (set (make-local-variable 'ispell-personal-dictionary) (expand-file-name ".aspell.en.pws" emacs-user-directory))
            (if (not (string= "american" ispell-current-dictionary))
                (progn
                  (ispell-change-dictionary "american")
                  (message "Dictionary switched to English")))
            (flyspell-prog-mode)))


;; enable flyspell (spanish) on rst-mode
(add-hook 'rst-mode-hook
          (lambda ()
            (set (make-local-variable 'ispell-personal-dictionary) (expand-file-name ".aspell.es.pws" emacs-user-directory))
            (if (not (string= "spanish" ispell-current-dictionary))
                (progn
                  (ispell-change-dictionary "spanish")
                  (message "Dictionary switched to Spanish")))
            (flyspell-prog-mode)))
