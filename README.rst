=====================
 Emacs Configuration
=====================

  NOTE: do not installing it if you are not sure what you are doing... :)


Try it!
=======

If you want to try all this configuration without changing anything in
your computer, you can do it. Even if you already have your own emacs
configuration and without modifying it!

The idea is that you can try all the features and then copy those ones
that you like most by reading all the configuration scripts or just
use it as it is :)

**Important: emacs 24.4 or greater is needed**

#. Install all the dependencies (e.g. in Ubuntu)::

     sudo apt-get install emacs python3-venv git exuberant-ctags

*NOTE: if `python3-venv` is not available in your Ubuntu you should install `python-virtualenv`*

#. Clone this repository::

     git clone --recursive --jobs 4 --shallow-submodules --depth 1 https://github.com/humitos/emacs-configuration.git
     cd emacs-configuration
     ./tryit.sh

#. Enjoy!

Installation
============


#. Clone this repository on the standard `.emacs.d` settings directory::

     cd ~
     git clone --recursive --jobs 4 --shallow-submodules --depth 1 https://github.com/humitos/emacs-configuration.git .emacs.d

#. Compile helm::

     cd vendor/helm
     make

#. Put in your `~/.emacs`::

     ;; set default user emacs directory
     (setq emacs-user-directory "~/.emacs.d/")

     (load (concat emacs-user-directory "init.el"))

#. Compile all `packages` (optional)::

     ./bin/compile_el_files

#. Run emacs

----

  NOTE: all of this configuration was tested in
   * Xubuntu 16.04 LTS
   * Emacs 25.1.50.2
   * exuberant-ctags 5.9~svn20110310-
   * git 2.9.3
   * Python 2.7.12
   * Firefox 48


Install Python necessary modules
================================

I'm installing all the necesary package for `elpy` in each venv that
I'm working on, so you should run this command in your venvs

Install necessary packages::

      pip install -U -r requirements.elpy.in


Install required system packages
================================


::

     sudo apt-get install emacs python3-venv git exuberant-ctags


Configure Firefox to export bookmarks automatically
===================================================

  This is needed for `helm-firefox` to find your bookmarks and keep
  them updated.

Open your Firefox and go to `about:config` in firefox url
toolbar. Search for this line::

  user_pref("browser.bookmarks.autoExportHTML", false);

Double click on this line to enable its value to true, you should have
now::

  user_pref("browser.bookmarks.autoExportHTML", true);


Keep this configuration updated
===============================

::

     cd emacs-configuration
     git pull
     git submodule update --init --remote


Main modules included in this configuration
===========================================

* ace-jump-mode
* autopair
* browse-at-remote
* discover-my-major
* elpy
* expand-region
* flycheck
* gist.el
* git-gutter.el
* git-timemachine
* helm
* helm-dash
* help-fuzzier
* helm-swoop
* highlight-indentation
* jedi
* magit
* material-theme
* origami.el
* powerline
* projectile
* py-autopep8
* py-autoflake
* py-docformatter
* py-isort
* rainbow-delimiters
* restclient-mode
* twittering-mode
* undohist
* visual-regexp-steroids
* web-mode
* whitespace-cleanup-mode
* yasnippet
* zzz-to-char

These are the hotkeys that I use most.

ace-jump-mode
-------------

* https://github.com/winterTTr/ace-jump-mode

:C-c SPC: jump to any place in the buffer with just a hotkey plus a
          position key

browse-at-remote
----------------

* https://github.com/rmuslimov/browse-at-remote

:C-c g g: show the file / selected region into remote web page
          (Github, for example)

Once on `magit-status` or `magit-log` hitting the shortcut goes to the
proper URL


discover-my-major
-----------------

* https://github.com/steckerhalter/discover-my-major

:discover-my-major: show help with all the all the hotkeys for this
                    major mode


elpy
----

* https://github.com/jorgenschaefer/elpy

:M-down:
:M-up:
:M-left:
:M-right: move the selected region by indentation
:M-.: go to definition (class, function, variable, etc)
:M-,: go back where we was

:C-c C-z: switch to a Python shell
:C-c C-d: open Python documentation (class, function, etc)
:C-c C-t: run test depending on cursor position


expand-region
-------------

* https://github.com/magnars/expand-region.el

