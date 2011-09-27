===================
Emacs Configuration
===================

Instalation
-----------

1. Clone this repository with the command::

   cd ~
   git clone git://github.com/humitos/emacs-configuration.git

1. You can rename it with the `standard` emacs name for this folder::

   mv emacs-configuration .emacs.d

1. Put in your `~/.emacs`::

   (load "~/.emacs.d/emacs-init-file.el")


ERC
---

If you want to auto-connect to IRC, you have to create another file
where you will put your nick / pass and your full name::

      touch ~/.ercpass.el

With the following information::

     (setq freenode-password "your-password-goes-here")
     (setq freenode-nick "your-password-goes-here")
     (setq freenode-full-name "your-password-goes-here")

