=====================
 Emacs Configuration
=====================


Try it with Docker!
===================

This is the **easiest way to try** all this set of configurations without
touching your computer configuration and break anything::

     docker run --rm -it -e DISPLAY -v $(pwd):/src -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
       -v $XAUTHORITY:/root/.Xauthority --net=host humitos/emacs-x11-alpine


Full documentation for Docker image: https://github.com/humitos/emacs-x11-alpine

By running this configuration using Docker, you can start an emacs
instance without breaking anything in your existing emacs
configuration or even without having emacs installed in your computer.

The idea of this Docker image, is that you can easily check some of
the shortcuts and modules that I'm using and start using them in your
own configuration by _maybe_ copying that chunk of configuration from
`startup.d/` folder.

Or, you can just use this Docker image as your daily editor :)

If you really like this configuration, you could install it in your
computer with the following instructions.

----
  
Installation
============

  NOTE: do not installing it if you are not sure what you are doing... :)


#. Clone this repository on the standard `.emacs.d` settings directory::

     cd ~
     git clone --depth 1 https://github.com/humitos/emacs-configuration.git .emacs.d
     cd .emacs.d
     git submodule init

#. Update git submodules and compile necessary modules (helm, ctags and silver searcher, among others)::

   ./bin/update_git_submodules

#. Put in your `~/.emacs`::

     ;; set default user emacs directory
     (setq emacs-user-directory "~/.emacs.d/")

     (load (concat emacs-user-directory "init.el"))

#. Run emacs

----

  NOTE: all of this configuration was tested in
   * Xubuntu 16.04 LTS
   * Emacs 26.0.50
   * git 2.13.0
   * Python 2.7.13
   * Firefox 53.0.3


Install Python necessary modules
================================

I'm installing all the necesary package for `elpy` in each virtualenv
that I'm working on, so you should run this command in your venvs

Install necessary packages::

      pip install -U -r requirements.elpy.in

For virtualenv creation, I'm using `pyenv <https://github.com/pyenv/pyenv>`_.


Install required system packages
================================


::

     sudo apt-get install emacs git aspell-es


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

     cd ~/.emacs.d
     git pull
     ./bin/update_git_submodules

----

Main modules included in this configuration
===========================================

* ace-jump-mode
* autopair
* browse-at-remote
* ctags-update
* discover-my-major
* easy-kill
* elpy
* expand-region
* flycheck
* gist.el
* git-gutter.el
* git-timemachine
* guess-language
* helm
* helm-dash
* help-fuzzier
* helm-swoop
* highlight-indentation
* highlight-symbol
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
* smart-forward.el
* sphinx-doc.el
* twittering-mode
* undohist
* visual-regexp-steroids
* web-mode
* whitespace-cleanup-mode
* yasnippet
* zencoding-mode
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


easy-kill
---------

* https://github.com/leoliu/easy-kill

:M-w d: save the current defun definition into the kill-ring (clipboard)
:M-w w: save word at point into the kill-ring
:M-w f: save the name of the current file being edited


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
:C-w: copy the commit hash to the clipboard


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


smart-forward.el
----------------

* https://github.com/magnars/smart-forward.el

:C-S-<left>: move backward 'smartly'
:C-S-<right>: move forward 'smartly'
:C-S-<up>: move up 'smartly'
:C-S-<down>: move down 'smartly'


sphinx-doc.el
-------------

* https://github.com/naiquevin/sphinx-doc.el

:C-c M-d: create the docstring for the current Python method/function
          in reStructuredText form

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


zencoding-mode
--------------

* https://github.com/rooney/zencoding

:C-j: expand the current expression to match the snippet


References
==========

* http://emacswiki.org/
* http://emacsrocks.com/
* https://www.quora.com/What-are-some-of-the-most-useful-extensions-for-Emacs
* https://github.com/emacs-tw/awesome-emacs
* https://github.com/fisadev/fisa-vim-config