:C-=: mark region based on semantics


find-file-in-project
--------------------

* https://github.com/technomancy/find-file-in-project

:C-c C-f: find a file in the current project. This uses a
          search-as-you-type interface for all files under the project
          root.

(this hotkey comes from `elpy`)

  This hotkey is replaced by the helm one if you have it active.

:C-u C-c C-f: find a file in the current project but it regenerate the
              cache first.


flycheck
--------

* http://www.flycheck.org/

:C-c C-n: go to the next Flycheck error
:C-c C-p: go to the previous Flycheck error

(these hotkeys comes from `elpy`)

  `elpy` already has some hotkeys for this, but I'm using Flycheck
  instead of Flymake, which is the default for elpy)


gist.el
-------

* https://github.com/defunkt/gist.el

:gist-list: show the list of all our gist
:gist-region-or-buffer-private: create a new private gist with the
                                selection

git-timemachine
---------------

* https://github.com/pidu/git-timemachine

:git-timemachine: browse all versions of the current file

Once with that mode activated:

:p: previous version
:n: next version
:q: quit

helm
----

* https://github.com/emacs-helm/helm
* https://github.com/EphramPerdition/helm-fuzzier
* https://github.com/ShingoFukuyama/helm-swoop

:M-x: the beginning is here :)
:C-x f: all files in repository (ls-git)
:M-y: kill ring
:C-x r b: files position bookmark listing
:C-c h e: etags
:C-c h i: all function and variable names in the current buffer


Commands:

:helm-firefox-bookmarks: filter among Firefox bookmarks
:helm-google-suggest: search in google
:helm-wikipedia-suggest: search in wikipedia
:helm-swoop: search inside the current buffer and jump to them
:helm-multi-swoop: search in multiples buffer and jump to them
:helm-dash: search in dash documentation (https://kapeli.com/dash)

Once in the helm session / buffer:

:C-SPC: mark the current selection
:M-D: kill the selection


magit
-----

* https://magit.vc/

:C-x g: open the Magit Status buffer

Once on this buffer

:s: stage the selected file / chunk / directory
:k: discart the selected file / chunk / directory
:u: unstage the selected file / chunk / directory
:g: refresh buffer
:c c: commit current staged changes
:c a: amend current staged changes to previous commit
:P u: push to the current branch
:b b: checkout another branch
:b c: checkout a new branch
:b n: create new branch
:z z: stash current changes
:z p: pop stashed changes
:f u: fetch from origin
:F e: pulll from elsewhere


Commands:

:magit-log: show the git log
:magit-blame: show the author of each chunk of code


origami.el
----------

* https://github.com/gregsexton/origami.el

:C-c f a: toggle (folding) all the regions
:C-c f e: toggle the fold selected


projectile
----------

* https://github.com/bbatsov/projectile

:C-c p p: switch between projects
:C-c p b: switch between opened buffers for current project
:C-c p k: kill all the buffer related to the current project
:C-c p f: find file in current project
:C-c C-s: perform a grep on the current project
:C-c p h: all together
:C-c p R: regenerate TAGS for current project

  This is also integrated with helm


restclient-mode
---------------

* https://github.com/pashky/restclient.el

:C-c C-v: execute the current request
:C-c C-u: copy the CURL command to the clipboard
:C-c C-g: browse the queries / variables / etc with helm


twittering-mode
---------------

* https://github.com/hayamiz/twittering-mode/

:g: fetch new tweets
:RET: reply
:u: post a new tweet
:C-c C-c: send the tweet once we finish writting
:C-c C-k: cancel the current tweet
:C-u C-c RET: retweet current
:r: show replies
:j: navigate to next tweet
:k: navigate previous tweet


visual-regexp-steroids
----------------------

* https://github.com/benma/visual-regexp-steroids.el/

:C-M-%: search and replace using regex (visual and interactive results)


zzz-to-char
-----------

* https://github.com/mrkkrp/zzz-to-char

:M-z: zap up to one of the characters in the current paragraph


References
==========

* http://emacswiki.org/
* http://emacsrocks.com/
* https://www.quora.com/What-are-some-of-the-most-useful-extensions-for-Emacs
* https://github.com/emacs-tw/awesome-emacs
* https://github.com/fisadev/fisa-vim-config
