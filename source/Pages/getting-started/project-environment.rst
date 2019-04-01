.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _project-environment:

.. contents::
    :depth: 2

********************
Project environment
********************

As a user on Spider you are a member of a project, and each project member gets
access to the following services:

1. Login node

2. Project spaces

.. 3. Compute: which partitions and nodes are available be default?
 4. Software: cvmfs a standard service by default or only upon request
 5. Extra services: If the above are not default, these can be listed as extra services avaialable upon request. Also to decide - reservations, courses, etc.

==========
Login node
==========

This is your entry and access point to Spider. From this node you can submit
jobs, transfer data and prototype your application. It has a software
environment very similar to the worker nodes where your submitted jobs will run.

==============
Project spaces
==============

The project spaces is a place for a project team to collaborate. Each member
within a project has a role which determines the permissions he has on the
different project directories.

Project roles
=============

* *technical lead* role: the contact person for any technical matters that affect the design and execution of the project and the privileges of other members
* *data manager* role: designated data dissemination manager; responsible for the management of project owned data
* *software manager* role: designated software manager; responsible to install and maintain the project owned software
* *normal user* role: scientific users who focus on their data analysis

Project directories
===================

Project space is a POSIX storage place allocated to a certain project. It includes the following shares:

* ``/home/$USER``: each project member in a project has her/his personal home space. Only the account owner can read and write data in this directory
* ``/project/[PROJECTNAME]/Data``: any project-specific data. Any member of the project can read data in this directory, but only the data manager(s) can write data
* ``/project/[PROJECTNAME]/Software``: any project-specific software. Any member of the project can read/execute software in this directory, but only the software manager(s) can install software
* ``/project/[PROJECTNAME]/Share``: any data to be shared among the project members. Any member of the project can read and write data in this directory
* ``/project/[PROJECTNAME]/Public``: Any member of the project can write in this directory. Any data stored here will be read-only by all users on Spider and exposed publicly via http (not implemented yet).


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`
