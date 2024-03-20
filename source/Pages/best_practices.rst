.. _best-practices:
*****************
Best practices
*****************

.. Tip:: This is a best practices section to improve the data I/O performance of your application on the Spider. In this page you will learn:

     * Which options are available for your software installation
     * Which options are available for your data processing

     

Apptainer
---------

What is Apptainer
=================

Apptainer (formerly Singularity) is a container technology specifically designed for HPC systems. As such it properly controls the permissions of the container during build- and runtime, while allowing access to host components when needed. Apptainer allows putting whole software stacks into a single container file, which can then execute code that depend on this software. Examples include GPU software stacks such as Nvidia/CUDA and AMD/ROCm or entire programs such as MATLAB.

When to use apptainer
=====================

Apptainer works best in this scenario if you have a large software stack does not change. For example using a static version of GPU drivers together with static python modules that stay at one version works best. This is because upgrading components is relatively hard and it is advised to completely rebuild the container when one updates a component. As the build can take up to 20 minutes, this may work for some, especially for students that only need reliable software: a static container that does not change during their project works best.

A single image file is created containing everything in the container, resulting in faster execution times and lower load on the system. Moreover, these "image"-files are portable to machines with the same architecture, so the built file can be moved to different systems running the same Linux flavour.

Large software packages with many files (such as conda) will run relatively slow on distributed file systems, which is used on Spider. So if you have a **large software stack** that **does not change**, using **apptainer** instead of running directly from the disks is preferred.

Caveats to apptainer
====================

The stability of the software stack is important, as build-times can go up to 20 minutes for a single container.  
If you have multiple programs, they should live in their own containers and not be merged into a single container.  
Apptainer requires some training, as you need to run, mount and bind paths with containers to get the full potential of the technology.  

Example code
============

To be added


LUMI Container Wrapper
----------------------

What is the LUMI Container Wrapper
=============================

The LUMI Container Wrapper (LCW) is a tool that wraps containers such that you can install conda and pip environments in a container and allows running the binaries in the container easily for the user. By writing the whole software stack into an external file and mounting this file into the container, you can update the software without rebuilding the base container. Allowing for faster load- and run-times on distributed file systems (such as Spider), while maintaining the ability to update software stored in the external file.
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

The spider in the second command refers to the ``spider.yaml`` file in ``hpc-container-wrapper/configs``. Once the base installation is setup, you can create a wrapper with:

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
