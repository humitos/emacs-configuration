;; https://github.com/jaypei/emacs-neotree
(use-package neotree
  :after all-the-icons
  :bind ([f8] . neotree-project-dir)
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))

  ;; every time when the neotree window is opened, it will try to find
  ;; current file and jump to node
  ;; (setq neo-smart-open t)

  ;; specifies the width of the NeoTree window
  (setq neo-window-width 45))

;; https://www.emacswiki.org/emacs/NeoTree#toc11
(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
        (if (neo-global--window-exists-p)
            (progn
              (neotree-dir project-dir)
              (neotree-find file-name)))
      (message "Could not find git project root."))))
