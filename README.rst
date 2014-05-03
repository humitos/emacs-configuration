===================
Emacs Configuration
===================

Installation
-----------

#. Install some dependencies::

     sudo pip install -e git://github.com/davidhalter/jedi.git#egg=jedi
     sudo pip install pychecker pylint pyflakes
     sudo pip install -e git://github.com/davidhalter/jedi.git@4ff8b921a3b252895ed43b9598a5a40f0cbd487c#egg=jedi-master
     sudo pip install emacs-jedi/

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


ERC
---

If you want to auto-connect to IRC, you have to create another file
where you will put your nick / pass and your full name::

      touch ~/.ercpass.el

With the following information::

     (setq freenode-password "your-password-goes-here")
     (setq freenode-nick "your-password-goes-here")
     (setq freenode-full-name "your-password-goes-here")


Install Python necessary modules
--------------------------------

I created a virtualenv to install this modules in my own way, without
depending on the system configuration and its modules.

These modules are related with `Rope`, `ropemacs`, `rope-mode`,
`Pymacs`, `pep8`, `pyflakes`, `pylint` and `cssutils`.

Those modules are used by some emacs modules like `flymake`,
`python-mode`, etc.

I have `virtualenvwrapper` configured, so the following command are
related with this script.

#. Create a new virtualenv::

     mkvirtualenv --no-site-packages --python=python2.7

#. Install necessary packages::

     pip install -r python-pip-requeriments.txt


Packages needed
---------------

::

     sudo apt-get install pylint
