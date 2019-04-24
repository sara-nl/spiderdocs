.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _data-transfers:

.. contents::
    :depth: 2

**************
Data transfers
**************

On this page you will find general information about data transfers to and from
Spider.

.. _data-transfers-within-ht:

=====================================
Data transfers within Spider
=====================================

To transfer data between directories located within Spider we advise
you to use the unix commands ``cp`` and ``rsync``. Other options may be
available, but these are currently not supported by us.

Help on these commands can be found by (i) typing ``man cp`` or ``man rsync``
on the command line after logging into the system, or (ii) by contacting
:ref:`our helpdesk <helpdesk>`.


.. _data-transfers-to-and-from-ht:

======================================
Data transfers to/from Spider
======================================

To transfer data to and from Spider we advise you to use ``scp``,
``rsync``, ``curl`` or ``wget``. Other options may be available, but these 
are currently not supported by us.

Help on the above commands can be found by (i) typing ``man [COMMAND]`` after
logging into the system. For those cases that require another client for data
transfers, we kindly request that you to contact us via
:ref:`our helpdesk <helpdesk>`.

Data transfers between Spider and dCache
========================================

SURFsara hosts a large storage system which consists of magnetic tape storage and hard disk storage. It uses `dCache system`_ that can store and retrieve huge amounts of data, distributed among a large number of heterogenous server nodes, under a single virtual filesystem tree. You may use the storage if your data does not fit within the storage allocation on Spider project space, or if you wish to use Tape storage.

There are several storage clients that can interact with dCache and we provide here some examples with the clients we support. To use these clients you need to have an X509 Grid certificate and be a part of a Virtual Organisation (VO). Please refer to our Grid documentation page for instructions on `how to get a certificate`_  and `join a (VO)`_. 

In the examples below, a user who is a member of the VO e.g., lsgrid, has the certificate installed on to the Spider login node and will copy data from dCache to/from your home directory on Spider. You may also transfer data to/from your project spaces.

Proxy creation
--------------

To be able to interact with dCache using a storage client, you need to create a proxy. A proxy is a short-lived certificate/private key combination which is used to perform actions on your behalf without using passwords. With the following command you can set the default path for the proxy you will generate such that it is accessible from anywhere on Spider.

.. code-block:: console
  
   export X509_USER_PROXY=$HOME/.proxy


You may also add the above command to your $HOME/.bashrc file so that this path is defined for your future logins. Now issue the following command to create a local proxy. The pass phrase you are asked for, is your certificate password: 

.. code-block:: console
  
   voms-proxy-init --voms lsgrid


You will see the following output in your terminal:

.. code-block:: console
  
   Enter GRID pass phrase for this identity:
   Contacting voms.grid.sara.nl:30018  [/O=dutchgrid/O=hosts/OU=sara.nl/CN=voms.grid.sara.nl] "lsgrid"...
   Remote VOMS server contacted successfully.
   Created proxy in /tmp/x509up_u39111.
   Your proxy is valid until Thu Jan 05 02:07:29 CET 2016


You can inspect your local proxy with the command:

.. code-block:: console
  
   voms-proxy-info -all


Globus client
-------------
Please note that you need a valid proxy as described above to run the following commands.

* Listing directories on dCache:

  .. code-block:: console
  
     globus-url-copy -list gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/lsgrid/

* Copy file from dCache to Spider:

  .. code-block:: console

     globus-url-copy \
         gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/lsgrid/path-to-your-data/your-data.tar \
         file:///`pwd`/your-data.tar 

* Copy file from Spider to dCache:

  .. code-block:: console

     globus-url-copy \
         file:///$HOME/your-data.tar \
         gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/lsgrid/path-to-your-data/your-data.tar 

* Copy directory from dCache to Spider:

 First create the directory locally, e.g. testdir.

 .. code-block:: console

    globus-url-copy -cd -r \
     gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/lsgrid/path-to-your-data/testdir/ \
     file:///$HOME/testdir/

The ``globus-*`` client does not offer an option to create/delete directories or delete files. For this purpose you may use the gfal client as described below.

gfal client
-----------
Please note that you need a valid proxy as described above to run the following commands.

* Listing directories on dCache:

 .. code-block:: console
  
     gfal-ls -l gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/lsgrid/

* Create directory on dCache:

 .. code-block:: console
  
     gfal-mkdir gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/lsgrid/path-to-your-data/newdir/

* Copy file from dCache to Spider:


  .. code-block:: console

     gfal-copy \
         gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/lsgrid/path-to-your-data/your-data.tar \
         file:///`pwd`/your-data.tar 

* Copy file from Spider to dCache:

  .. code-block:: console

     gfal-copy \
         file:///$HOME/your-data.tar \
         gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/lsgrid/path-to-your-data/your-data.tar 


* Remove a file from dCache:

  .. code-block:: console

     gfal-rm gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/lsgrid/path-to-your-data/your-data.tar 


* Remove a whole (non empty) directory from dCache:

  .. code-block:: console

     gfal-rm -r gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/lsgrid/path-to-your-data/
 
Recursive transfer of files (transferring a directory) is not supported with the gfal-copy command. For this purpose you may use globus-url-copy.

.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`


.. Links:

.. _`dCache system`: https://www.dcache.org/
.. _`how to get a certificate`: http://doc.grid.surfsara.nl/en/latest/Pages/Basics/prerequisites.html#get-a-grid-certificate
.. _`join a (VO)`: http://doc.grid.surfsara.nl/en/latest/Pages/Basics/prerequisites.html#join-a-virtual-organisation

.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`
