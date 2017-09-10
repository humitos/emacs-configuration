;; https://github.com/antham/helm-backup

(require 'helm-backup)
(add-hook 'after-save-hook 'helm-backup-versioning)
