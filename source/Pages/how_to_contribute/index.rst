
.. _doc-howto:

********************
Documentation how-to
********************

This page explains how you can contribute to the documentation with your ideas
for corrections and improvements. All documentation is hosted on Github and it
is written in `Sphinx`_ *restructed text*. Behind the scenes we use `ReadTheDocs`_
to automatically publish the documentation.

You can contribute to this wiki with any of the following ways:

* Contributing through GitHub: add and improve the documentation directly to our `Spider Github repo`_
* Contributing through Helpdesk: just contact :ref:`our helpdesk <helpdesk>` with your remarks and we will change the documentation ourselves. Any contribution is welcome!

The instructions below explain how to to contribute with your proposed changes
directly on Github.

.. _contribute-github:

=========================
Contribute through GitHub
=========================

You are welcome to add and improve the documentation directly to the repository.
For this, you’ll need a GitHub account and a little knowledge of git (see
`GitHub’s git cheat sheet <https://help.github.com/articles/git-cheatsheet/>`_).

When changes are committed using Git and pushed to the SURFsara GitHub
repository, the documentation is automatically rebuild and published by
readthedocs.org.

The main steps to submit your changes are:

1. `Fork <https://help.github.com/articles/fork-a-repo/>`_ our `Spider Github repo`_
2. Git pull your fork
3. Make your changes, commit and push them back to GitHub
4. Create a `pull request <https://help.github.com/articles/proposing-changes-to-a-project-with-pull-requests/>`_ to inform us of your changes
5. After we’ve reviewed and accepted your work, we will merge your commits and the documentation will be updated automatically


.. _edit-with-sphinx:

================
Edit with Sphinx
================

When you contribute directly to our Github repo we ask you to write the changes
in Sphinx language. The philosophy of Sphinx documentation is that content is stored in files that
can be easily read *and* edited by humans, in a format called
*restructured text*, with the file extension ``.rst``. Using a simple grammar,
text can be styled. The document is structured using special tags; using these
tags, documentation can be split into multiple files, and you can cross-reference
between files and build indexes.

Although Sphinx is quite intuitive, we have some links to help you use the
Sphinx syntax:

 * A simple Sphinx cheatsheet: :ref:`cheatsheet`
 * Some :ref:`style guidelines <doc-style>` to encourage a consistent style


.. _preview-changes:

===============
Preview changes
===============

Because the syntax of the files is human readable, you can edit the files using
your favorite text editor. Once you are done editing, you can generate
documentation in various formats, such as HTML or epub. While you can edit the
pages on virtually any system, it is recommended to preview your changes before
publishing them.

There are different ways to generate the HTML documentation from source and
review your changes:

* Docker image
* Sphinx local installation
* GitHub edit/preview

Note that you only need to use one of the options mentioned above. Using Docker
is the preferred way, as this mimics the ReadTheDocs build system closest.
GitHub edit/preview on the other hand is good enough for minor, textual changes,
but is otherwise the least preferred option.

.. _test-on-docker:

Docker image
============

This is the preferred option to build and test your changes. It tries to build
the documentation the same way as readthedocs.org.

* Setup the Docker image. The instructions are :ref:`here <docker-install>`
* Once build, you can use it to build your documentation in the same build environment as used by their production server::

    ./build.sh

.. note:: For Mac OS X, please use ``./build_mac.sh`` instead.

Optionally you can provide an output location (default: ./build) and the docker image name (default: readthedocs/build)::

    ./build.sh /alternative/output/path/ docker_image_alternative_name

.. _test-on-sphinx:

Sphinx local installation
=========================

For the Sphinx documentation setup locally you will need to:

* Install Sphinx to your computer. The instructions for different OS are :ref:`here <sphinx-install>`
* ``Clone`` the current repo locally to fetch the source code or ``pull`` to update your local copy with the latest changes.
* To generate HTML documentation, use the command::

    make html

which will generate static pages in the ``build``-directory as long as you have the software Sphinx installed locally.

.. _test-on-github:

Github edit/preview
===================

For small changes you can edit a page directly from the GitHub repo. The
`preview` button does not give a fully compatible *rst* overview, but is
sufficient for textual changes.

.. _publish:

===============
Publish changes
===============

When you are done with your changes, commit and push to GitHub. See
:ref:`contribute-github` on how to push your changes to our documentation.


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`


.. _`Spider Github repo`: https://github.com/sara-nl/spiderdocs
.. _`Sphinx`: http://www.sphinx-doc.org
.. _`ReadTheDocs`: https://readthedocs.org/
