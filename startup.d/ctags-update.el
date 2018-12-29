;; https://github.com/jixiuf/ctags-update
(defun turn-on-ctags-if-tags-file ()
  "Enable ctags-update only of there is a TAGS file for this project."
  (let ((tags-file (projectile-expand-root projectile-tags-file-name)))
    (when (file-exists-p tags-file)
      (ctags-auto-update-mode 1))))


(use-package ctags-update
  :hook (python-mode . turn-on-ctags-if-tags-file)
  :after projectile
  :config
  (setq ctags-update-command "ctags")

  (setq ctags-update-other-options (list (concat "--options=" emacs-user-directory ".ctags")))
  (setq ctags-update-delay-seconds 60)) ;; 1 minute
