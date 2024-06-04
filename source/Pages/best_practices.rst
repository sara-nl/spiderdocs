.. _best-practices:
*****************
Best practices
*****************

.. Tip:: This is a best practices section to help you achieve maximum performance for your jobs on Spider. In this page you will learn which options are most efficient for:

     * your software installation on Spider
     * storing your data on the platform
     * managing your data on Spider  
     * running a large amount of jobs on Spider


==========     
Background
==========

Spider is continuously expanding as a unique data processing and collaboration platform. The growing demand for storage space, the diversity in applications and the various ways the system is used, all bring some technical challenges. For example, if you're doing a lot of IO-operations (reading and writing files) in your workflows, you should be mindful on which systems these operations are performed as some options can significantly affect the performance of your jobs and the system load. 

Our local file system on Spider is CephFS and is suitable as a staging area for your data before or after analysing it. CephFS hosts both your home and project directories on Spider. It is designed for efficient IO of large files, but when dealing with many small files the file system performance can be degraded. This is because CephFS relies on a parallel distributed system that involves many disks to store the data itself and metadata servers to store the files metadata. As a result, when you operate on many small files or run code from python environments, the system response can become slow for you and other users on the platform. 

In order to improve the performance of scientific workflows on Spider's storage, we have prepared this best practices guide that includes several tips to install, store and analyse your data efficiently.


.. _software-practices:

Software installation practices
===============================

If your software loads a large number of small files upon execution in your jobs then you may see poor I/O performance even if the total software size is not that big. There are ways to mitigate potential bottlenecks, such as the use of CVMFS or containers technology.

Here is an overview of the features and suitability of some of the software installation options supported on Spider:

==============================================   ==============   ==============   =============   ======================
Feature                                          CephFS           Apptainer        Lumi            Softdrive
==============================================   ==============   ==============   =============   ======================
Software with many files (eg. Conda, pip env)    No               Yes              Yes             Yes  
Fast execution times & Low load on the system    No               Yes              Yes             Yes
Extensively used in production                   Yes              Yes              No              Yes  
Easy to setup                                    Yes              Somewhat         Somewhat        Yes                             
Portability                                      No               Somewhat         Somewhat        Yes   
Frequent software updates                        No               No               Yes             Somewhat       
Software access can be restricted                Yes              Yes              Yes             No (repos are public)         
==============================================   ==============   ==============   =============   ======================


Which software installation practice should I use?
--------------------------------------------------

When your application contains python environments or you seek for a portable way to use your software by multiple (SURF) services we suggest you to install your software on Sofdrive. Softdrive relies on the CVMFS thechnology and uses a caching mechanism on the worker nodes that helps launching your software in shorter times. Here you can find instructions for using :ref:`Softdrive <softdrive>`.

An alternative is using Apptainer. Apptainer relies on the container technology that provides an isolated software environment for each application. Apptainer works best when you have a large software stack does not change often. The image can be placed anywhere on Spider, as long as the location is accessible to your processing jobs. Examples can be found in our :ref:`Apptainer <singularity-containers>` section.

For software that changes frequently we suggest you the LUMI Container Wrapper. This is similar to Apptainer but you can update the software without rebuilding the base container. More about LCW can be found in our :ref:`Lumi <lumi-containers>` section.

In cases that you have to install your software locally on Spider and it loads a reasonable number of files, it is possible to use CephFS on home or project space locations, but take into account its limitations such as slow execution times.


.. _data-storage-practices:

Data storage practices
======================

When you work with large volume of data or your application writes/reads a large number of files then you may encounter performance bottlenecks depending on where you have stored your data. 

Here is an overview of the features and capabilities of some of the data storage options supported on Spider: 

==============================================   ==============   ==============   =============    
Feature                                          CephFS           dCache           Scratch         
==============================================   ==============   ==============   =============   
High throughput & Low load on the system         No               Yes              Yes             
Large volumes of data                            No               Yes              Somewhat              
Data available after jobs end                    Yes              Yes              No              
Data available outside Spider                    No*              Yes              No              
Granular access control                          Yes              Yes              No              
Supports disk                                    Yes              Yes              Yes             
Supports tape                                    No               Yes              No              
Available through an API                         No               Yes              No                   
==============================================   ==============   ==============   =============   

* *unless explicitly placed in public folder*

Which data storage practice should I use?
-----------------------------------------

For your bulk data storage we suggest you to use dCache. dCache is highly connected to Spider worker nodes and is designed for high-throughput processing of data. This storage system is also available outside of Spider, and has highly granular access controls, making data releases, or data uploader roles self service. dCache is also available through a number of interfaces, meaning that it can be used out of the box with webdav clients or through a REST API, allowing for future data portals to be developed. Another reason to use dCache is that it supports both disk and tape, meaning that it can easily scale to much more data. Here you can find instructions for using the :ref:`dCache remote storage <using-dcache>`.

We also advice you to use the scratch file systems as fast temporary storage that can be used while running a job. Each of the Spider worker nodes has a large scratch area on local SSD. Any data that you wish to keep should be written to other storage backends such as dCache. The scratch areas are ideal for retrieving the input of a job from dCache during execution or for applications that generate lots of intermediate files that are consumed by other parts of the processing or for generating the job output before copying it back to dCache. More about scratch can be found in our section :ref:`How to use the temporary disk space <scratch-fs>`.

