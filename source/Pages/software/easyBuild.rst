.. _easyBuild:

*************
EasyBuild
*************


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

After logging into Spider worker node, run the following commands:

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

Configure EasyBuild via the environment variable ``$EASYBUILD_PREFIX`` which changes all inportant configuration settings. To significantly speed up the builds, you can also change the build path to ``/tmp``. Note that the build directories are emptied and removed by EasyBuild when the installation is completed (by default).

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

.. note::  
	Please only run this command in a worker node. Note that for the first time installation may take longer than you expect, because toolchain dependencies such as GCCcore need to be installed. Once one software/package is installed, it can be used later in resolving the dependency of other software installations.

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

Use software modules
=========================

As a user of the project to make use of the software installed by EasyBuild, you need read access to ``/project/<project-name>/Software``.

First update $MODULEPATH so you can find the modules:

.. code-block:: bash

	module use /project/<project-name>/Software/easybuild/modules/all

IMPORTANT: keep in mind that you will have to run the ``module use`` command again if you start a new shell session in Spider. To avoid this, you can update one of the shell startup scripts in your home directory. For example you can edit the ``.bashrc`` file found in a users' home directory:

.. code-block:: bash

	cd /home/$USER
	nano /home/$USER/.bashrc

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
        python /home/$USER/draw_a_plot.py

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

.. _`EasyBuild website`: https://easybuild.io/
.. _`Demo on configuing EasyBuild`: https://docs.easybuild.io/configuration/
.. _`Supported softwares`: https://docs.easybuild.io/version-specific/supported-software/