.. _best-practices:
*****************
Best practices
*****************

.. Tip:: This is a best practices section to help you as a Spider user achieve maximum performance for your jobs and the system. In this page you will learn:

     * Which options are most efficient for your software installation
     * Which options are most efficient for your data transfers and data processing
     * Which options are most efficient for running a large amount of jobs 


==========     
Background
==========

Spider is continuously expanding as a unique data processing and collaboration platform. The growing demand for storage space, the increasing diversity of data and type of system usage brings some technical challenges. For example, if you're doing a lot of IO-operations (reading and writing files) in your workflows, you should pay special attention to where these operations are performed as it can make the system response slow for you and other users on the platform.. 

our local file system on Spider,CephFS, can suffer from slow operations when not used efficienly. CephFS hosts both your home and project directories on Spider. It is suitable as a staging area for your data before or after analysing it. Our currect configuration is not optimised for handling small files because this system involves many disks to store the data itself and metadata servers to store the files metadata. As a result, when you operate on many small files or run code from python environments, the system response can be slow for you and other users on the platform. 

Below you will find other storage option and techniques

In order to improve the performance of scientific workflows on Spider's storage, we have prepared this best practices guide that includes several tips to  to install, store and analyse your data efficiently.




.. _software-practices:

Software installation practices
===============================

An overview of the features and capabilities of some of the software installation options supported on Spider is presented below.

============================================   =============   =============   =============   =============
                                               CephFS          Apptainer       Lumi            Softdrive
============================================   =============   =============   =============   =============
Software packages with many files              No              Yes             Yes             Yes  
Conda- and/or pip-based virtual environments   No              Yes             Yes             Yes
Easy to setup                                  Yes             Somewhat        Somewhat        Yes                             
Software update changes                        No(static sw)   No (static sw)  Yes             Somewhat       
Faster execution times                         No              Yes             Yes             Yes
Lower load on the system                       No              Yes             Yes             Yes
Portability                                    No              Somewhat        Somewhat        Yes   
Software access can be restricted              Yes             Yes             Yes             No (repos are public)         
Extensively used in production                 Yes             Yes             No              Yes  
============================================   ==============  ==============  ==============  ==============


============================================   =============   =============   =============   =============
                                               CephFS          Apptainer       Lumi            Softdrive
============================================   =============   =============   =============   =============
Software packages with many files              -               vvv             vvv             vvv   
Conda- and/or pip-based virtual environments   -               vvv             vvv             vvv 
Easy to setup                                  vvv             vv              vv              vvv                             
Software update changes                        v               -               vvv             vv
Fast execution times & Low load on the system  -               vv              vv              vvv
Portability                                    -               vv              vv              vvv   
Software access can be restricted              vvv             vvv             vvv             - (repos are public)         
Extensively used in production                 vv              vv              -               vvv  
============================================   ==============  ==============  ==============  ==============


.. add comparison table
:ref:`Apptainer <singularity-containers>` 

:ref:`Lumi <lumi-containers>`

:ref:`Softdrive <softdrive>` 



.. _data-practices:

Data transfers and processing
=============================

An overview of the features and capabilities of some of the data transfers and processing options supported on Spider is presented below.


.. add comparison table
:ref:`How to use the temporary disk space <scratch-fs>`

:ref:`dCache remote storage <using-dcache>`

.. Tip: Data transfers + mpifileutils 
:ref:`_mpifileutils <mpifileutils>`

.. Tip: tarring files + shared memory
:ref:`Shared memory <shared-memory>`


.. _running-many-jobs:

Running a large amount of jobs 
=====================
.. Picas


..Number of files in a single directory   
..It is highly recommended that you do not exceed more than 100,000 (?) files in a single directory on Spider. Large numbers of files can be the source of slow performance for you and others storage volumes in the system. To count the number of files, please note that  `ls` can be slow, so we advice you to use an alternative command e.g. find.

