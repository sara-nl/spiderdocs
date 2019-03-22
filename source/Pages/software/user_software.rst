.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _user-software:

.. contents::
    :depth: 2

***********************
User installed software
***********************

.. _userspace-sw:

======================
Software on user space
======================

Software that does not require sudo rights or root privileges can be setup in
user-space. In order to make this software available on all nodes for your jobs
we advise you to place/compile such software in your globally mounted home
directory.

.. _user-sw-setup-sharing:

=================
Setup and sharing
=================

User installed software in the home directory can be shared amongst different
users by setting the appropriate user permissions on the installed software
directory and files. This can be done via the ``chmod`` command and help on this
commands can be found by typing ``man chmod`` on the command line after
:ref:`login <login>` into the system.


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`
