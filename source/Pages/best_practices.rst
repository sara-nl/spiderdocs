.. _best-practices:
*****************
Best practices
*****************

.. Tip:: This is a best practices section to improve the data I/O performance of your application on the Spider. In this page you will learn:

     * Which options are available for your software installation
     * Which options are available for your data processing
     * Which options are available for scheduling many tasks 


============     
Introduction
============

While Spider is continuously expanding as a unique data processing and collaboration platform, some of the challenges we encounter are the growing demand for storage space and the increasing diversity of data. In order to accommodate the ever-growing storage needs and improve the performance of scientific workflows on Spider's storage, we have prepared this best practices guide that includes several tips to improve the user experience on the platform.

============
Background
============

The local file system of Spider is CephFS and is suitable as a staging area for your data before or after analysing it. Our currect configuration is not optimised for handling small files because this system involves many disks to store the data itself and metadata servers to store the files metadata. As a result, when you operate on many small files or run code from python environments, the system response can be slow for you and other users on the platform. Below you will find other storage option and techniques to install, store and analyse your data.


.. _software-practices:

Software installation practices
===============================

.. add comparison table
:ref:`Apptainer <singularity-containers>` 

:ref:`Lumi <lumi-containers>`

:ref:`Softdrive <softdrive>` 



.. _data-practices:

Data processing practices
=========================

.. add comparison table
:ref:`How to use the temporary disk space <scratch-fs>`

:ref:`dCache remote storage <using-dcache>`

.. Tip: Data transfers + mpifileutils 
:ref:`_mpifileutils <mpifileutils>`

.. Tip: tarring files + shared memory
:ref:`Shared memory <shared-memory>`


.. _scheduling-many-tasks:

.. Scheduling many tasks 
.. =====================
.. Picas


..Number of files in a single directory   
..It is highly recommended that you do not exceed more than 100,000 (?) files in a single directory on Spider. Large numbers of files can be the source of slow performance for you and others storage volumes in the system. To count the number of files, please note that  `ls` can be slow, so we advice you to use an alternative command e.g. find.

