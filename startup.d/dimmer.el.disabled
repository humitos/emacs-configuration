;; https://github.com/gonewest818/dimmer.el
(require 'dimmer)

(setq dimmer-percent 0.3)
(setq dimmer-exclusion-regexp "*helm*")

;; TODO: when the same buffer is splitted, it doesn't dim the one
;; where is not the focus.

;; https://github.com/gonewest818/dimmer.el/tree/4963092d1d37987e6b9b3eca21be425a1ae44d99#caveats
;; This module makes use of the face-remap-* APIs in Emacs and these
;; APIs work on buffers rather than windows. This means anytime you
;; have multiple windows displaying the same buffer they will dim or
;; undim together. In my configuration I combine this package with
;; global-hl-line-mode so that it's also clear which window is active.

(dimmer-mode)
