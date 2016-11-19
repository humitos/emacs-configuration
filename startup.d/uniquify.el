;; Personal configuracion for uniquify

;; Unique names for buffer, instead views.py and views.py<2> use views.py:account,
;;   views.py:schedule and views.py:client
;; http://emacs-fu.blogspot.com/2009/11/making-buffer-names-unique.html
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Uniquify.html
(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;; https://github.com/bbatsov/emacs.d/blob/master/init.el
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")
