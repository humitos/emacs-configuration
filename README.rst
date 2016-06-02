===================
Emacs Configuration
===================

Installation
-----------

#. Clone this repository with the command::

     cd ~
     git clone git://github.com/humitos/emacs-configuration.git

#. You can rename it with the `standard` emacs name for this folder::

     mv emacs-configuration .emacs.d

#. Update git submodules::

     cd .emacs.d
     git submodule init
     git submodule sync
     git submodule update

#. Put in your `~/.emacs`::

     (load "~/.emacs.d/init.el")

#. Run emacs


Install Python necessary modules
--------------------------------

I'm installing all the necesary package for `elpy` in each venv that
I'm working on, so you should run this command in your venvs

Install necessary packages::

      pip install -U -r requirements.elpy.in


Main modules included in this configuration
-------------------------------------------

* ace-jump-mode
* autopair
* elpy
* expand-region
* flycheck
* gist.el
* helm
* highlight-indentation
* jedi
* magit
* powerline
* projectile
* py-autopep8
* py-docformatter
* py-isort
* rainbow-delimiters
* solarized-theme
* twittering-mode
* undohist
* web-mode
* yasnippet

These are the hotkeys that I use most.

ace-jump-mode
~~~~~~~~~~~~~

* https://github.com/winterTTr/ace-jump-mode

:C-c SPC: jump to any place in the buffer with just a hotkey plus a
          position key

elpy
~~~~

* https://github.com/jorgenschaefer/elpy

:M-down:
:M-up:
:M-left:
:M-right: move the selected region by indentation
.. :C-c C-s: performs a `grep -r` in the current project
:M-.: go to definition (class, function, variable, etc)
:M.*: go back where we was

:C-c C-z: switch to a Python shell
:C-c C-d: open Python documentation (class, function, etc)
:C-c C-t: run test depending on cursor position


expand-region
~~~~~~~~~~~~~

* https://github.com/magnars/expand-region.el

:C-=: mark region based on semantics

      
find-file-in-project
~~~~~~~~~~~~~~~~~~~~

* https://github.com/technomancy/find-file-in-project

:C-c C-f: find a file in the current project. This uses a
          search-as-you-type interface for all files under the project
          root.

(this hotkey comes from `elpy`)

  This hotkey is replaced by the helm one if you have it active.

flycheck
~~~~~~~~

* http://www.flycheck.org/

:C-c C-n: go to the next Flycheck error
:C-c C-p: go to the previous Flycheck error

(`elpy` already has some hotkeys for this, but I'm using Flycheck
instead of Flymake, which is the default for elpy)


gist.el
~~~~~~~

* https://github.com/defunkt/gist.el

:gist-list: show the list of all our gist
:gist-region-or-buffer-private: create a new private gist with the
                                selection


helm
~~~~

:M-x: the beginning is here :)
:C-x f: all files in repository (ls-git)
:M-y: kill ring
:C-x r b: files position bookmark listing
:C-c h e: etags

Commands:

:helm-firefox-bookmarks: filter among Firefox bookmarks
:helm-google-suggest: search in google
:helm-wikipedia-suggest: search in wikipedia

Once in the helm session / buffer:

:C-SPC: mark the current selection
:M-D: kill the selection


magit
~~~~~

* https://magit.vc/

:C-c g: open the Magit Status buffer

Once on this buffer

:s: stage the selected file / chunk / directory
:k: discart the selected file / chunk / directory
:u: unstage the selected file / chunk / directory
:g: refresh buffer
:c c: commit current staged changes
:c a: amend current staged changes to previous commit


projectile
~~~~~~~~~~

:C-p p: switch between projects
:C-c p k: kill all the buffer related to the current project
:C-c p f: find file in current project
:C-c C-s: perform a grep on the current project
:C-c p h: all together
.. :C-c p s g: perform a grep on the current project

  This is also integrated with helm


twittering-mode
~~~~~~~~~~~~~~~

* https://github.com/hayamiz/twittering-mode/

:g: fetch new tweets
:RET: reply
:u: post a new tweet
:C-c C-c: send the tweet once we finish writting
:C-c C-k: cancel the current tweet
:r: show replies
:j: navigate to next tweet
:k: navigate previous tweet
