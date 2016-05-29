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


Modules included in this configuration
--------------------------------------

* ace-jump-mode
* any-ini-mode
* auto-complete
* company
* dockerfile-mode
* elpy
* expand-region
* fill-column-indicator
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
