.. toctree::
   :hidden:

.. _doc-style:

****************
Style guidelines
****************

This page provides some style guidelines for Spider documentation.

=======
General
=======

* Use simple language. Not "The command results in an effective release of the file", but "The command releases the file".

========
Acronyms
========

* In general: avoid acronyms. When you want to use them, the first occurrence on a page should explain them: CephFS (Ceph File System).
* Sphinx supports a :abbr: tag, see http://www.sphinx-doc.org/en/stable/markup/inline.html#other-semantic-markup. Here's a test: :abbr:`CA (Certificate Authority)`

==============
Shell commands
==============

* When you want to display commands and their output, use ``.. code-block:: console``. Prefix each command with a ``$``, without space.

  .. code-block:: console

     $echo 'Hello World!'
     Hello World!

* When you want to display commands and comments, use ``.. code-block:: bash``. Don't prefix commands. Example:

  .. code-block:: bash

     # [homer@htp-ui ~]$ is the first prompt upon login
     ssh [USERNAME]@[Spider HOSTNAME]

* When you want to display commands, output and comments, use ``.. code-block:: console``. Prefix commands with a ``$`` and prefix comments with ``##``, otherwise they are marked up as a command. Example:

  .. code-block:: console

     $echo 'Hello World!'
     Hello World!
     ## Comments should be prefixed with a double ``#``.

* To display the contents of a shell script, use ``.. code-block:: bash``.
* To display configuration files, use ``.. code-block:: cfg``.


Markup
======

* ``literal markup`` for:

  * pieces of code
  * commands
  * arguments
  * file names, hostnames
  * a specific term, when emphasis is on its name
  * configuration file statements and values

* **Bold** for strong emphasis. Example: "**Only you** are allowed to know the contents of this key."
* *italic* for moderate emphasis. Example: "You can continue only *after you* have completed the preparations."
