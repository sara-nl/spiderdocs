.. warning:: Please note that Spider is a fresh platform - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _getting-started:

***************
Getting started
***************

.. Tip:: This is a quickstart on the platform. In this page you will learn:

     * how to login Spider
     * browsing in the project space environment
     * creating, configuring and submitting a simple job


.. _setting-up-your-account:

=======================
Setting up your account
=======================

Access to the cluster is provided via SSH (Secure Shell) Public key
authentication only. For the highest security of your data and the platform, we
don't not allow username/password authentication.

To use this method you will need first to configure your SSH public key on a
portal provided by SURFsara. Then you can connect and authenticate to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`
with your SSH keys without supplying your username or password at each visit.

 .. Add a reference to pages that explain SSH key encryption

As a member of a :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` project you shall have received a SURFsara user account.
This account is required to access the SURFsara portal in the step below.

If you already have an ssh key-pair please proceed to the next section to upload it.
Else you have to generate a key-pair by using the following command:

.. code-block:: bash

   laptop$ ssh-keygen # This will create a key-pair in $HOME/.ssh directory

Finally you have to upload your key to our SURFsara portal. Note that this is
an *one time* task. Follow these steps:

* **Step1**: Login to the `SURFsara portal`_ with your SURFsara user account
* **Step2**: Click on the tab "Public ssh keys" on the left pane
* **Step3**: Add your public key by copying the contents of your file ``id_rsa.pub`` as shown below:

.. image:: /Images/cua-portal-addssh.png
   :align: center

From now on you can login to Spider with your SSH keys from your laptop (or other
computer where your SSH key was generated/transferred). See next, :ref:`how to login <login>`.



.. _ssh-login:

==========
Logging in
==========

The login node is your entry and access point to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`. From this node you can submit
jobs, transfer data and prototype your application. It has a software
environment very similar to the worker nodes where your submitted jobs will run.

In order to login to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` you must have already uploaded your SSH public key
on the SURFsara portal (see :ref:`setting-up-your-account`)

If you already completed this step once, you are ready to login!

* Login to Spider via a terminal with the following command:

.. code-block:: bash

   ssh [USERNAME]@[Spider HOSTNAME]

* For example, the user `homer` will login as:

.. code-block:: bash

      ssh homer@spider.surfsara.nl
      #[homer@htp-ui ~]$  # this is the first prompt upon login

Congrats! You've just logged in to Spider.

.. note:: In case that you have multiple keys in your ``.ssh/`` folder, you would need to specify the key that matches the .pub file you :ref:`uploaded on the SURFsara portal <upload-key>`, i.e. ``ssh -i ~/.ssh/surfsarakey homer@spider.surfsara.nl``


.. _getting-around:

==============
Getting around
==============

As a user on Spider you are a member of a project, and each project member gets
access to the following directories:

.. _home-directory:

Home directory
==============

* ``/home/$USER``: each project member in a project has her/his personal home space. Only the account owner can read and write data in this directory

.. _project-spaces-directories:

Project spaces directories
==========================

Project space is a POSIX storage place allocated to a certain project. It includes the following shares:

* ``/project/[PROJECTNAME]/Data``: any project-specific data. Any member of the project can read data in this directory, but only the data manager(s) can write data
* ``/project/[PROJECTNAME]/Software``: any project-specific software. Any member of the project can read/execute software in this directory, but only the software manager(s) can install software
* ``/project/[PROJECTNAME]/Share``: any data to be shared among the project members. Any member of the project can read and write data in this directory
* ``/project/[PROJECTNAME]/Public``: Any member of the project can write in this directory. Any data stored here will be read-only by all users on Spider and exposed publicly via http (not implemented yet).


.. _submitting-a-job:

================
Submitting a job
================

On :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` you will use Slurm to schedule, manage and execute your
jobs. Slurm (short for Simple Linux Utility for Resource Management) is
an open source, fault-tolerant, and highly scalable cluster management and job
scheduling system for Linux clusters. Further information can be found at the
`Slurm documentation page`_.  You can see the currently installed version of Slurm by typing
``sinfo --version`` on the command line.


* Example to submit a job, check status, get output or cancel it:

Coming soon ..



Specific HT-related Slurm information and job scheduling can be found in section
:ref:`compute-on-spider` and more generic info can be found at the
`Slurm documentation page`_.


===============
Common commands
===============

Slurm has many commands with many options, here you have a list with the most
common ones. For more information please checkout the
`Slurm documentation page`_.

============   ============
Command         What it does
============   ============
``sinfo``      displays the nodes information
``sbatch``     submits a job to the batch system
``scancel``    cancels a submitted job
``squeue``     displays the state of submitted jobs
``scontrol``   shows detailed job information (useful for debugging)
``sacct``      shows detailed accounting information for jobs
============   ============


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:

.. _`SURFsara portal`: https://portal.surfsara.nl/
.. _`Slurm documentation page`: https://slurm.schedmd.com/
