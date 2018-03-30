;; https://github.com/roman/golden-ratio.el
(use-package golden-ratio
  :config
  (setq golden-ratio-auto-scale t)

  ;; same as defaults but added `ignore-error-wrapper' since it's what
  ;; I'm using
  (setq golden-ratio-extra-commands
        '(windmove-left
          windmove-right
          windmove-down
          windmove-up
          ignore-error-wrapper))

  ;; exclude ispell choices when pressing M-$
  (setq golden-ratio-exclude-buffer-names
        '("*Choices*"
          "*twittering-edit*"
          "*Ediff Control Panel*"))

  (setq golden-ratio-exclude-buffer-regexp '(".*helm.*" ".*magit.*"))
  (setq golden-ratio-exclude-modes '(ediff-mode calendar-mode wget-mode))

  ;; avoid re-center when clicking with the mouse (mouse-drag-region),
  ;; it was very annoying when trying to select/copy text
  (setq golden-ratio-recenter nil)

  ;; enable the mode globally
  (golden-ratio-mode 1))
