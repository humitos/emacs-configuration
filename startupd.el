;;; startupd.el --- Modular loading of Emacs configuration

;; Copyright (C) 2011 Free Software Foundation, Inc.

;; Author: Fabián E. Gallina <fabian@anue.biz>
;; URL: https://github.com/fgallina/startupd.el
;; Version: 0.1
;; Maintainer: FSF
;; Created: Jul 2011
;; Keywords: languages

;; This file is NOT part of GNU Emacs.

;; startupd.el is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation, either version 3 of the License,
;; or (at your option) any later version.

;; startupd.el is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with startupd.el.  If not, see
;; <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Small utility library that loads all Lisp files located in the
;; directory indicated by `startupd-path'.  Files are filtered by the
;; `startupd-file-name-regexp' and the loading order is determined by
;; the function defined in `startupd-file-loading-sort-function'.  By
;; default the file loading order is done by using `string<' and
;; byte-compiled versions always take precedence.

;;; Installation:

;; Add this to your .emacs:

;; (add-to-list 'load-path "/folder/containing/file")
;; (require 'startupd)
;; (startupd-load-files)

;;; Code:

(defvar startupd-path "~/.emacs.d/startup.d/"
  "Path to the startup.d directory.
It must end with backslash.")

(defvar startupd-file-name-regexp
  "\\([0-9][0-9]\\)?[-A-Za-z_+.][-A-Za-z0-9_+.]+\\.elc?$"
  "Regexp that files should match to be loaded.")

(defvar startupd-file-loading-sort-function 'string<
  "Function used to calculate the loading order of matches files.")

(defun startupd--filter-list (list condp)
  "Filter elements of LIST by using CONDP as predicate."
  (delq nil
        (mapcar (lambda (x)
                  (and (funcall condp x) x)) list)))

(defun startupd-list-files ()
  "Return sorted list of files to be loaded.
The files are selected from the directory set by `startupd-path'
and filtered by the `startupd-file-names-regexp'."
  (let* ((raw-files
          (ignore-errors
            (directory-files startupd-path nil startupd-file-name-regexp)))
         (files
          (sort
           (startupd--filter-list
            raw-files
            (lambda (x)
              (not (member (concat x "c") raw-files))))
           startupd-file-loading-sort-function)))
    files))

(defun startupd-load-files ()
  "Load all startupd elegible files."
  (dolist (file (startupd-list-files))
    (load-file (concat startupd-path file))))

(provide 'startupd)
;;; startupd.el ends here
