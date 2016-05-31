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
* find-file-in-project
* flycheck
* highlight-indentation
* jedi
* magit
* powerline
* projectile
* py-autopep8
* py-docformatter
* py-isort
* python-environment
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
:C-c C-s: performs a `grep -r` in the current project
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


flycheck
~~~~~~~~

* http://www.flycheck.org/

:C-c C-n: go to the next Flycheck error
:C-c C-p: go to the previous Flycheck error

(`elpy` already has some hotkeys for this, but I'm using Flycheck
instead of Flymake, which is the default for elpy)


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
