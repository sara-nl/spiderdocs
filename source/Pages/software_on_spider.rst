.. _software-on-spider:

******************
Software on Spider
******************

.. Tip:: There are several ways to setup and use your software on Spider. In this page you will learn:

     * what is our policy for system software installations
     * how to install your software on the local filesystem
     * using containerization for making your software portable across different platforms
     * distributing your software on different platforms
     * installing software using EasyBuild
     * using EESSI software repository


.. _system-software:

===============
System software
===============

There are cases in which a user or project may need extra software that is not included on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`. It may require the installation of a new software tool (i.e. emacs editor) or a specific version of a software component that is already on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` (i.e. gcc 9). As a user of this platform you are free to submit a request to :ref:`our helpdesk <helpdesk>` to ask us install software required for your project system-wide. The requests will be evaluated case-by-case, but in general the following policy applies:

    * Stand-alone applications easily available through the official RPM repositories (CentOS, EPEL, ...) are suitable to be installed system-wide. Some examples are emacs, joe, jq, ...

    * Alternative versions of core tools (i.e. Python 3.6, gcc 9, ...) will have to be evaluated case-by-case. We will accept requests of software that can be deployed using well defined and automated procedures.

The standard supported login shell on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` is bash. The standard supported software
setup is identical on all nodes. Basic Unix functionality is installed system-wide:

        * software compilers (e.g., gcc, g++, f95)
        * editors (e.g., vi, vim, emacs, nano and edit).
        * graphical tools are supported via X11 ssh forwarding on the login node.
        * operating system (OS on Spider is CentOS 8) on login and worker nodes.


.. _user-installed-sw:

=======================
User installed software
=======================

Software that does not require root privileges can be setup in user-space.
The software that is installed on the local CephFS will be made available
on all nodes for your jobs because the local directories are globally mounted.

.. _sw-on-home:

Software on home
================

Home can be used to install software that you don't want to share with other
members in your :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` project. This can be placed in the location ``/home/$USER``.

.. _sw-on-project-space:

Software on project space
=========================

For software that you want to install and share with other project members, you can
use the ``/project/[PROJECTNAME]/Software`` in your :ref:`project-spaces-directories`.

Only dedicated software managers have permissions to write in this directory, and all project members have read and execute permissions in this space.

The project members can use the software installed by the software manager, simply by
exporting the right path in ``$HOME/.bashrc``.

.. note::

   If you wish to install Conda environments or other software that handles many small files, we recommend
   that you do not install directly on your home or project spaces but use one of the other software installation methods below. This is because the home and project spaces
   are located on CephFS, a distributed file system, and loading many small files from there can be very slow.


.. _singularity-containers:

======================
Apptainer containers
======================

What is Apptainer
=================

Apptainer (formerly Singularity) is a container technology specifically designed for HPC/HTC systems. As such it properly controls the permissions of the container during build- and runtime, while allowing access to host components when needed. Apptainer allows putting whole software stacks into a single container file, which can then execute code that depend on this software. Examples include GPU software stacks such as Nvidia/CUDA and AMD/ROCm or entire programs such as MATLAB.

When to use Apptainer
=====================

Apptainer works best when you have a large software stack does not change. For example, if you use a static version of GPU drivers together with static python modules that stay at one version. This is because upgrading components is relatively hard and it is advised to completely rebuild the container when one updates a component, which can take up to 20 minutes. Hence, Apptainer is best suited for users that only need reliable software, for example, students using a static container that does not change during their project.

A single image file is created containing everything in the container, resulting in faster execution times and lower load on the system. Moreover, these "image"-files are portable to machines with the same architecture, so the built file can be moved to different systems running the same Linux flavour.

Large software packages with many files (such as Conda) will run relatively slow on distributed file systems, which is used on Spider. So if you have a **large software stack** that **does not change**, using **Apptainer** instead of running directly from the disks is preferred.

Caveats to apptainer
====================

The stability of the software stack is important, as build-times can go up to 20 minutes for a single container.
If you have multiple programs, they should live in their own containers and not be merged into a single container.
Apptainer requires some training, as you need to run, mount and bind paths with containers to get the full potential of the technology.


.. _upload-your-image:

Upload your image
==================

Your Apptainer image can be viewed as a single file containing all the necessary software for your purpose. When compared to traditionally compiled software it is similar to a binary file containing the executable software. The image can be placed anywhere on Spider, as long as the location is accessible to your processing jobs.

Example code
============

Here is a job script template for Apptainer usage. It assumes the container is already built and ready to be used.
The ``analysis.py`` script takes arguments ``filename.in`` and ``parameter`` and writes output into ``[filename]_[parameter].out``. The Slurm JobArray goes over values 24 to 40 in steps of 2: we do a parameter sweep over these values and feed the values to the script.

.. code-block:: bash

   #!/bin/bash
   #SBATCH -N 1            #request 1 node
   #SBATCH -c 1            #request 1 core and 8000 MB RAM
   #SBATCH -t 5:00         #request 5 minutes jobs slot
   #SBATCH --array=24-40:2 #go over parameters 24-40 in steps of 2

   # the array goes over 24-40 in steps of 2, save the value in PARAM for clarity
   PARAM=$((SLURM_ARRAY_TASK_ID))

   # copy the input data to scratch
   mkdir "$TMPDIR"/myanalysis
   cp -r $HOME/mydata "$TMPDIR"/myanalysis
   cd "$TMPDIR"/myanalysis

   # mount the analysis folder into the container at /mnt and run the analysis on a file using 'exec'
   apptainer exec --bind $TMPDIR/myanalysis:/mnt python analysis.py /mnt/file1.in $PARAM

   # copy the output back as TMPDIR is cleaned after the job
   cp $TMPDIR/file1_{24..40..2}.out $HOME/myoutput

   echo "SUCCESS"
   exit 0

