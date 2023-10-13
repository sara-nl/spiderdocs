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


.. _system-software:

===============
System software
===============

There are cases in which a user or project may need extra software not included on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` system. It may require the installation of a new software tool (i.e. emacs editor) or an specific version of a software component that is already on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` (i.e. gcc 9). As a user of this platform you are free to submit a request to :ref:`our helpdesk <helpdesk>` to ask us install a software required for your project system wide. The requests will be evaluated case-by-case, but in general the following policy applies:

    * Stand-alone applications easily available through the official RPM repositories (CentOS, EPEL, ...) are suitable to be installed system wide. Some examples are emacs, joe, jq, ...

    * Alternative versions of core tools (i.e. Python 3.6, gcc 9, ...) will have to be evaluated case by case. We will accept requests of software that can be deployed using well defined and automated procedures.

The standard supported login shell on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` is bash. The standard supported software
setup is identical on all nodes. Basic unix functionality is installed system-wide:

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

For software that you want to install and share with other project members, we advice
you to use the ``/project/[PROJECTNAME]/Software`` in your :ref:`project-spaces-directories`.

Only dedicated software managers have permissions to write in this directory, and all members
in the project have read and execute permissions in this space.

The project members can use the software installed by the software manager, simply by
exporting the right path in ``$HOME/.bashrc``.

Take a look into our examples below for installing miniconda and samtools in the
project space software directory by building from source without root privileges:

.. toctree::
   :maxdepth: 1

   software/installing_miniconda_on_project_space
   software/installing_samtools_on_project_space


.. _singularity-containers:

======================
Singularity containers
======================

On :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` we support Singularity. Singularity is a container solution
for building software stacks in the form of images. Singularity enables these
images to be run in user space. We do not provide a space for building
Singularity images, but we do support the execution of these images by users
on Spider.

The currently supported version of Singularity on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` can be found
by typing ``singularity --version`` on the command line after
:ref:`login <ssh-login>` into the system. Additional information can be found
on `Singularity SURFsara`_ page and more generic info can be found at the
`Sylabs documentation`_.


.. _:upload-your-image:

Upload your image
==================

Your Singularity image can be viewed as a single file containing all the necessary software for your purpose. When compared to traditionally compiled software it is similar to a binary file containing the executable software. The image can be placed anywhere on Spider, as long as the location is accessible to your processing jobs. However, we strongly recommend that you place your Singularity images in one of the dedicated locations for user space software that are described on the `User installed software`_ page.


.. _submit-a-singularity-command:

Singularity in batch jobs
=========================

Regular commands and Singularity based commands are very similar. In many cases for your job submission
script you simply add ``singularity exec`` in front of the commands to be executed within your job.
However, please note that in some cases you may need to also use directory binding
via the ``--bind`` option (see :ref:`binding-directories`). Below we provide an
example comparing a regular command in a job with a Singularity command.

* Regular job on Spider:

.. code-block:: bash

        #!/bin/bash
        #SBATCH -n 1
        #SBATCH -t 10:00
        #SBATCH -c 1
        echo "Hello I am running a regular command using the python version installed on the host system"
        echo "I am running on " $HOSTNAME
        python /home/[USERNAME]/hello_world.py

* Singularity command on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` (in this example the image is placed in the home directory of the user):

.. code-block:: bash

        #!/bin/bash
        #SBATCH -n 1
        #SBATCH -t 10:00
        #SBATCH -c 1
        echo "Hello I am running a singularity command using the my own python version installed in my image"
        echo "I am running on " $HOSTNAME
        singularity exec --pwd $PWD /home/[USERNAME]/my-singularity-python-image.simg python /home/[USERNAME]/hello_world.py

Please note that that the ``--pwd $PWD`` is recommended for use. By default, Singularity makes 
the current working directory within the container the same as on the host system (Spider), and
this path is not always available. For resolving the current working directory, Singularity looks up the
physical absolute path (see ``man pwd`` for more info). However, some directories on Spider
may be symbolic links and the current working directory would then resolve differently
than expected. This would then result in your files not being where you expected them to
be (combined with some warning messages).

.. _binding-directories:

Binding directories
===================

By default Singularity does not `see` the entire directory structure on Spider. This is
because by default the file system overlap between the host system and the image is only
partial. Additional directories can be made available by the user in severals ways:

(i) Create the directories within the image, see e.g. `Singularity SURFsara`_ (note that this requires sudo rights and thus needs to be done outside of Spider)

(ii) Bind new directories at the time of execution via the ``--bind`` option. For binding directories it is only necessary to specify the top directory.

Below we provide an example for binding the ``cvmfs`` directory. This is necessary if
your Singularity image is distributed via :ref:`softdrive`.

