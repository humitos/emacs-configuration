;; Personal configuration for Autopair

;; This repo is not a git submodule because it's a subversion
;; repository, so I export it from here
;; svn export http://autopair.googlecode.com/svn/trunk/ vendor/autopair

;; I found a mirror on github
;; https://github.com/emacsmirror/autopair

;; http://www.emacswiki.org/emacs/AutoPairs
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers
