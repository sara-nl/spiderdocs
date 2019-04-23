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


=========
Softdrive 
=========

Softdrive is the service that allows you to install software in a central place and distribute it *automagically* across any compute cluster (or even your own laptop) that has `CVMFS` installed & configured and has the softdrive.nl directory mounted. You install the software once, and it will be available on all clusters, to all users. This means that Softdrive through the CVMFS service acts as a virtual drive for your software. 

Here we will guide you on how to access and use Softdrive for Spider. Please note that at SURFsara the Softdrive service is provided through our Grid services. The use of Softdrive is however not limited to the Spider and the Grid alone, as it can equally well be applied to your `own computer`_ or in `cloud environments`_. 

.. _cvmfs:

CVMFS
=====

Softdrive is using the `CVMFS service`_ (short for CernVM File System) on the background. CVMFS is a network file system based on HTTP and optimized to deliver experiment software in a fast, scalable, and reliable way. 


Quickstart
==========

In this example, we will distribute a few small files to all nodes on Spider. This should give you an idea of what is possible with *Softdrive*.

Softdrive works by logging in to the software distribution node, and putting your files there. Next, you tell the software distribution system that you are ready installing files. These files will then be made available on all nodes.


Access
------

Users of the Spider are entitled to use Softdrive without the need for a separate resource request. You can request access by sending an e-mail with your current project allocation id to helpdesk@surfsara.nl.


Logging in on the softdrive 
---------------------------

Once access has been arranged, you can log in on the software distribution node, using your Spider login credentials:

.. code-block:: console

	ssh homer@softdrive.grid.sara.nl # replace homer with your username

In your home-directory (e.g. ``/home/homer``), you will find a *README* file with detailed information about the *Softdrive* usage.


Distributing an example file
----------------------------

To demonstrate distributing files to all Spider nodes, create a file and a directory within your home directory on Softdrive:

.. code-block:: bash

        # a test directory and a file
        softdrive.grid.sara.nl:/home/homer$ mkdir -p test_dir
        softdrive.grid.sara.nl:/home/homer$ echo "Hello world" > test_dir/hello.txt

To make this directory file available on all nodes on Spider, you have to copy the ``test_dir`` under ``/cvmfs/softdrive.nl/$USER``:

.. code-block:: bash

        softdrive.grid.sara.nl:/home/homer$ cp -r test_dir /cvmfs/softdrive.nl/homer # replace homer with your username

* To force the update everywhere on Spider, trigger publication by executing command:

.. code-block:: bash

        publish-my-softdrive
    
Updating the software on all Spider nodes can take up to two hours.

.. note:: You need to run the command ``publish-my-softdrive`` each time you make a change in your ``/cvmfs/softdrive.nl/$USER`` directory in order to take effect on Spider and the Grid sites.

 
Finding your files on the Spider nodes
------------------------------------

On Spider nodes, your Softdrive files will be available under:

.. code-block:: console

	/cvmfs/softdrive.nl/homer/ # replace homer with your username
  
Log in to Spider and check whether your files are there:

.. code-block:: console  
  
        ls /cvmfs/softdrive.nl/homer/ 
        drwxr-xr-x 17 cvmfs cvmfs 4096 Dec 16 12:11 test_dir
    

.. note:: If your software is statically compiled, then copying the executables from your home directory to ``/cvmfs/softdrive.nl/$USER/`` should work. Just remember to export the ``/cvmfs/softdrive.nl/$USER`` software paths into your Spider scripts or your ``.bashrc`` file. In other cases with library path dependencies, we advice you to install your software directly under ``/cvmfs/softdrive.nl/$USER`` or use a prefix. An example of software installation in Softdrive can be found in section `anaconda on Grid`_.



.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:
.. _`own computer`: http://doc.grid.surfsara.nl/en/latest/Pages/Advanced/softdrive_on_laptop.html#softdrive-on-laptop
.. _`cloud environments`: https://doc.hpccloud.surfsara.nl/softdrive
.. _`CVMFS service`: https://cernvm.cern.ch/portal/filesystem
.. _`anaconda on Grid`: http://doc.grid.surfsara.nl/en/latest/Pages/Advanced/grid_software.html#softdrive-anaconda