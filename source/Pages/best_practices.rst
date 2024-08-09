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

Our local file system on Spider is CephFS and is suitable as a staging area for your data before or after analysing it. CephFS hosts both your home and project directories on Spider. It is designed for efficient IO of large files, but when dealing with many small files the file system performance can be degraded. This is because CephFS relies on a parallel distributed system that involves many disks to store the data itself and metadata servers to store the files metadata. As a result, when you operate on many small files e.g. run code from python environments, the system response can become slow for you and other users on the platform. 

In order to improve the performance of scientific workflows on Spider's storage, we have prepared this best practices guide that includes several tips to install, store and analyse your data efficiently.


.. _software-practices:

Software installation practices
===============================

If your software loads a large number of small files upon execution in your jobs then you may see poor I/O performance even if the total software size is not that big. There are ways to mitigate potential bottlenecks, such as the use of CVMFS or containers technology.

Here is an overview of the features and suitability of some of the software installation options supported on Spider:

==============================================   =================================   =========================================   ===============================================   ============================
Feature                                          :ref:`CephFS <user-installed-sw>`   :ref:`Apptainer <singularity-containers>`   :ref:`Lumi Container Wrapper <lumi-containers>`   :ref:`Softdrive <softdrive>`
==============================================   =================================   =========================================   ===============================================   ============================
Software with many files (eg. Conda, pip env)    No                                  Yes                                         Yes                                               Yes  
Fast execution times & Low load on the system    No                                  Yes                                         Yes                                               Yes
Extensively used in production                   Yes                                 Yes                                         No                                                Yes  
Easy to setup                                    Yes                                 Moderate                                    Moderate                                          Yes                             
Portability                                      No                                  Moderate                                    Moderate                                          Yes   
Frequent software updates                        No                                  No                                          Yes                                               Moderate       
Software access can be restricted                Yes                                 Yes                                         Yes                                               No (repos are public)         
==============================================   =================================   =========================================   ===============================================   ============================



Which software installation practice should I use?
--------------------------------------------------

When your application contains python environments or you seek for a portable way to use your software by multiple (SURF) services we suggest you to install your software on Sofdrive. Softdrive relies on the CVMFS thechnology and uses a caching mechanism on the worker nodes that helps launching your software in shorter times. Here you can find instructions for using :ref:`Softdrive <softdrive>`.

An alternative is using Apptainer. Apptainer relies on the container technology that provides an isolated software environment for each application. Apptainer works best when you have a large software stack does not change often. The image can be placed anywhere on Spider, as long as the location is accessible to your processing jobs. Examples can be found in our :ref:`Apptainer <singularity-containers>` section.

For software that changes frequently we suggest you the LUMI Container Wrapper (LCW). This is similar to Apptainer but you can update the software without rebuilding the base container. More about LCW can be found in our :ref:`LUMI <lumi-containers>` section.

In cases that you have to install your software locally on Spider and it loads a limited number of files, it is possible to use CephFS on home or project space locations, but take into account its limitations such as slow execution times.


.. _data-storage-practices:

Data storage practices
======================

When you work with large volume of data or your application writes/reads a large number of files then you may encounter performance bottlenecks depending on where you have stored your data. 

Here is an overview of the features and suitability of some of the data storage options supported on Spider: 

==============================================   ==================================   ============================   ===========================    
Feature                                           :ref:`CephFS <user-installed-sw>`   :ref:`dCache <using-dcache>`   :ref:`Scratch <scratch-fs>`       
==============================================   ==================================   ============================   ===========================   
High throughput & low load on the system         No                                   Yes                            Yes             
Large volumes of data                            No                                   Yes                            Moderate              
Data available after jobs end                    Yes                                  Yes                            No              
Data available outside Spider                    No*                                  Yes                            No              
Granular access control                          Yes                                  Yes                            No              
Supports disk                                    Yes                                  Yes                            Yes             
Supports tape                                    No                                   Yes                            No              
Available through an API                         No                                   Yes                            No                   
==============================================   ==================================   ============================   ===========================   

* *unless explicitly placed in public folder*

Which data storage practice should I use?
-----------------------------------------

For bulk data storage we recommend dCache. dCache is highly connected to Spider worker nodes and is designed for high-throughput processing of data. This storage system is also available outside of Spider, and has highly granular access controls, making data releases, or data uploader roles self-service. dCache is available through a number of interfaces, meaning that it can be used out of the box with WebDAV clients or through a REST API, allowing for future data portals to be developed. Another reason to use dCache is that it supports both disk and tape, meaning that it can easily scale to much more data. Here you can find instructions for using the :ref:`dCache remote storage <using-dcache>`.

We also advice you to use the scratch file systems as fast temporary storage while running a job. Each of the Spider worker nodes has a large scratch area on local SSD. Any data that you wish to keep should be written to other storage backends such as dCache before the end of the job. The scratch areas are ideal for retrieving the input of a job from dCache during execution or for applications that generate lots of intermediate files that are consumed by other parts of the processing or for generating the job output before copying it back to dCache. More about how to use the temporary disk space can be found in our section :ref:`Using scratch <scratch-fs>`.

