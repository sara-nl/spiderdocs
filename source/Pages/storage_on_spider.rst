.. _storage-on-spider:

*****************
Storage on Spider
*****************

.. Tip:: Spider is meant for processing of big data, thus it supports several storage backends. In this page you will learn:

     * which internal and external storage systems we support
     * best practices to manage your data


.. _internal-storage:

================
Internal storage
================

The available filesystems on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`
are CephFS and SSDs. Home and project spaces are mounted on CephFS, while the batch worker nodes have
large scratch areas on local SSD.

CephFS is a distibuted parallel filesystem which stores files as objects and it is suitable for workloads
that deal with comparably large files. Please note that conda/pip packages handling lots of small files can
slow down the system response. For high I/O performance, we recommend the local scratch of the worker nodes on SSDs.

.. _transfers-within-spider:

Transfers within Spider
=======================

To transfer data between directories located within
:abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` we advise
you to use the unix commands ``cp`` and ``rsync``. Other options may be
available, but these are currently not supported by us.

Help on these commands can be found by (i) typing ``man cp`` or ``man rsync``
on the command line after logging into the system, or (ii) by contacting
:ref:`our helpdesk <helpdesk>`.


.. _filesystems:

Spider filesystems
==================

.. _home-fs:

Using Home
----------

:abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` provides to each user with a globally mounted
home directory that is listed as ``/home/[USERNAME]``. This directory is
accessible from all nodes.
This is also the directory that you as a user will find yourself in :ref:`upon first
login <getting-around>` into this system. The data stored in the home folder will
remain available for the duration of your project.

.. _scratch-fs:

Using scratch
-------------

Each of :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` worker nodes has a large scratch area on local SSD.
These scratch directories enable particularly efficient data I/O for large data
processing pipelines that can be split up into many parallel independent jobs.

Please note that you should only use the scratch space to temporarily store and
process data for the duration of the submitted job. The scratch space is cleaned
regularly in an automatic fashion and hence can not used for long term storage.

For more information about how to use scratch during your compute jobs, please see the compute section.
.. _project-space-fs:

Using project spaces
--------------------

Similarly to home folders Spider's project spaces are also available on all worked nodes, the following paths are
available on your :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` UI:

* ``/project/[Project Name]/Data``
* ``/project/[Project Name]/Public``
* ``/project/[Project Name]/Share``
* ``/project/[Project Name]/Software``

This allows you to easily access your software, data and output from the worker nodes from the project spaces.
See below for an example of a command that could be executed from a script on a worker node:

.. code-block:: bash

        sh /project/[Project Name]/Software/[script].sh /project/[Project Name]/Data/[input file(s)] /home/[USER]/[output]

.. _scientific-catalog-fs:

Using scientific catalogs
-------------------------

Scientific catalogs allow for you to share software and data repositories accross projects. For example if you would
like to share a large biobank of data with other research projects you could request access
to upload to the scientific catalogue. Then it will be accessible from the worker nodes similarly to the ``/home`` and ``/project``
folders.

To request access to add a shared catalogue please reachout to :ref:`our helpdesk <helpdesk>`.

.. _query-internal-storage:

Querying internal storage usage
-------------------------------

As a mounted filesystem spider storage can be queried with local linux commands, but for optimal performance we recommend querying some preconfigured `fattr` tags instead of `du` commands that slow down the system.

The total usage of local spider storage is the total usage of projct home folders and project space together.

Please note that this will show your current usage, not the max, or average for the month.

**Example**

.. code-block:: bash

   # Project folder
   getfattr -n ceph.dir.rbytes --absolute-names /project/[PROJECT]/

   # Home folder
   getfattr -n ceph.dir.rbytes --absolute-names /home/[PROJECT]-[USER]


.. _external-storage:

================
External storage
================

.. _transfers-to-and-from-spider:

Transfers from own system
=========================

If you are logged in as a user on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` then we support ``scp``, ``rsync``,
``curl`` or ``wget`` to transfer data between :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` and your own Unix-based system.
Other options may be available, but these are currently not supported by us.

* Example of transferring data from :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` to your own system:

.. code-block:: bash

   # Using scp
   scp [spider-username]@spider.surfsara.nl:[path-to-your-spider-folder]/transferdata.tar.gz [path-to-your-local-folder]/

   # Using rsync
   rsync -a -W [spider-username]@spider.surfsara.nl:[path-to-your-spider-folder]/transferdata.tar.gz [path-to-your-local-folder]/

