;; https://github.com/jorgenschaefer/elpy

(use-package python
  :mode ("\\.py" . python-mode)
  :config
  ;; https://github.com/ljos/.emacs.d/blob/master/init.el
  (use-package elpy
    :after (company helm-pydoc flycheck helm-projectile avy yasnippet)
    :commands elpy-enable
    :config
    ;; Run flycheck only when the file is saved, idle or new line
    (setq flycheck-check-syntax-automatically '(save idle-change new-line))

    ;; Wait idle seconds before running flycheck
    (setq flycheck-idle-change-delay 2)

    ;; Use rope as backend for Elpy
    ;; (setq elpy-rpc-backend "rope")

    ;; Use jedi as backend for Elpy
    (setq elpy-rpc-backend "jedi")
    ;; Set timeout for backend rpc
    (setq elpy-rpc-timeout 3)

    ;; https://masteringemacs.org/article/compiling-running-scripts-emacs
    (defun python--add-debug-highlight ()
      "Adds a highlighter for '# DEBUG #' string"
      (highlight-lines-matching-regexp "# DEBUG #\\s-*$" 'hi-red-b))
    (add-hook 'python-mode-hook 'python--add-debug-highlight)

    ;; https://github.com/jorgenschaefer/elpy/issues/1015#issuecomment-257070312
    (setq company-minimum-prefix-length 3)

    ;; show quick-access numbers for the first ten candidates (M-<number>
    ;; selects the specific option)
    (setq company-show-numbers t)

    ;; all characters from `company-auto-complete-chars' trigger insertion
    ;; of the selected completion candidate
    (setq company-auto-complete nil)

    (setq company-auto-complete-chars '(?\( ?\) ?.))

    ;; align annotations to the right tooltip border
    (setq company-tooltip-align-annotations t)


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


    ;; https://stackoverflow.com/questions/2081577/setting-emacs-split-to-horizontal
    ;; split company window horizontally when hitting C-w
    ;; README: the problem this has it's that the company popup disappears :(
    ;; (setq split-height-threshold 0)
    ;; (setq split-width-threshold nil)


    ;; do not try to guess the indent offset
    ;; Avoid this message: "Can’t guess python-indent-offset, using defaults: 4"
    ;; http://stackoverflow.com/questions/18778894/emacs-24-3-python-cant-guess-python-indent-offset-using-defaults-4
    (setq python-indent-guess-indent-offset nil)


    ;; try to use pyenv for `pyvenv.el'
    (if (not (getenv "DOCKER"))
        (setenv "WORKON_HOME" "/home/humitos/.pyenv/versions"))


    ;; uses the default emacs virtualenv
    (pyvenv-workon "emacs-default"))


  (elpy-enable)

  ;; Need to define these here otherwise they are not "undefined"
  ;; helm-ag
  (define-key python-mode-map (kbd "C-c C-s") nil)
  (define-key elpy-mode-map (kbd "C-c C-s") nil)
  ;; disable Flymake unused binds
  (define-key elpy-mode-map (kbd "C-c n") nil)
  (define-key elpy-mode-map (kbd "C-c p") nil)
   ;; disable this to be used by avy
  (define-key elpy-mode-map (kbd "C-c C-c") nil)

  ;; navigate between Flycheck errors (I'm not using Flymake)
  (define-key elpy-mode-map (kbd "C-c C-n") 'flycheck-next-error)
  (define-key elpy-mode-map (kbd "C-c C-p") 'flycheck-previous-error)

  (define-key elpy-mode-map (kbd "<f5>") 'recompile)
  ;; (define-key elpy-mode-map (kbd "M-q") 'python-fill-paragraph)
  (define-key elpy-mode-map (kbd "C-c C-d") 'helm-pydoc)

  (setq elpy-modules (delete 'elpy-module-highlight-indentation elpy-modules))

  ;; Remove flymake and use flycheck
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