In cases that you have multiple jobs that need to access a single set of files that is too large to copy over to scratch, it is possible to use CephFS on home or project space locations for temporarily storing your data, but take into account its limitations compared to dCache in terms of throughput and capacity. It is highly recommended that you do not store more than *10,000* files in a single directory on CephFS. In terms of file sizes, CephFS is most efficient when you deal with files that are larger than *4MB*. Files that are less than *32KB* can be very inefficient.


.. _managing-data-practices:

Managing data practices
========================

There are several data management options for all stages of your project lifecycle. Here we focus on the data managing options for transferring and parsing your data on Spider. 

An overview of the features and suitability of some of the managing data options supported on Spider is presented below.

==============================================   ====================================   ====================================   ====================================   
Feature                                          :ref:`Rclone <transfer-data-rclone>`   :ref:`Shared memory <shared-memory>`   :ref:`mpifileutils <mpi-file-utils>`           
==============================================   ====================================   ====================================   ====================================   
High speed & low load on the system              Moderate                               Yes                                    Yes   
Support for parallel operations                  Yes                                    Yes                                    Yes               
Easy setup                                       Yes                                    Yes                                    No              
Supports many backends (Object Store, dCache)    Yes                                    No                                     No             
==============================================   ====================================   ====================================   ====================================  

Which practice for managing data should I use?
----------------------------------------------

When transferring data from/to Spider your experience will vary depending on the client, protocol and parameters you choose. For efficient data transfers we suggest you to use Rclone. Rclone is a command line tool that works on many platforms and it can talk to many storage systems, including dCache. Some advantages of Rclone are that it can sync directories, like rsync does, and it uses parallel transfers, 4 by default, to get a better performance when copying directories. More information about using Rclone, for example with dCache, can be found in our :ref:`ADA interface <transfer-data-rclone>` section.


When you need to tar or zip many small files on Spider, this can be very slow on the local CephFS filesystem and can take several hours. In such cases it may be better to copy the files temporarily in memory (RAM) first and then use tar/zip, as it will speed up these operations remarkably. The files are copied from CephFS into memory in a parallel way, while tar operates on files one by one. Once the files are in the shared memory of the node, the tar process is a lot faster. When using this option please keep in mind that memory is limited and shared with other processes and that it is temporary. An example for using the shared memory to tar and process a file can be found in :ref:`Shared memory <shared-memory>`.

For advanced users, who are familiar with MPI operations, we also offer an a MPI-based tool for managing datasets such as copying files across the different home and project space folders on the local file system. The MPI-based tool is much faster and efficient than the common `cp` operations. Example usage for parallel copying of files using this method can be found in the :ref:`mpifileutils <mpi-file-utils>` section.


.. _running-many-jobs:

Running a large amount of jobs 
==============================

High-throughput workflows that execute a specific application for many different parameter combinations, often requires the submission of many jobs. When running a large amount of jobs it can be difficult to keep track of the status of these jobs or resume failed jobs that were prematurely canceled (e.g. due to time limit). Another challenge is reducing the large scheduling overhead and waiting times in the queue. 


An overview of the features and suitability of some of the options for running a large amount of jobs on Spider is presented below.

==============================================   ================   ==============================   ======================================
Feature                                          Slurm job arrays   :ref:`PiCaS <picas-on-spider>`   :ref:`Snakemake <snakemake-on-spider>`
==============================================   ================   ==============================   ======================================  
High speed & low load on the system              No                 Yes                              Moderate
Scales to hundreds, thousands of jobs and more   No                 Yes                              Moderate
Transcends spider                                No                 Yes                              No
Easy setup                                       Yes                Moderate                         Moderate    
Handles easily dependencies between tasks        No                 Moderate                         Yes
Error recovery                                   No                 Yes                              Moderate
==============================================   ================   ==============================   ======================================


Which practice for running a large amount of jobs should I use?
---------------------------------------------------------------

The first option to check when running a large amount of jobs is whether the software you're using comes with a built-in option for managing your workloads on a Slurm-based cluster. Alternatively, an easy way to submit several independent jobs with one command is the use of `Slurm job arrays <https://slurm.schedmd.com/job_array.html>`_. Job arrays, however do not scale well for more than a few hundreds of jobs. In this case, you can use external tools for managing your workloads, such as PiCaS or Snakemake.


PiCaS works as a queue, providing a mechanism to step through the work one task at a time. It is also a `pilot job <https://doc.grid.surfsara.nl/en/latest/Pages/Practices/pilot_jobs.html>`_  system, indicating that the client communicates with the PiCaS server to fetch work, instead of having that work specified in a job (or similar) file.  As every application needs different parameters, PiCaS has a flexible data structure that allows users to save different types of data. PiCaS can handle thousands or millions of tasks, it has an easy query mechanism to search among your tasks and is accessible from any platform via a Restful HTTP API. Here you can find instructions for using :ref:`PiCaS <picas-on-spider>`.


When your application involves several steps connected in a workflow that each need to be submitted as independent tasks, you may consider using :ref:`Snakemake <snakemake-on-spider>`. Snakemake is a python-based workflow managment tool for defining, managing and executing workflows with multiple steps and complex dependencies. There are possibilities to combine PiCaS and Snakemake to enable workflow automation and run many jobs and subtasks efficiently and fast. Please contact our :ref:`our helpdesk <helpdesk>` if you need help with automating your workloads on Spider.