* Example of transferring data from your own system to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`:

.. code-block:: bash

   # Using scp
   scp [path-to-your-local-folder]/transferdata.tar.gz [spider-username]@spider.surfsara.nl:[path-to-your-spider-folder]/ 

   # Using rsync
   rsync -a -W [path-to-your-local-folder]/transferdata.tar.gz [spider-username]@spider.surfsara.nl:[path-to-your-spider-folder]/ 


.. _using-dcache:

SURFsara dCache
===============

dCache is our large scalable storage system for quickly processing huge volumes of data.
The system runs on `dCache software`_, that is designed for managing scientific data.
You can use dCache for disk or tape, or address both types of storage under a single
virtual filesystem tree. Our dCache service is a remote storage with an extremely fast network
link to Spider. You may use the storage if your data does not
fit within the storage allocation on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` project space or if your application is I/O intensive.

There are several protocols and storage clients to interact with dCache. On :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` we support
two main methods to use dCache, ADA and Grid interfaces:

.. toctree::
   :maxdepth: 1

   storage/ada-interface

Our ADA (Advanced dCache API) interface is based on the dCache API and the webdav
protocol to access and process your data on dCache from any platform and with various authentication methods.

.. toctree::
  :maxdepth: 1

  storage/grid-interface

Our Grid interface is based on the Grid computing technology and the gridftp protocol
to access and process your data on dCache from Grid compliant platforms and with X509
certificate authentication.

.. * :ref:`ADA (Advanced dCache API) interface <ada-interface>` (soon in production!)


.. * :ref:`Grid interface <grid-interface>`


.. .. _using-swift:

.. SURFsara SWIFT
.. ==============
.. Coming soon ..

.. _using-archive:

SURFsara Central archive
========================

For long-term preservation of precious data SURFsara offers the `Data Archive`_.
Data ingested into the Data Archive is kept in two different tape libraries
at two different locations in The Netherlands. The Data Archive is connected
to all compute infrastructures, including :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`.

Access on Data Archive is *not* provided by default to the :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` projects. To request for Data Archive access, please contact our
:ref:`our helpdesk <helpdesk>`.

If you already have access on Data Archive, then you can use it directly from :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` by
using ``scp`` and ``rsync`` to transfer data between :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` and Data Archive:


* Transfer data from :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` to Data Archive:

.. code-block:: bash

   # Using scp
   scp /home/[USERNAME]/transferdata.tar.gz [ARCHIVE_USERNAME]@archive.surfsara.nl:/home/[ARCHIVE_USERNAME]/

   # Using rsync
   rsync -a -W /home/[USERNAME]/transferdata.tar.gz [ARCHIVE_USERNAME]@archive.surfsara.nl:/home/[ARCHIVE_USERNAME]/

* Transfer data from Data Archive to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`:

.. code-block:: bash

   # Using scp
   scp [ARCHIVE_USERNAME]@archive.surfsara.nl:/home/[ARCHIVE_USERNAME]/transferdata.tar.gz /home/[USERNAME]/

   # Using rsync
   rsync -a -W [ARCHIVE_USERNAME]@archive.surfsara.nl:/home/[ARCHIVE_USERNAME]/transferdata.tar.gz /home/[USERNAME]/

In case that the file to be retrieved from Data Archive to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` is not
directly available on disk then the scp/rsync command will hang until the file is
moved from tape to disk. Data Archive users can query the state of their files by
logging into the Data Archive user interface and performing a ``dmls -l`` on the files
of interest. Here the state of the file is either on disk (REG) or on tape (OFL).
The Data Archive user interface is accessible via ``ssh`` from anywhere for users that
have a login account and an example is given below:

.. code-block:: bash

        ssh [ARCHIVE_USERNAME]@archive.surfsara.nl
	      touch test.txt
	      dmls  -l test.txt
	      -rw-r--r--  1 homer    homer    0 2019-04-25 15:24 (REG) test.txt

Best practices for the usage of Data Archive are described on the `Data Archive`_ page.



.. _quota-policy:

============
Quota policy
============

Each :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` is granted specific compute and storage
resources in the context of a project. For these resources there is currently
**no hard quotas**. However, we monitor both the core-hour consumption
and storage usage to prevent that users exceed their granted allocation.

.. _backup-policy:

=============
Backup policy
=============

The data stored on CephFS (home and project spaces) is disk only,
replicated three times for redundancy. For disk-only data there is **no backup**.
If you cannot afford to lose this data, we advise you to copy it elsewhere as well.


=====================
Data Ownership Policy
=====================

The data stored in the /project folder is owned by the grant's signing authority. If data is owned by a user who has
left the project in the /project folder we ask that you request that user change the ownership to an active project 
member before leaving. 

The data stored in the /home folders is owned by individual users of those folders and can not be transferred to
another user without their consent. We are also obligated to remove a users data no more than 6 months after 
they have left the project.

.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:

.. _`Data Archive`: https://userinfo.surfsara.nl/systems/data-archive
.. _`Sylabs documentation`:  https://www.sylabs.io/docs/
.. _`dCache software`: https://www.dcache.org/
