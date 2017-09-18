;; https://github.com/antham/helm-backup

(require 'helm-backup)

(setq helm-backup-excluded-entries
      '("/home/humitos/.emacs.d/recentf"
        "/home/humitos/mozio/mozio/.*"
        "/home/humitos/mozio/ondemand/.*"
        "/home/humitos/mozio/data-entry/.*"
        ))

(add-hook 'after-save-hook 'helm-backup-versioning)
