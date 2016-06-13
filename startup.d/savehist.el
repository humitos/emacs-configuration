(require 'savehist)
(setq savehist-additional-variables    ;; also save...
  '(search-ring regexp-search-ring)    ;; ... my search entries
  savehist-file (concat emacs-user-directory "savehist")) ;; keep my home clean
(savehist-mode t)                      ;; do customization before activate
