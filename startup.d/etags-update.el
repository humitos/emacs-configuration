(require 'etags-update)

;; TODO: detect if the file is in the git repository and 'add it
;; without promping
(setq etu/append-file-prompt 'nil)

(etags-update-mode 1)
