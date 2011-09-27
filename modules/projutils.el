;;; projutils.el --- Project utils

;; Copyright (C) 2011 Free Software Foundation, Inc.

;; Author: Fabián E. Gallina <fabian@anue.biz>
;; URL: https://github.com/fgallina/projutils.el
;; Version: 0.1
;; Maintainer: FSF
;; Created: Jul 2011
;; Keywords: languages

;; This file is NOT part of GNU Emacs.

;; projutils.el is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.

;; projutils.el is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with projutils.el.  If not, see
;; <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Small library with useful commands for working from the root of
;; GNU/Emacs projects (see dir-locals)

;; Browse project files from root folder: Using speedbar or, if
;; available, sr-speedbar.  In the case both are present you can
;; control if sr-speedbar should have precedence via the
;; `projutils-use-sr-speedbar' variable.

;; Grep files from the root folder: Using rgrep or, if available, ack
;; (from full-ack package).  In the case both are present you can
;; control if ack should have precedence via the `projutils-use-ack'
;; variable.

;; Find file in project: The list of files is generated from the
;; project root and you can control what should be filtered by setting
;; the `projutils-ffip-ignored-dirs', `projutils-ffip-ignored-files',
;; `projutils-ffip-allowed-file-extensions',
;; `projutils-ffip-ignored-file-extensions',
;; `projutils-ffip-ignored-regexps' variables.

;;; Installation:

;; Add this to your .emacs:

;; (require 'projutils)
;; (projutils-global-mode 1)

;;; Code:

(require 'speedbar)
(require 'grep)
(require 'sr-speedbar nil t)
(require 'full-ack nil t)
(require 'ido)


(defgroup projutils nil
  "Project utils."
  :group 'convenience
  :version "23.2")


;;; Bindings

(defvar projutils-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-xpb" 'projutils-browser-open)
    (define-key map "\C-xpc" 'projutils-browser-close)
    (define-key map "\C-xpg" 'projutils-grep)
    (define-key map "\C-xp\C-x\C-f" 'projutils-ffip-find-file)
    (easy-menu-define python-menu map "Python Mode menu"
      `("Project Utils"
	:help "Project utils commands"
	["Open file browser" projutils-browser-open
	 :help "Open file browser at project root"]
	["Close file browser" projutils-browser-close
	 :help "Close file browser"]
        "-"
	["Grep" projutils-grep
	 :help "Recursive grep from project's root"]
        "-"
	["Find file in project" projutils-ffip-find-file
	 :help "Find file in project with autocompletion"]
	["Update file list" projutils-ffip-update-file-list
	 :help "Update project's file list"]))
    map)
  "Keymap for `projutils'.")


;;; Utils

