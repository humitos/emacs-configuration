;; https://www.emacswiki.org/emacs/FlySpell

;; set a default dictionary
(setq ispell-dictionary "en")

;; do not emit a message when checking words
(setq flyspell-issue-message-flag nil)

;; do not ask if we want to save the personal dictionary
(setq ispell-silently-savep t)

;; https://www.emacswiki.org/emacs/GuessBufferLanguage
;; modified version to work on emacs 26
(defvar guess-language-rules
  '(("en" . "\\<\\(of\\|the\\|and\\|or\\|how\\)\\>")
    ("es" . "\\<\\(vos\\|de\\|y\\|o\\|que\\|para\\)\\>")
    ("de" . "\\<\\(und\\|oder\\|der\\|die\\|das\\|wie\\)\\>")
    ("fr" . "\\<\\(et\\|ou\\|[ld]es\\|que\\)\\>")
    ("pt" . "\\<\\(de\\|para\\|e\\|ou\\|como\\)\\>"))
  "Alist of rules to determine the language of some text.
    Each rule has the form (CODE . REGEXP) where CODE is a string to
    identify the language (probably according to ISO 639), and REGEXP is a
    regexp that matches some very common words particular to that language.
    The default language should be listed first.  That will be the language
    returned when no REGEXP matches, as would happen for an empty
    document.")

(defun guess-buffer-language ()
  "Guess language in the current buffer."
  (save-excursion
    (goto-char (point-min))
    (let ((count (map 'list (lambda (x)
                              (cons
                               (count-matches (cdr x)) (car x)))
                      guess-language-rules)))
      (cdr (assoc (car (sort (map 'list 'car count) '>))
                  count)))))

(defun guess-language ()
  "Guess language in the current buffer."
  (interactive)
  (message (guess-buffer-language)))

(defun flyspell-active-mode (flymode)
  "Active FLYMODE flyspell-(prog)-mode"
  (let ((language (guess-buffer-language)))
    (progn
      (set (make-local-variable 'ispell-personal-dictionary) (expand-file-name (format ".aspell.%s.pws" language) emacs-user-directory))
      (if (not (string= language ispell-current-dictionary))
          (progn
            (ispell-change-dictionary language)
            (message "Dictionary switched to %s" language)))
      (funcall flymode))))

;; apply-partially - http://stackoverflow.com/a/16730821/2187091
;; funcall - http://emacs.stackexchange.com/a/17467
;; (add-hook 'rst-mode-hook (apply-partially #'flyspell-active-mode 'flyspell-mode))
;; (add-hook 'text-mode-hook (apply-partially #'flyspell-active-mode 'flyspell-mode))
;; (add-hook 'elpy-mode-hook (apply-partially #'flyspell-active-mode 'flyspell-prog-mode))
