;; https://github.com/jorgenschaefer/elpy
(use-package elpy
  ;; Load all Elpy modules
  ;; https://emacs.stackexchange.com/questions/10065/how-can-i-defer-loading-elpy-using-use-package
  :init (elpy-enable)
  :hook (python-mode . elpy-mode)
  :config
  ;; Use rope as backend for Elpy
  ;; (setq elpy-rpc-backend "rope")

  ;; Use jedi as backend for Elpy
  (setq elpy-rpc-backend "jedi")
  ;; Set timeout for backend rpc
  (setq elpy-rpc-timeout 5)

  ;; https://masteringemacs.org/article/compiling-running-scripts-emacs
  (defun python--add-debug-highlight ()
    "Adds a highlighter for '# DEBUG #' string"
    (highlight-lines-matching-regexp "# DEBUG #\\s-*$" 'hi-red-b))
  (add-hook 'python-mode-hook 'python--add-debug-highlight)

  ;; https://emacs.stackexchange.com/a/12403
  ;; show private methods/attributes at the end when suggesting
  (defun company-transform-python (candidates)
    (let ((deleted))
      (mapcar #'(lambda (c)
                  (if (or (string-prefix-p "__" c) (string-prefix-p ".__" c))
                      (progn
                        (add-to-list 'deleted c)
                        (setq candidates (delete c candidates)))))
              candidates)
      (append candidates (nreverse deleted))
      ))
  (append company-transformers '(company-transform-python))


  ;; do not try to guess the indent offset
  ;; Avoid this message: "Can’t guess python-indent-offset, using defaults: 4"
  ;; http://stackoverflow.com/questions/18778894/emacs-24-3-python-cant-guess-python-indent-offset-using-defaults-4
  (setq python-indent-guess-indent-offset nil)


  ;; try to use pyenv for `pyvenv.el'
  (if (not (getenv "DOCKER"))
      (setenv "WORKON_HOME" "/home/humitos/.pyenv/versions"))


  ;; uses the default emacs virtualenv
  (pyvenv-workon "emacs-default")


  ;; Remove highligh-indentation (I use highlight-indent-guides)
  (setq elpy-modules (delete 'elpy-module-highlight-indentation elpy-modules))


  ;; Remove flymake (I use flycheck)
  (setq elpy-modules (delete 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode)

  (message "Elpy Configuration")


  ;; Need to define these here otherwise they are not "undefined"
  ;; helm-ag
  (define-key python-mode-map (kbd "C-c C-s") nil)
  (define-key elpy-mode-map (kbd "C-c C-s") nil)
  ;; disable Flymake unused binds
  (define-key elpy-mode-map (kbd "C-c n") nil)
  (define-key elpy-mode-map (kbd "C-c p") nil)
  ;; disable this to be used by avy
  (define-key elpy-mode-map (kbd "C-c C-c") nil)
  ;; don't call `elpy-find-file' (use `helm-projectile-find-file')
  (define-key python-mode-map (kbd "C-c C-f") nil)
  (define-key elpy-mode-map (kbd "C-c C-f") nil)
  ;; importmagic.el
  (define-key elpy-mode-map (kbd "C-c RET") nil)

  ;; navigate between Flycheck errors (I'm not using Flymake)
  (define-key elpy-mode-map (kbd "C-c C-n") 'flycheck-next-error)
  (define-key elpy-mode-map (kbd "C-c C-p") 'flycheck-previous-error)
  (define-key elpy-mode-map (kbd "<f5>") 'recompile)
  (define-key elpy-mode-map (kbd "C-c C-d") 'helm-pydoc))
