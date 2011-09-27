(require 'auto-complete)

;; ropemacs Integration with auto-completion

(defvar ropemacs-loaded nil)
(defun setup-ropemacs ()
  "Setup the ropemacs harness"
  (if ropemacs-loaded nil
    (if (not (boundp 'ropemacs-global-prefix))
        (setq ropemacs-global-prefix nil))
    (pymacs-load "ropemacs" "rope-")
    (define-key ropemacs-local-keymap (kbd "C-c j") 'rope-jump-to-global)
  
    ;; Stops from erroring if there's a syntax err
    (setq ropemacs-codeassist-maxfixes 3)
    (setq ropemacs-guess-project t)
    (setq ropemacs-enable-autoimport t)))


(defvar ac-ropemacs-last-candidates)
(defun ac-ropemacs-candidates ()
  (setq ac-ropemacs-last-candidates ())
  (mapcar (lambda (item)
            (let ((name (car item))
                  (doc (cadr item))
                  (type (caddr item)))
              (add-to-list 'ac-ropemacs-last-candidates
                           (cons (concat ac-prefix name) doc))
              (concat ac-prefix name)))
          (rope-extended-completions)))

(defun ac-ropemacs-document (name)
  (let ((item (assoc name ac-ropemacs-last-candidates)))
    (if item (cdr item))))

(ac-define-source nropemacs
  '((candidates . ac-ropemacs-candidates)
    (symbol     . "p")
    (document   . ac-ropemacs-document)
    (cache      . t)))

(ac-define-source nropemacs-dot
  '((candidates . ac-ropemacs-candidates)
    (symbol     . "p")
    (document   . ac-ropemacs-document)
    (cache      . t)
    (prefix     . c-dot)
    (requires   . 0)))

(defun ac-python-mode-setup ()
  (setq ac-sources (append '(ac-source-nropemacs
                             ac-source-nropemacs-dot
                             ac-source-yasnippet) ac-sources)))

(defun ac-self-insert-and-complete ()
  (interactive)
  (self-insert-command 1)
  (ac-start))

(provide 'auto-complete-python)
