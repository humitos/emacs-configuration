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

#. Install necessary packages::

     mkvirtualenv emacs-elpy
     pip-sync requeriments.txt

