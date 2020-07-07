.. _software-on-spider:

******************
Software on Spider
******************

.. Tip:: There are several ways to setup and use your software on Spider. In this page you will learn:

     * which software is provided by default on the system
     * how to install your software on the local filesystem
     * using containerization for making your software portable across different platforms
     * distributing your software on different platforms


.. _system-software:

===============
System software
===============

The standard supported login shell on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` is bash. The standard supported software
setup is identical on all nodes. Basic unix functionality is installed system-wide:

        * software compilers (e.g., gcc, g++, f95)
        * editors (e.g., vi, vim, emacs, nano and edit).
        * graphical tools are supported via X11 ssh forwarding on the login node.
        * operating system (OS on Spider is CentOS 7.5.1804 (Core) on login and worker nodes.


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
images to be run in user space. We dot not provide a space for building
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

Please note that that the ``--pwd $PWD`` is recommended for use. This is because by default,
Singularity makes the current working directory within the container the same as on the
host system (Spider). For resolving the current working directory, Singularity looks up the
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



.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:

.. _`Slurm documentation page`: https://slurm.schedmd.com/
.. _`Singularity SURFsara`: https://userinfo.surfsara.nl/systems/shared/software/Singularity
.. _`Sylabs documentation`:  https://www.sylabs.io/docs/
.. _`Softdrive SURFsara`: http://doc.grid.surfsara.nl/en/latest/Pages/Advanced/grid_software.html#softdrive
