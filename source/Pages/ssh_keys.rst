.. _ssh-keys:

==================================
Generate a private/public key pair
==================================

Open a terminal and type the following command:

.. code-block:: bash

   ssh-keygen

While interacting with `ssh-keygen` in the terminal, you will see something similar to:

.. code-block:: bash

   Generating public/private rsa key pair.
   Enter file in which to save the key (~/.ssh/id_rsa): ### see note 1 below
   Enter passphrase (empty for no passphrase): ### see note 2 below
   Enter same passphrase again:
   Your identification has been saved in ~/.ssh/id_rsa
   Your public key has been saved in ~/.ssh/id_rsa.pub
   The key fingerprint is:
   40:1f:33:78:32:51:b5:c4:51:56:99:b6:6a:3d:18:8b user@computer.surfsara.nl
   The key s randomart image is:
   +---[RSA 2048]----+
   |                 |
   |               ..|
   |      .       .o.|
   |       + +.o  o+ |
   |      + S.B.o.+.o|
   |       E =++oooo+|
   |      . =oo= ++.=|
   |       *....Bo = |
   |      o.o..+o..  |
   +----[SHA256]-----+

Some notes:

[1]. You can leave the output file name blank (simply hit enter) for the default file name, or type a variation of `~/.ssh/my_chosen_name`.

[2]. You can leave the passphrase field empty but we strongly recommend you to choose and remember an easy but long passphrase. If you
forget the passphrase, you need to generate a new key pair and replace the old public keys you installed on remote hosts.

The ssh-agent (see below) will assist you so that you only need to type the
passphrase once per session.

Using an SSH agent
==================

SSH-agent is a service on your computer to remember your ssh passphrase during your
local session (that is, until you log out). This way, you do not have to type in that
loooong passphrase every time you need to unlock your private key.

* Add the key to the local ssh-agent

Type the following on your terminal:

.. code-block:: bash

   ssh-add ~/.ssh/id_rsa ### or the file name you provided to ssh-keygen


* While interacting with `ssh-add` in the terminal, you will see something similar to:

.. code-block:: bash

   Enter passphrase for ~/.ssh/id_rsa: ### type it in
   Identity added: ~/.ssh/id_rsa


If this fails because "Could not open a connection to your authentication agent", you need to start the ssh-agent daemon before you run `ssh-add`:

.. code-block:: bash

   eval `ssh-agent -s`


* To list the keys loaded in the `ssh-agent` type the following on your terminal:

.. code-block:: bash

   ssh-add -l

The output will be one line for each key stored in the ssh-agent, similar to:

.. code-block:: bash

   2048 SHA256:ajAxT3T3ZKl2rALBGGmMqufU0n6XAU15lj+fObZEvrI ~/.ssh/id_rsa (RSA)
