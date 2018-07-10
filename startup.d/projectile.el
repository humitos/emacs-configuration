;; https://github.com/bbatsov/projectile
(use-package projectile
  :init (projectile-mode)
  :config
  ;; http://projectile.readthedocs.io/en/latest/configuration/#caching
  ;; http://emacs.stackexchange.com/a/2169
  (setq projectile-enable-caching t)

  ;; prefered method for indexing
  (setq projectile-indexing-method 'alien)

  ;; http://projectile.readthedocs.io/en/latest/configuration/#mode-line-indicator
  (setq projectile-mode-line '(:eval (format " [%s]" (projectile-project-name))))

  (setq projectile-ignored-projects '("elpy" ".emacs.d"))
  (setq projectile-globally-ignored-directories '("undohist"))
  (setq projectile-globally-ignored-file-suffixes
        '("~"
          "#"
          "orig"
          "bak"
          "gitignore"
          ))

  ;; TODO: work in progress to try to exclude files defined in
  ;; `.projectile' file when using a `git' repostory with projectile
  ;; This is key for C-c C-f (helm-projectile-find-file)
  ;; (setq projectile-git-ignored-command "git ls-files -z --cached --others --ignored --exclude-standard --exclude-from='/home/humitos/.emacs.d/.projectile'")
  ;; (setq projectile-git-command "git ls-files -z --cached --others --exclude-standard --exclude-from='/home/humitos/.emacs.d/.projectile'")

  (if (getenv "DOCKER")
      (setq ctags-executable "ctags")
    (setq ctags-executable "vendor/ctags/ctags"))

  (setq projectile-tags-command
        (concat emacs-user-directory
                ctags-executable
                (concat " --options=" emacs-user-directory ".ctags")
                " -f \"%s\" %s"))

  ;; do not ask if we want to reload the TAGS file once it has changed "M-x projectile-regenerate-tags"
  ;; http://stackoverflow.com/questions/4096580/how-to-make-emacs-reload-the-tags-file-automatically
  (setq tags-revert-without-query 1)

  ;; Number of seconds before file existence cache expires for a file on
  ;; a local file system.
  (setq projectile-file-exists-local-cache-expire 3)

  ;; disable remote file exists cache that use this snippet of code
  (setq projectile-file-exists-remote-cache-expire nil)

  ;; file generated `projectile-bookmarks.eld`
  (defun my-ignore-project (project-root)
    "Ignore some projects as known for projectile"
    (or
     (cl-search ".virtualenvs" project-root)
     (cl-search ".pyenv" project-root)
     (cl-search "rtfd/repos" project-root)
     (cl-search "readthedocs.org/user_builds" project-root)
     (cl-search "vendor" project-root)
     (cl-search "elpa" project-root)
     (cl-search ".tox" project-root)
     (cl-search ".helm-backup" project-root)
     (cl-search "./cache/pre-commit" project-root)
     (cl-search "3rdparty" project-root)))

  (setq projectile-ignored-project-function #'my-ignore-project))
