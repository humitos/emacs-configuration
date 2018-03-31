;; https://github.com/gregsexton/origami.el
(use-package origami
  :hook (python-mode . origami-mode)
  :bind
  (()
   :map origami-mode-map
   ("C-c f a" . origami-toggle-all-nodes)
   ;; http://stackoverflow.com/questions/916797/emacs-global-set-key-to-c-tab
   ("<C-tab>" . origami-recursively-toggle-node)))