In cases that you have multiple jobs that need to access a single set of files that is too large to copy over to scratch, it is possible to use CephFS on home or project space locations for temporary storing your data, but take into account its limitations such as slow throughput and short capacity compared to dCache.


.. _managing-data-practices:

Managing data practices
========================

There are several data management options for all stages of your project lifecycle. Here we focus on the data managing options for transferring and parsing your data on Spider. 

An overview of the features and capabilities of some of the managing data options supported on Spider is presented below.

==============================================   ==============   ==============   ==============   
Feature                                          Rclone           Shared memory    mpifileutils          
==============================================   ==============   ==============   ==============   
High speed & Low load on the system              Somewhat         Yes              Yes   
Support for parallel operations                  Yes              Yes              Yes               
Easy setup                                       Yes              Yes              No              
Supports many backends (object store, dCache)    Yes              No               No             
==============================================   ==============   ==============   ==============

Which practice for managing data should I use?
----------------------------------------------

When transferring data from/to Spider your experience will vary depending on the client, protocol and paremeters you chooce. Thus, for data transfers we suggest you to use Rclone. Rclone is a command line tool that works on many platforms and it can talk to many storage systems, including dCache. Some advantages of Rclone are that it can sync directories, like rsync does, and it uses parallel transfers, 4 by default, to get a better performance when copying directories. More information about using Rclone, for example with dCache, can be found in our :ref:`ADA <transfer-data-rclone>` section.


When you need to tar or zip many small files on Spider, this can be very slow on the local CephFS filesystem and can take several hours. In such cases it may be better to copy the files temporarily in memory as it will speed up these operations remarkably. When the files are copied from CephFS into memory in a parallel way, it will be much faster than tar which does it one by one. Once the files are in the page cache of the node, the tar process is a lot faster. When using this option please keep in mind that memory is limited and shared with other processes and that it is temporary. An example for using the shared memory to tar and process a file can be found in :ref:`Shared memory <shared-memory>`.

For advanced users, who are familiar with mpi operations, we also offer an a MPI-based tool for managing datasets such as copying files across the different home and project space folders on the local file system. The MPI-based tool is much faster and efficient than the common `cp` operations. Example usage for parallel copying of files using this method can be found in the :ref:`mpifileutils <mpi-file-utils>` section.


.. _running-many-jobs:

Running a large amount of jobs 
==============================

When running a large amount of jobs it can be difficult to keep track of the state of these jobs or resume failed tasks that were prematurely canceled due to time limit. Another challenge when designing high-throughput workflows that execute a specific application for many different parameter combinations, is reducing the large scheduling overhead and waiting times in the queue. 


An overview of the features and capabilities of some of the options for running a large amount of jobs on Spider is presented below.

==============================================   ==============   ==============   =============
Feature                                          Array jobs       Picas            Snakemake
==============================================   ==============   ==============   =============  
High speed & Low load on the system              No               Yes              Somewhat  
Scales to hundreds, thousands of jobs and more   No               Yes              Somewhat
Available outside Spider                         No               Yes              No
Easy setup                                       Yes              Somewhat         Somewhat    
Handles easily dependencies between tasks        No               Somewhat         Yes
Error recovery                                   No               Yes              No
==============================================   ==============   ==============   =============


Which practice for running a large amount of jobs should I use?
---------------------------------------------------------------

The first option to check when running a large amount of jobs is whether the software you're using comes with a built-in option for managing your workloads on a Slurm-based cluster. Alternatively, an easy way to submit several independent jobs with one command is the use of Array jobs. Array jobs, however do not scale well for more than a few hudrends of jobs. In this case, you can use external tools for managing your workloads, such as PiCaS or Snakemake.


PiCaS works as a queue, providing a mechanism to step through the work one task at a time. It is also a pilot job system, indicating that the client communicates with the PiCaS server to fetch work, instead of having that work specified in a job (or similar) file.  As every application needs different parameters, PiCaS has a flexible data structure that allows users to save different types of data. PiCaS can handle thousands or millions of tasks, it has an easy query mechanism to search among your tasks and is accessible from any platform via a Restful HTTP API. Here you can find instructions for using :ref:`PiCaS <picas-on-spider>`.


When your application involves several steps connected in a workflow that each need to be submitted as independent tasks, Snakemake is tool for defining, managing and executing workflows with multiple steps and complex dependencies. There are possibilities to combine PiCaS and Snakemake to enable workflow automation and run many jobs and subtasks efficiently and fast. Please contact our :ref:`our helpdesk <helpdesk>` if you need help with automating your workloads on Spider.



.. TODO's:
.. Number of files in a single directory: it is highly recommended that you do not exceed more than 100,000 (?) files in a single directory on Spider. Large numbers of files can be the source of slow performance for you and others storage volumes in the system. To count the number of files, please note that  `ls` can be slow, so we advice you to use an alternative command e.g. find.
.. SquashFS: If your application can be run as a Singularity container, another good option is to mount your datasets with SquashFS
.. Picas examples: add new content