* Singularity command on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` (in this example the image is placed in the Softdrive directory):

.. code-block:: bash

        #!/bin/bash
        #SBATCH -n 1
        #SBATCH -t 10:00
        #SBATCH -c 1
        echo "Hello I am running a singularity command using the software installed in my image on Softdrive"
        echo "I am running on " $HOSTNAME
        singularity exec --bind /cvmfs --pwd $PWD /cvmfs/softdrive.nl/[USERNAME]/my-singularity-image.simg python /home/[USERNAME]/hello_world.py

Please note that it is possible to bind several directories by providing a comma
separated list to the ``--bind`` option, e.g. ``--bind /cvmfs,/project``. Additional
information can be found in the `Sylabs documentation`_.


.. _softdrive:

=========
Softdrive
=========

With `Softdrive SURFsara`_ it is possible to install your software in a central place and
distribute it *automagically* across any compute cluster, including :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`. Simply put, systems with the CernVM-FS installed
have instant access to the `Softdrive SURFsara`_ software repositories via the command line.
This is very handy when you work on multiple platforms to solve the problem of
installing and maintaining the software in different places.

Access on Softdrive is *not* provided by default to the :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` projects. To request for Softdrive access, please contact our
:ref:`our helpdesk <helpdesk>`.

If you already have access on Softdrive, then you can use it directly from :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`, simply by exporting the ``/cvmfs/softdrive.nl/$USER``
software paths into your :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` scripts or your ``.bashrc`` file.

On :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` nodes, your Softdrive files will be available under::

    /cvmfs/softdrive.nl/[SOFTDRIVE_USERNAME]/

Please note that your [SOFTDRIVE_USERNAME] can be different than your [SPIDER_USERNAME].

.. _easybuild-software:

===============
Use EasyBuild installing software
===============

EasyBuild is a software build and installation framework that allows you to manage scientific software on high performance computing systems in an efficient way.
The official website of EasyBuild can be found in `EasyBuild website`_. Below we give instructions on how to make use of EasyBuild in Spider.


.. _list-of-supported-softwares:

List of supported softwares
=========================

A full list of supported software packages is available in `Supported softwares`_.


.. _installing-easybuild-project:

Installing EasyBuild for the project team
=========================

Install EasyBuild as a software manager. Note that you need to have write access to directory ``/project/<project-name>/Software`` to be able to follow the instructions below. Please change the ``<project-name>`` in the commands to your project name.

After logging into Spider-UI node, run the following commands:

.. code-block:: bash

	python3.9 -m pip install wheel
        python3.9 -m pip install --prefix /project/<project-name>/Software easybuild

Wheel is a necessary package for installation if it is not already installed. Because of the compatibility with Python, it is recommended to use newer version of Python, such as Python3.9. Next update the ``$PATH`` environment variable to make sure the eb command is available:

.. code-block:: bash

	export PATH=/project/<project-name>/Software/bin:$PATH

To confirm EasyBuild is successfully installed and check the version, run:

.. code-block:: bash

	which eb

You should see something like

.. code-block:: bash

	/project/<project-name>/Software/bin/eb

Next specify the name or the full path to the python command that should be used by the eb command via the ``$EB_PYTHON`` environment variable:

.. code-block:: bash

	export EB_PYTHON=python3.9

Later if you use EasyBuild installing a software, EasyBuild will generate a module which you can load. To update the module search path environment variable ``$MODULEPATH``, run command:

.. code-block:: bash

	module use /project/<project-name>/Software/easybuild/modules/all

If you may use EasyBuild to install Python packages, you also need to update the Python search path environment variable ``$PYTHONPATH`` to instruct Python where it can find the EasyBuild Python packages:

.. code-block:: bash

	export PYTHONPATH=/project/<project-name>/Software/lib/python3.9/site-packages:$PYTHONPATH

IMPORTANT: keep in mind that you will have to make these environment changes again if you start a new shell session in Spider. To avoid this, you can update one of the shell startup scripts in your home directory. For example you can edit the ``.bashrc`` file found in a users' home directory:

.. code-block:: bash

	cd /home/<user-name>
	nano /home/<user-name>/.bashrc

Next, add the environment changes to the ``.bashrc`` file and save. 

.. code-block:: bash

	export PATH=/project/<project-name>/Software/bin:$PATH
	export EB_PYTHON=python3.9
	export PYTHONPATH=/project/<project-name>/Software/lib/python3.9/site-packages:$PYTHONPATH
	module use /project/<project-name>/Software/easybuild/modules/all

Now you are good to explore the EasyBuild world!


.. _configure-easybuild:

Configure EasyBuild
=========================

After EasyBuild is installed, here we give instruction on how to configure EasyBuild in Spider. 

To get an overview of the current EasyBuild configuration, run command:

.. code-block:: bash

	eb --show-config

It then shows a couple of selected important configuration settings with default values: build path, install path, path to easyconfigs repository, the robot search path, source path. 

Configure EasyBuild via the environemt variable ``$EASYBUILD_PREFIX`` which changes all inportant configueration settings. To significantly speed up the builds, you can also change the build path to ``/tmp``. Note that the build directories are emptied and removed by EasyBuild when the installation is completed (by default).

.. code-block:: bash

	export EASYBUILD_PREFIX='/project/<project-name>/Software/easybuild'
	export EASYBUILD_BUILDPATH='/tmp'

For a full description of what you can configure in EasyBuild, please check `Demo on configuing EasyBuild`_.


