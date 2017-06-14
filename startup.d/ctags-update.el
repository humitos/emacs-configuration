;; https://github.com/jixiuf/ctags-update
(require 'ctags-update)

(if (getenv "DOCKER")
    (setq ctags-update-command "ctags")
  (setq ctags-update-command (concat emacs-user-directory  "vendor/ctags/ctags")))

(setq ctags-update-other-options (list (concat "--options=" emacs-user-directory ".ctags")))
(setq ctags-update-delay-seconds (* 5 60)) ;; 5 minutes

(defun turn-on-ctags-if-tags-file ()
  "Enable ctags-update only of there is a TAGS file for this project."
  (let ((tags-file (projectile-expand-root projectile-tags-file-name)))
    (when (file-exists-p tags-file)
      (ctags-auto-update-mode 1))))

(add-hook 'elpy-mode-hook 'turn-on-ctags-if-tags-file)
