(require 'etags-update)

;; TODO: detect if the file is in the git repository and 'add it
;; without promping
;; (setq etu/append-file-prompt 'nil)
(defun is-python-file (file)
  ;; check if the file is a Python file
  (cond
    ((string-suffix-p ".py" file) 'add)
    (t 'nil)))
(setq etu/append-file-prompt 'is-python-file)


;; reload etags once updated without asking
(setq tags-revert-without-query 1)

(etags-update-mode 1)
