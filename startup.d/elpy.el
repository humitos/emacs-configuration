;; https://github.com/jorgenschaefer/elpy
(use-package elpy
  :after (company helm-pydoc flycheck)
  :bind
  (()
   :map elpy-mode-map
   ;; navigate between Flycheck errors (I'm not using Flymake)
   ("C-c C-n" . flycheck-next-error)
   ("C-c C-p" . flycheck-previous-error)
   ;; disable the old ones
   ("C-c n" . nil)
   ("C-c p" . nil)

   ;; disable find-file-in-project because of helm
   ("C-c C-f" . nil)

   ;; disable elpy-rgrep-symbol of helm
   ("C-c C-s" . nil)

   ;; disable this to be used by avy
   ("C-c C-c" . nil)

   ("<f5>" . recompile)
   ("M-q" . python-fill-paragraph)

   :map python-mode-map
   ;; helm-pydoc: https://github.com/syohex/emacs-helm-pydoc
   ("C-c C-d" . helm-pydoc)

   ("C-c C-c" . nil))

  :config
  (setq elpy-modules (delete 'elpy-module-highlight-indentation elpy-modules))

  ;; Remove flymake and use flycheck
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))

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

  ;; enable newline-and-indent on return
  ;; (define-key global-map (kbd "RET") 'newline-and-indent)


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


  ;; set the proper PYTHONPATH for elpy (Python module comes included in the source code)
  ;; (setq elpy-rpc-pythonpath (concat emacs-user-directory "vendor/elpy"))

  ;; try to use pyenv for `pyvenv.el'
  (if (not (getenv "DOCKER"))
      (setenv "WORKON_HOME" "/home/humitos/.pyenv/versions"))


  ;; uses the default emacs virtualenv
  (pyvenv-workon "emacs-default")

  (elpy-enable))


;; https://github.com/syohex/emacs-helm-pydoc
(use-package helm-pydoc
  :after helm)
