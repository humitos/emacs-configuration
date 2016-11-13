(require 'elpy)
(elpy-enable)

;; Remove flymake and use flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Run flycheck only when the file is saved
(setq flycheck-check-syntax-automatically '(save))

;; Use rope as backend for Elpy
;; (setq elpy-rpc-backend "rope")

;; Use jedi as backend for Elpy
(setq elpy-rpc-backend "jedi")
;; Set timeout for backend rpc
(setq elpy-rpc-timeout 3)

;; https://github.com/kpurdon/kp-emacs/blob/master/development/_python.el
;; enable autopep8 formatting on save
;; ignoring:
;; - E501 - Try to make lines fit within --max-line-length characters.
;; - W293 - Remove trailing whitespace on blank line.
;; - W391 - Remove trailing blank lines.
;; - W690 - Fix various deprecated code (via lib2to3).
(require 'py-autopep8)
(setq py-autopep8-options '("--ignore=E501,W391"))
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;; enable newline-and-indent on return
;; (define-key global-map (kbd "RET") 'newline-and-indent)

;; navigate between Flycheck errors (I'm not using Flymake)
(define-key elpy-mode-map (kbd "C-c C-n") 'flycheck-next-error)
(define-key elpy-mode-map (kbd "C-c C-p") 'flycheck-previous-error)
;; disable the old ones
(define-key elpy-mode-map (kbd "C-c n") nil)
(define-key elpy-mode-map (kbd "C-c p") nil)

;; disable find-file-in-project because of helm
(define-key elpy-mode-map (kbd "C-c C-f") nil)

;; https://masteringemacs.org/article/compiling-running-scripts-emacs
(defun python--add-debug-highlight ()
  "Adds a highlighter for '# DEBUG #' string"
  (highlight-lines-matching-regexp "# DEBUG #\\s-*$" 'hi-red-b))
(add-hook 'python-mode-hook 'python--add-debug-highlight)

;; https://github.com/jorgenschaefer/elpy/wiki/Customizations#an-alternative-to-elpy-goto-definition
(defun elpy-goto-definition-or-rgrep ()
  "Go to the definition of the symbol at point, if found. Otherwise, run `elpy-rgrep-symbol'."
    (interactive)
    (ring-insert find-tag-marker-ring (point-marker))
    (condition-case nil (elpy-goto-definition)
        (error (elpy-rgrep-symbol
		(concat "\\(def\\|class\\)\s" (thing-at-point 'symbol) "(")))))

;; https://github.com/jorgenschaefer/elpy/issues/1015#issuecomment-257070312
(setq company-minimum-prefix-length 2)

;; do not try to guess the indent offset
;; Avoid this message: "Can’t guess python-indent-offset, using defaults: 4"
;; http://stackoverflow.com/questions/18778894/emacs-24-3-python-cant-guess-python-indent-offset-using-defaults-4
(setq python-indent-guess-indent-offset nil)
