;; http://web-mode.org/
(use-package web-mode
  :after projectile

  :mode "\\.html?\\'"
  :mode "\\.tmpl?\\'"
  :mode "\\.json?\\'"
  :mode "\\.phtml\\'"
  :mode "\\.tpl\\.php\\'"
  :mode "\\.[agj]sp\\'"
  :mode "\\.as[cp]x\\'"
  :mode "\\.erb\\'"
  :mode "\\.mustache\\'"
  :mode "\\.djhtml\\'"

  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)

  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)

  (setq web-mode-enable-engine-detection t)

  (setq web-mode-engines-alist
        '(("php"    . "\\.phtml\\'")
          ("blade"  . "\\.blade\\.")
          ("django" . "\\.djhtml")))

  ;; Check if we are in a Django project and set web-mode as "django"
  ;; https://github.com/fxbois/web-mode/issues/799
  ;; https://emacs.stackexchange.com/a/32659/16155
  (defun check/django ()
    (if (projectile-project-p)
        (if (file-exists-p (concat (projectile-project-root) "manage.py"))
            (web-mode-set-engine "django")
          (message "Not in Django project") ;; You can safely delet this line
          )
      )
    )
  (add-hook 'web-mode-hook 'check/django)
  )
