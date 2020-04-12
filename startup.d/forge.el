;; https://github.com/magit/forge

(use-package forge
  :after magit
  :config
  ;; https://github.com/magit/forge/issues/80#issuecomment-518813786
  (setq forge-pull-notifications nil)
  )
