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
--------------------------------------

* ace-jump-mode
* elpy
* expand-region
* find-file-in-project
* flycheck
* highlight-indentation
* jedi
* magit
* paredit
* powerline
* projectile
* py-autopep8
* py-docformatter
* py-isort
* python-environment
* rainbow-delimiters
* solarized-theme
* undohist
* web-mode
* yasnippet


ace-jump-mode
~~~~~~~~~~~~~

* https://github.com/winterTTr/ace-jump-mode

:C-c SPC: jump to any place in the buffer with just a hotkey plus a
          position key


expand-region
~~~~~~~~~~~~~

* https://github.com/magnars/expand-region.el

:C-=: mark region based on semantics

      
find-file-in-project
~~~~~~~~~~~~~~~~~~~~

* https://github.com/technomancy/find-file-in-project

:C-c C-f: Find a file in the current project. This uses a
          search-as-you-type interface for all files under the project
          root.

(this hotkey comes from `elpy`)


flycheck
~~~~~~~~

* http://www.flycheck.org/

