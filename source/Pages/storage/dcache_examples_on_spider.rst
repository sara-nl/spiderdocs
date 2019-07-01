.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _dcache-examples:

***************
dCache examples
***************

In the examples below, a user who is a member of the VO e.g., lsgrid, has the
certificate installed on to the Spider login node and will copy data from dCache
to/from your home directory on Spider.

============
Grid clients
============


Globus client
=============

Please note that you need a valid proxy to run the following commands.

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
===========

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


==============================================================
Using local ``/scratch`` with input/output data from/to dCache
==============================================================

Below we show another example where local ``/scratch`` is used and the input/output data are stored on dCache.
You need a valid proxy to interact with dCache using the storage clients.

Here is a job script template for ``$TMPDIR`` usage;

.. code-block:: bash

   #!/bin/bash
   #SBATCH -N 1      #request 1 node
   #SBATCH -c 1      #request 1 core and 8GB RAM
   #SBATCH -t 5:00   #request 5 minutes jobs slot

   mkdir "$TMPDIR"/myanalysis
   cd "$TMPDIR"/myanalysis
   gfal-copy gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/path-to-your-data/your-data.tar file:///`pwd`/your-data.tar

   # = Run you analysis here =

   #when done, copy the output to dCache
   tar cf output.tar output/
   gfal-copy file:///`pwd`/output.tar gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/path-to-your-data/output.tar
   echo "SUCCESS"
   exit 0
Please note that in the above example, it is assumed that the data is present on the disk storage on dCache. If the data is stored on Tape, it may need to be copied to disk first (called as staging). We refer to the Grid documentation on how to `stage`_ data.