.. _install-software:

Install software
=========================

Here the most important range of topics are covered if you are new to EasyBuild. ``eb`` is EasyBuild’s main command line tool, to interact with the EasyBuild framework and hereby the most common command line options are being documented.To instruct EasyBuild which software packages it should build/install and which build parameters it should use, one or more easyconfig files must be specified. 

Searching for available easyconfig files can be done using the ``--search`` (long output) and ``-S`` (short output) command line options:

.. code-block:: bash

	eb --search matplotlib

You will see all the easyconfig files available in the robot search path related to ``matplotlib``, and searching is done case-insensitive.

Next you can get an overview of planned installations by ``-D/--dry-run``:

.. code-block:: bash

	eb matplotlib-3.3.3-foss-2020b.eb -D

Note how the different status symbols denote distinct handling states by EasyBuild:

        * [ ] The build is not available, EasyBuild will deliver it
        * [x] The build is available, EasyBuild will skip building this module
        * [F] The build is available, however EasyBuild has been asked to force a rebuild via --force and will do so
        * [R] The build is available, and the application will be rebuilt as request via --rebuild

You can also obtain a list of missing installations only using ``--missing-modules/-M``:

.. code-block:: bash

	eb matplotlib-3.3.3-foss-2020b.eb -M

To install the software using the easyconfig files and its all software dependencies, use ``--robot/-r``:

.. code-block:: bash

	eb matplotlib-3.3.3-foss-2020b.eb --robot

The dependency resolution mechanism of EasyBuild will construct a full dependency graph for the software package(s) being installed. Each of the retained dependencies will then be built and installed, in the required order as indicated by the dependency graph.

If necessary, use ``--force/-f`` to force the reinstallation of a given easyconfig/module: 

.. code-block:: bash

	eb matplotlib-3.3.3-foss-2020b.eb --robot --force

Please note that for the first time installation may take longer than you expect, because toolchain dependencies such as GCCcore need to be installed. Once one sofware/package is installed, it can be used later in resolving the dependency of other software installations.

To check if the installation is successful and use the software, run commands:

.. code-block:: bash

	module avail
	module load matplotlib/3.3.3-foss-2020b

In case you are not familiar with using modules, here is a simple cheatsheet of most common module commands used in combination with Easybuild:

        * module avail - list the modules that are currently available to load
        * module load foss/2022a - load the module foss/2022a
        * module list - list currently loaded modules
        * module show foss/2022a - see contents of the module foss/2022a (shows the module functions instead of executing them)
        * module unload foss/2022a - unload the module foss/2022a
        * module purge - unload all currently loaded modules


.. _use-software-module:

Use software moduels
=========================

As a user of the project to make use of the software installed by EasyBuild, you need read access to ``/project/<project-name>/Software``.

First update $MODULEPATH so you can find the modules:

.. code-block:: bash

	module use /project/<project-name>/Software/easybuild/modules/all

IMPORTANT: keep in mind that you will have to run the ``module use`` command again if you start a new shell session in Spider. To avoid this, you can update one of the shell startup scripts in your home directory. For example you can edit the ``.bashrc`` file found in a users' home directory:

.. code-block:: bash

	cd /home/<user-name>
	nano /home/<user-name>/.bashrc

Next, add the command below to the ``.bashrc`` file and save. 

.. code-block:: bash

	module use /project/<project-name>/Software/easybuild/modules/all


Now you can view available software modules and load them:

.. code-block:: bash

	module avail
	module load matplotlib/3.3.3-foss-2020b

Below is how you can use the modules in a job script:

.. code-block:: bash

        #!/bin/bash
        #SBATCH -n 1
        #SBATCH -t 10:00
        #SBATCH -c 1
	module use /project/<project-name>/Software/easybuild/modules/all
	module load matplotlib/3.3.3-foss-2020b
	module load Python/3.8.6-GCCcore-10.2.0
        echo "I am using the matplotlib module installed by EasyBuild"
        echo "I am running on " $HOSTNAME
        python /home/[USERNAME]/draw_a_plot.py

The draw_a_plot.py can be, for example:

.. code-block:: bash

	import numpy as np
	import matplotlib.pyplot as plt
	x = np.arange(0, 5, 0.1)
	y = np.sin(x)
	plt.plot(x, y)
	plt.savefig("output.jpg")

To view the result jpg in your terminal, run

.. code-block:: bash

	display output.jpg



.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:

.. _`Slurm documentation page`: https://slurm.schedmd.com/
.. _`Singularity SURFsara`: https://userinfo.surfsara.nl/systems/shared/software/Singularity
.. _`Sylabs documentation`:  https://www.sylabs.io/docs/
.. _`Softdrive SURFsara`: http://doc.grid.surfsara.nl/en/latest/Pages/Advanced/grid_software.html#softdrive
.. _`EasyBuild website`: https://easybuild.io/
.. _`Demo on configuing EasyBuild`: https://docs.easybuild.io/configuration/
.. _`Supported softwares`: https://docs.easybuild.io/version-specific/supported-software/
