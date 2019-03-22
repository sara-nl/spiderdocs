.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _available-software:

.. contents::
    :depth: 2

******************
Available software
******************

On this page you will find general information about software on Spider.

.. _os-version:

===================================
Operating system on Spider
===================================

The operating system (OS) on Spider is CentOS 7.5.1804 (Core).
This OS and its setup is identical on all nodes (i.e., login and worker nodes).

.. _installed-software:

==================
Installed software
==================

The standard supported login shell on Spider is bash. The standard supported software setup is
identical on all nodes. Here we support basic unix functionality, software compilers (e.g., gcc, g++, f95) and editors
(e.g., vi, vim, emacs, nano and edit). The use of graphical tools is supported via X11 ssh
forwarding on the login node.

In those cases where software is missing and this software can not be installed
in :ref:`user space <userspace-sw>` or be provided via a
:ref:`Singularity image <singularity>` you may contact us via
:ref:`our helpdesk <helpdesk>` to evaluate other options to make your software
available on Spider.

.. _job-scheduler:

================
Workload manager
================

We support batch scheduling of jobs on Spider via the Slurm workload
manager. The currently installed version of Slurm can be obtained by by typing
``sinfo --version`` on the command line after :ref:`login <login>` into the system.
Specific HT-related Slurm information and job scheduling can be found in section
'Compute on Spider' and more generic info can be found at the
`Slurm documentation page`_.


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:
.. _`Slurm documentation page`: https://slurm.schedmd.com/
