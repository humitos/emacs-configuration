#!/usr/bin/env bash

## This shell script it's just a modified version of the one used at:
## https://github.com/emacs-helm/helm/blob/master/emacs-helm.sh

## Copyright (C) 2012 ~ 2016 Thierry Volpiatto <thierry.volpiatto@gmail.com>
## 
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## Commentary:

# Preconfigured Emacs with Manuel Kaufmann (@humitos) configurations
# Useful to start quickly an emacs -Q with this configuration.
# Run it from this directory or symlink it somewhere in your PATH.

# version comparison
# http://stackoverflow.com/a/4024263
verlte() {
    [  "$1" = "`echo -e "$1\n$2" | sort -V | head -n1`" ]
}

verlt() {
    [ "$1" = "$2" ] && return 1 || verlte $1 $2
}

# If TEMP env var exists use it otherwise declare it.
[ -z $TEMP ] && declare TEMP="/tmp"

CONF_FILE="$TEMP/humitos-cfg.el"

# check if we have emacs-snapshot installed first
which emacs-snapshot > /dev/null
EMACS_SNAPSHOT_CMD=$?

if [ $EMACS_SNAPSHOT_CMD -eq 0 ]; then
  EMACS=emacs-snapshot
else
  EMACS=emacs
fi

EMACS_USER_VERSION=`$EMACS --version | awk '{print $3}' | head -n 1`
EMACS_MIN_REQUIRED_VERSION="24.4"

verlt $EMACS_USER_VERSION $EMACS_MIN_REQUIRED_VERSION
EMACS_ENOUGH_VERSION=$?

if [ $EMACS_ENOUGH_VERSION -eq 0 ]; then
  echo "*** ERROR ***"
  echo "*** ERROR *** Emacs ${EMACS_MIN_REQUIRED_VERSION} or greater is needed and you have: ${EMACS_USER_VERSION}"
  echo "*** ERROR ***"
  echo "  In Ubuntu you can add a PPA repository and install \`emacs-snapshot\` package:"
  echo "    $ sudo add-apt-repository ppa:ubuntu-elisp/ppa"
  echo "    $ sudo apt-get update"
  echo "    $ sudo apt-get install emacs-snapshot"
  exit 1
fi

case $1 in
    -P)
        shift 1
        declare EMACS=$1
        shift 1
        ;;
    -h)
        echo "Usage: ${0##*/} [-P} Emacs path [-h} help [--] EMACS ARGS"
        exit 2
        ;;
esac

cd $(dirname "$0")


cat > $CONF_FILE <<EOF
(setq initial-scratch-message (concat initial-scratch-message
";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n\
;; This Emacs is Powered by the humitos configurations\n\
;; emacs program \"$EMACS\".\n\
;; This is the full configuration using \`https://github.com/humitos/emacs-configuration\`.\n\
;; Please check out the README.rst file to learn about all the packages installed here and the most commons hotkeys.\n\
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n\n"))


(setq emacs-user-directory (file-name-directory (file-truename "$0")))
(add-to-list 'load-path (concat (file-name-directory (file-truename "$0")) "packages"))
(add-to-list 'load-path (concat (file-name-directory (file-truename "$0")) "vendor/startupd.el"))

(require 'startupd)
;; set path for startup.d configurations
(setq startupd-path (concat (file-name-directory (file-truename "$0")) "startup.d/"))
(startupd-load-files)

;; delete temp config file
(add-hook 'kill-emacs-hook #'(lambda () (and (file-exists-p "$CONF_FILE") (delete-file "$CONF_FILE"))))

;; activate emacsenv
(pyvenv-activate "$0/emacsenv")
EOF


# download default yasnippets
cd vendor/yasnippet > /dev/null
git checkout master
cd snippets > /dev/null
git pull
cd ../yasmate > /dev/null
git pull
cd ../../.. > /dev/null

# stop the script if something goes wrong
set -e

# disable erc for tryit.sh
if [ -e startup.d/erc.el ]; then
  mv --force startup.d/erc.el startup.d/erc.el.disabled > /dev/null
fi
# configure helm
if [ ! -e vendor/helm/helm-autoloads.el ]; then
  cd vendor/helm ; make ; cd - > /dev/null
fi
# create venv
if [ ! -d emacsenv ]; then
  set +e
  python3 -m venv emacsenv
  if [ $? -ne 0 ]; then
      set -e
      rm -rf emacsenv
      virtualenv -p python3 emacsenv
  fi
  # install all the python dependencies
  source emacsenv/bin/activate
  pip install -U pip
  pip install -r requirements.elpy.in
else
  source emacsenv/bin/activate
fi

$EMACS -Q -l $CONF_FILE $@
