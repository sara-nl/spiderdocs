.. _cheatsheet:

**********
Cheatsheet
**********

Look at the raw version of this file to compare the source and build version:
:download:`sphinx_cheatsheet.rst`

The first lines of this page will also be explained later on in this document
(see *Links* and *Titles*)

.. this is a comment, it will not be displayed

.. See also the online editor: http://rst.ninjs.org/


.. ============ Text fonts ===============

*Moderate emphasis*

**Strong emphasis**

``This is text in Courier``

This is plain text.

* Use ``literal markup`` for:

  * pieces of code
  * commands
  * arguments
  * file names, hostnames
  * a specific term, when emphasis is on its name
  * configuration file statements and values


* Acronyms:

In general: avoid acronyms. When you want to use them, the first occurrence on
a page should explain them: CephFS (Ceph Filesystem). Sphinx supports a
:abbr: tag, see http://www.sphinx-doc.org/en/stable/markup/inline.html#other-semantic-markup. Here's a test: :abbr:`CephFS (Ceph Filesystem)`


.. ============= Bullets =================

* This is a bulleted list.
* ...

1. This is a numbered list.
2. It has two items.

* this is
* a list

  * with a nested list
  * and some subitems

* and here the parent list continues


.. ============ Links ===============

`Python <http://www.python.org/>`_

or

`SURFsara website`_ (see bottom of the document; that is were we tell Sphinx were SURFsara website should point to)

This is an implicit link to title:

`Sample H2`_

Internal wiki link:

Reference tag: place above a title: .. _my-reference-label:

Then refer to it from another page as. For example, for this cheatsheet: :ref:`cheatsheet` or ref:`other label <cheatsheet>`


.. ============ Titles ===============

******************
H1: document title
******************

=========
Sample H2
=========

Sample H3
=========

Sample H4
---------

Sample H5
`````````

Sample H6
.........

And some text.


.. ============ Tables ===============

+------------+------------+-----------+
| Header 1   | Header 2   | Header 3  |
+============+============+===========+
| body row 1 | column 2   | column 3  |
+------------+------------+-----------+
| body row 2 | Cells may span columns.|
+------------+------------+-----------+
| body row 3 | Cells may  | - Cells   |
+------------+ span rows. | - contain |
| body row 4 |            | - blocks. |
+------------+------------+-----------+

or

==================   ============
Column1              Column2
==================   ============
value1               40
value2               41
value3               42
==================   ============



.. ============ Note boxes ===============

.. WARNING::
   This is a **warning** box.

.. Note::
   This is a **note** box.

.. Tip::
   This is a **tip** box.

.. Error::
   This is an **error** box.

.. seealso:: This is a simple **seealso** note.

.. topic:: Your Topic Title

    Subsequent indented lines comprise
    the body of the topic, and are
    interpreted as body elements.

.. sidebar:: Sidebar Title
    :subtitle: Optional Sidebar Subtitle

    Subsequent indented lines comprise
    the body of the sidebar, and are
    interpreted as body elements.


.. ============== Files ====================

:file:`path/to/myfile.txt`

:download:`A file for download <sphinx_cheatsheet.rst>`

.. image:: /Images/surf_logos/SURF_SARA_fc.png
    :width: 200px
    :align: center
    :height: 100px


.. ============== Code ====================

* When you want to display commands, output and comments, use ``.. code-block:: console``. Prefix commands with a ``$`` and prefix comments with ``##``, otherwise they are marked up as a command. Example:

  .. code-block:: console

     $echo 'Hello World!'
     Hello World!
     ## Comments should be prefixed with a double ``#``.


* When you want to display commands and comments, use ``.. code-block:: bash``. Don't prefix commands. Example:

   .. code-block:: bash

      # [homer@htp-ui ~]$ is the first prompt upon login
      ssh [USERNAME]@[Spider HOSTNAME]


* You can add line numbers to code examples with the :linenos: parameter.

.. code-block:: bash
   :linenos:

   # [homer@htp-ui ~]$ is the first prompt upon login
   ssh [USERNAME]@[Spider HOSTNAME]

* To display the contents of a shell script, use ``.. code-block:: bash``.
* To display configuration files, use ``.. code-block:: cfg``.


.. _`SURFsara website`: https://surfsara.nl/
