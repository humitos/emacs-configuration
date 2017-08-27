;; https://github.com/tmalsburg/guess-language.el

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

(require 'guess-language)
(setq guess-language-languages '(en es))
(setq guess-language-min-paragraph-length 35)

;; enable flyspell-mode on text modes
(add-hook 'rst-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'flyspell-mode)

;; enable flyspell-prog-mode on Python code
(add-hook 'elpy-mode-hook 'flyspell-prog-mode)

;; enable guess-language for these modes
(add-hook 'rst-mode-hook (lambda () (guess-language-mode 1)))
(add-hook 'text-mode-hook (lambda () (guess-language-mode 1)))
(add-hook 'elpy-mode-hook (lambda () (guess-language-mode 1)))
