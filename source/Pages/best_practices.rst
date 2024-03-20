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

Apptainer (formerly Singularity) is a container technology specifically designed for HPC systems. As such it properly controls the permissions of the container during build- and runtime, while allowing access to host components when needed. It allows for putting whole software stacks into a single file, which can then execute files that depend on this software. Examples include GPU software stacks such as Nvidia/CUDA and AMD/rocm or entire programs such as MATLAB.

When to use apptainer
=====================

Apptainer works best if you have a large software stack does not change. For example using a static version of GPU drivers together with static python modules that will not be changed works best. This is because upgrading components is relatively hard and it is advised to completely rebuild the container when one updates a component. As the build can take up to 20 minutes, this may work for some researchers, but for students that only need reliable software a static container that does not change during their project works best.

A single file is created containing everything in the container, resulting in faster execution times and lower load on the system. Moreover, these "image"-files are portable to machines with the same architecture, so the built file can be moved to different systems running the same Linux flavour.

Large software packages with many files will run relatively slow on distributed file systems, which is used on Spider. So if you have a **large software stack** that **does not change**, using **apptainer** instead of running directly from the disks is preferred.

Caveats to apptainer
====================

As mentioned above, the stability of the software stack is important, as build-times can go up to 20 minutes for a single container.
Also if you have multiple programs, they should live in their own containers and not be merged into a single container. 
Apptainer also requires some training on usage, as you need to run, mount and bind paths with containers to get the full potential of the technology.

Example code
============

To be added


LUMI Container Wrapper
----------------------

What is the LUMI Container Wrapper
=============================

When to use LCW
===============

Caveats to LCW
==============

Example code
============