This example uses many options simultaneously to show the power of combining containers, Slurm job arrays and scratch space for an analysis.

Please note that it is possible to bind several directories by providing a comma
separated list to the ``--bind`` option, e.g. ``--bind /cvmfs,/project``. Additional
information can be found in the `Sylabs documentation`_.


.. _lumi-containers:

=======================
LUMI Container Wrapper
=======================

What is the LUMI Container Wrapper?
===================================

The LUMI Container Wrapper (LCW) is a tool that wraps containers such that you can install conda and pip environments in a container and allows running the binaries in the container easily for the user. By writing the whole software stack into an external file and mounting this file into the container, you can update the software without rebuilding the base container. Allowing for faster load- and run-times on distributed file systems (such as on Spider), while maintaining the ability to update software stored in the external file.
For more information, see the `full LCW documentation <https://docs.lumi-supercomputer.eu/software/installing/container-wrapper/>`_.

When to use LCW
===============

When using conda- and/or pip-based virtual environments, consider using LCW instead of an installation on disk.

Caveats to LCW
==============

You can only run a single apptainer container simultaneously, so if you have LCW running in your terminal, you can not run a second container in the same terminal. Recursive containerization is also disallowed in apptainer.
When using very specific **large** containers, such as GPU containers (Nvidia, AMD, Intel), use the container directly instead of user LCW, as you have to build on top of the container contents.

Example code
============

Clone the code-base at `github <https://github.com/CSCfi/hpc-container-wrapper/>`_ and set up the Spider environment. You can do this by adding `spider.yaml <https://raw.githubusercontent.com/sara-nl/spiderdocs/master/source/scripts/spider.yaml>`_ to the ``hpc-container-wrapper/configs`` folder of the cloned repository.

Run the following commands:

.. code-block:: bash

    cd hpc-container-wrapper
    bash install.sh spider

The ``spider`` in the second command refers to the ``spider.yaml`` file in ``hpc-container-wrapper/configs``. Once the base installation is setup, you can create a wrapper with:

.. code-block:: bash

    mkdir /path/to/install_dir/
    conda-containerize new --prefix /path/to/install_dir/ conda.yaml

where ``conda.yaml`` contains your installation, for example:

.. code-block:: bash

    channels:
      - conda-forge
    dependencies:
      - python=3.8.8
      - scipy
      - nglview

Once the wrapper is created you need to add it to your path to run, and all relevant binaries (such as ``python``) will be called from the container wrapper: ``export PATH="/path/to/install_dir/bin:$PATH"``. You can put the export in your ``.bash_rc`` or set it by hand each time you want to use the container wrapper.

.. Tip:: There are more options that can be set in the ``spider.yaml`` file and while building / updating the wrapper. See the documentation and repository for more information:

    `LUMI Documentation <https://docs.lumi-supercomputer.eu/software/installing/container-wrapper/>`_

    `GitHub repository <https://github.com/CSCfi/hpc-container-wrapper/>`_



.. _softdrive:

=========
Softdrive
=========

What is Softdrive
=================

Softdrive is a software distribution service based on CVMFS, which has been developed at CERN, and is
being used extensively in production environments since several years.
CVMFS is a network file system based on HTTP. The CVMFS software repositories are publicly
available and can be mounted read-only on multiple compute clusters, including :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`.

Simply put, systems with the CVMFS installed have instant access to the Softdrive software repositories via the command line.
This is very handy when you work on multiple platforms to solve the problem of
installing and maintaining the software in different places. It is also very efficient when your software handles many
smalls files, e.g. conda environments.

Access on Softdrive is *not* provided by default to the :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` projects. To request for Softdrive access, please contact our
:ref:`our helpdesk <helpdesk>`.

Access
======

If you already have access on Softdrive, then you can use it directly from :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`, simply by exporting the ``/cvmfs/softdrive.nl/$USER``
software paths into your :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` scripts or your ``.bashrc`` file.

On :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` nodes, your Softdrive files will be available under::

    /cvmfs/softdrive.nl/[SOFTDRIVE_USERNAME]/

Please note that your [SOFTDRIVE_USERNAME] can be different than your [SPIDER_USERNAME].

Installation your software
==========================

1 Once access has been arranged, you can log in on the software distribution node, using your Softdrive username and password:

.. code-block:: bash

    ssh username@softdrive.ms4.surfsara.nl

2. Prepare your software somewhere in your Softdrive home directory. Compile your software tree in your home directory. When you want to run your workflows over multiple system types, it may be worthwhile and good practice to build your software independent of local libraries as much as possible. Try to build static binaries whenever you
can.

3. When satisfied, install your software under ``/cvmfs/softdrive.nl/$USER``

4. Then trigger publication by executing the following command:

 .. code-block:: bash

    publish-my-softdrive

After a couple of minutes your new software becomes available on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`.

.. note::

   Another possible method for the user Software installation is EasyBuild. EasyBuild is offered on multiple HPC systems. If you are familiar with EasyBuild or wish to try it on Spider, follow our instuctions :ref:`here <easyBuild>`.

.. note::

   If you wish to use software modules but don't want to go through the steps of installing the software using EasyBuild yourself, `EESSI website`_ software repository may be a solution for you. Follow our instuctions :ref:`here <eessi>` to find out how to use EESSI in Spider.

.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:

.. _`Slurm documentation page`: https://slurm.schedmd.com/
.. _`Sylabs documentation`:  https://www.sylabs.io/docs/
.. _`Softdrive SURFsara`: http://doc.grid.surfsara.nl/en/latest/Pages/Advanced/grid_software.html#softdrive
.. _`EESSI website`: https://www.eessi.io/docs/
