;; https://github.com/tmalsburg/guess-language.el
(use-package guess-language
  :pin melpa
  :hook
  ;; enable flyspell-mode on text modes and flyspell-prog-mode in
  ;; programming modes
  ((rst-mode . flyspell-mode)
   (text-mode . flyspell-mode)
   (prog-mode . flyspell-prog-mode)
   (rst-mode . guess-language-mode)
   (text-mode . guess-language-mode)
   (prog-mode . guess-language-mode))
  :config
  ;; set a default dictionary
  (setq ispell-dictionary "en")

  ;; do not emit a message when checking words
  (setq flyspell-issue-message-flag nil)

  ;; do not ask if we want to save the personal dictionary
  (setq ispell-silently-savep t)

  ;; enable the likeness criteria
  (setq flyspell-sort-corrections nil)

  ;; don't use `M-TAB' to correct word (only use `C-.')
  (setq flyspell-use-meta-tab nil)

  ;; dash character (`-') is considered as a word delimiter
  (setq flyspell-consider-dash-as-word-delimiter-flag t)

  (setq flyspell-mode-line-string "FlySpell")
  (setq guess-language-languages '(en es))
  (setq guess-language-min-paragraph-length 35))
