.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _data-storage:

.. contents::
    :depth: 2

************
Data Storage
************

On this page you will find general information about data storage on the
Spider.

.. _filesystems:

===================
Storage filesystems
===================

.. Project space
 =============


.. _home-storage:

Home
====

Spider provides users with a globally mounted home directory that is
listed as ``/home/[USERNAME]``. This directory is accessible from all nodes.
This is also the directory that you as a user will find yourself in upon first
:ref:`login into <login>` this system. For this home directory we currently
do not apply any hard storage quotas. The data stored in the home folder will
remain available for the duration of your project.

.. _scratch-storage:

Scratch
=======

Each of Spider worker nodes has a large scratch area on local SSD.
These scratch directories enable particularly efficient data I/O for large data
processing pipelines that can be split up into many parallel independent jobs.

Please note that you should only use the scratch space to temporarily store and
process data for the duration of the submitted job. The scratch space is cleaned
regularly in an automatic fashion and hence can not used for long term storage.



.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`