(defun projutils-get-root-dir ()
  "Return the root dir for project.
If the current file is not on a project or the buffer is not
visiting a file it returns the value of `default-directory'."
  (or (and buffer-file-name
           (or projutils-project-root-path
               (let ((current-dir-locals-file
                      (dir-locals-find-file buffer-file-name)))
                 (when current-dir-locals-file
                   (when (listp current-dir-locals-file)
                     (setq current-dir-locals-file
                           (nth 0 current-dir-locals-file)))
                   (file-name-directory current-dir-locals-file)))))
      default-directory))

(defun projutils-list-of-strings-p (names)
  "Check if NAMES is a list of string."
  (not (catch 'fail
         (dolist (name names)
           (when (not (stringp name))
             (throw 'fail t))))))

(defun projutils-replace-string (string match &optional replace)
  "Search STRING for MATCH and replace by REPLACE.
Replace is optional and defaults to an empty string."
  (with-temp-buffer
    (insert string)
    (goto-char (point-min))
    (while (search-forward match nil t)
      (replace-match (or replace "") nil t))
    (buffer-string)))


;;; File Browsing

(defvar projutils-browser--have-sr-speedbar nil
  "Indicates if `sr-speedbar' is available.
Internal use only, do not change.")

(when (fboundp 'sr-speedbar-open)
  (setq projutils-browser--have-sr-speedbar t))

(defcustom projutils-browser-use-sr-speedbar t
  "Determine `sr-speedbar' use over `speedbar' if available."
  :group 'projutils
  :type 'boolean
  :safe 'booleanp)

(defun projutils-browser-use-sr-speedbar-p ()
  "Return t if `sr-speedbar' is available."
  (and projutils-browser--have-sr-speedbar
       projutils-browser-use-sr-speedbar))

(defun projutils-browser-open ()
  "Open speedbar's file browser at project's root.
It uses `sr-speedbar' if `projutils-browser-use-sr-speedbar-p' returns
t. Else uses the standard `speedbar'."
  (interactive)
    (let ((default-directory (projutils-get-root-dir)))
      (speedbar-change-initial-expansion-list "files")
      (if (projutils-browser-use-sr-speedbar-p)
          (progn
            (sr-speedbar-refresh-turn-off)
            (sr-speedbar-open))
        (speedbar-disable-update)
        (speedbar 1))))

(defun projutils-browser-close ()
  "Close speedbar's file browser.
Closes `sr-speedbar' if `projutils-browser-use-sr-speedbar-p'
returns t. Else closes the standard `speedbar'."
  (interactive)
  (if (projutils-browser-use-sr-speedbar-p)
      (sr-speedbar-close)
    (speedbar -1)))


;;; Grepping

(defvar projutils-grep--have-ack nil
  "Indicates if ack is available.
Internal use only, do not change.")

(when (fboundp 'ack)
  (setq projutils-grep--have-ack t))

(defcustom projutils-grep-use-ack t
  "Determine ack use over grep if available."
  :group 'projutils
  :type 'boolean
  :safe 'booleanp)

(defun projutils-grep-use-ack-p ()
  "Return t if ack is available."
  (and projutils-grep--have-ack
       projutils-grep-use-ack))

(defun projutils-grep (regexp)
  "Grep from the root of the project.
Argument REGEXP is the regular expresion to search with."
  (interactive (list (if (projutils-grep-use-ack-p)
                         (let ((regexp (ack-xor current-prefix-arg
                                                ack-search-regexp)))
                           (ack-read regexp))
                       (grep-read-regexp))))
  (let ((default-directory (projutils-get-root-dir)))
    (if (projutils-grep-use-ack-p)
        (ack regexp nil default-directory)
      (let ((grep-defaults
             (progn
               (grep-compute-defaults)
               (cond
                ((not grep-template)
                 (error "No `grep-template' available"))
                (t (let* ((files "*")
                          (dir default-directory)
                          (confirm (equal current-prefix-arg '(4))))
                     (list regexp files dir confirm)))))))
        (apply 'rgrep grep-defaults)))))


;;; Find file in project

(defvar projutils-ffip-files nil
  "List of project files.")

(defvar projutils-ffip-dirs nil
  "List of project directories.")

(defvar projutils-ffip--dirs nil
  "Internal list of project directories.")

(defcustom projutils-ffip-ignored-dirs nil
  "List of directory names to exclude.
Directory names should be relative to the project root."
  :group 'projutils
  :type '(repeat string)
  :safe #'projutils-list-of-strings-p)

(defcustom projutils-ffip-ignored-files nil
  "List of file names to exclude.
File names should be relative to the project root."
  :group 'projutils
  :type '(repeat string)
  :safe #'projutils-list-of-strings-p)

(defcustom projutils-ffip-allowed-file-extensions nil
  "List of file extensions allowed.
Each file extension should be listed without the dot."
  :group 'projutils
  :type '(repeat string)
  :safe #'projutils-list-of-strings-p)

(defcustom projutils-ffip-ignored-file-extensions nil
  "List of file extensions ignored.
Each file extension should be listed without the dot."
  :group 'projutils
  :type '(repeat string)
  :safe #'projutils-list-of-strings-p)

(defcustom projutils-ffip-ignored-regexps nil
  "Regexp list used to exclude file names.
File names are always relative to the project root."
  :group 'projutils
  :type '(repeat string)
  :safe #'projutils-list-of-strings-p)

(defun projutils-ffip-directory-files (directory)
  "Safely list allowed files for DIRECTORY.
If DIRECTORY is not a valid directory name returns nil."
  (when (eq t (car (file-attributes directory)))
    (directory-files directory t directory-files-no-dot-files-regexp)))

(defun projutils-ffip-collect-dirs-and-files (&optional directory)
  "Collect all subdirectories and files for DIRECTORY.
Populates the `projutils-ffip-dirs' and `projutils-ffip-files' variables."
  (let* ((root-dir (projutils-get-root-dir))
         (directory
          (file-name-as-directory (or directory root-dir)))
         (files (projutils-ffip-directory-files directory))
         (regexp (mapconcat 'identity projutils-ffip-ignored-regexps "\\|")))
    (dolist (file files)
      (when (or (not projutils-ffip-ignored-regexps)
                (not (string-match regexp file)))
        (let ((file-extension (file-name-extension file))
              (cleaned-file-name (projutils-replace-string file root-dir))
              (is-directory (eq t (car (file-attributes file)))))
          (if (not is-directory)
              (when (and (or (and (not projutils-ffip-allowed-file-extensions)
                                  (not (member
                                        file-extension
                                        projutils-ffip-ignored-file-extensions)))
                             (member file-extension
                                     projutils-ffip-allowed-file-extensions))
                         (not (member
                               cleaned-file-name
                               projutils-ffip-ignored-files)))
                (add-to-list 'projutils-ffip-files cleaned-file-name))
            (when (not (member
                        cleaned-file-name
                        projutils-ffip-ignored-dirs))
              (add-to-list 'projutils-ffip--dirs file)
              (add-to-list 'projutils-ffip-dirs cleaned-file-name))))))))

(defun projutils-ffip-update-file-list ()
  "Rescan project files.
It uses `projutils-ffip-collect-dirs-and-files' internally so it
modifies `projutils-ffip-dirs' and `projutils-ffip-files' variables."
  (interactive)
  ;; TODO: cache files and dirs in dir-locals using
  ;; `add-dir-local-variable'.
  (setq projutils-ffip-dirs nil)
  (setq projutils-ffip--dirs nil)
  (setq projutils-ffip-files nil)
  (projutils-ffip-collect-dirs-and-files)
  (while projutils-ffip--dirs
    (let ((dir (car projutils-ffip--dirs)))
      (setq projutils-ffip--dirs (cdr projutils-ffip--dirs))
      (message dir)
      (projutils-ffip-collect-dirs-and-files dir)))
  projutils-ffip-files)

(defun projutils-ffip-find-file (&optional force-update)
  "Find file in project.
With prefix arg FORCE-UPDATE the project file list will be
updated via `projutils-ffip-collect-dirs-and-files' before
displaying completions."
  (interactive "P")
  (when (or force-update
            (not projutils-ffip-dirs))
    (projutils-ffip-update-file-list))
  (let ((project-file
         (ido-completing-read "Find file in project: " projutils-ffip-files))
        (root-dir (projutils-get-root-dir)))
  (find-file (concat root-dir project-file))))


;;; Minor mode
;;;###autoload

(defcustom projutils-project-root-path nil
  "Project root path.
When this variable is nil the root path is autodetected by
searching for .dir-locals.el file."
  :group 'projutils
  :type 'string
  :safe 'stringp)

(define-minor-mode projutils-mode
  "Toggle project utility commands.
With a numeric argument, turn projutils-mode on if ARG is
positive, otherwise turn it off.

\\{projutils-mode-map}"
  :group 'projutils :lighter " proj")

(defun projutils-mode-maybe ()
  "Turn on function `projutils-mode' if necessary."
  (when (and buffer-file-name
             (projutils-get-root-dir))
    (projutils-mode 1)))

(define-globalized-minor-mode projutils-global-mode
  projutils-mode projutils-mode-maybe
  :group 'projutils
  :require 'projutils-mode)


(provide 'projutils)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; projutils.el ends here
