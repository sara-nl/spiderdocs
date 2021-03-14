.. _getting-started:

***************
Getting started
***************

.. Tip:: This is a quickstart on the platform. In this page you will learn:

     * How to login Spider
     * Browsing your project space
     * Submitting simple jobs


.. _setting-up-your-account:

=======================
Setting up your account
=======================

Access to the cluster is provided via SSH (Secure Shell) Public key
authentication only. For the highest security of your data and the platform, we
do not allow username/password authentication.

To use this method you will need first to configure your SSH public key on a
portal provided by SURFsara. Then you can connect and authenticate to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`
with your SSH keys without supplying your username or password at each visit.

Please follow these steps to access :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`:

* **Step 1**: Login to the `SURFsara portal`_ with your SURFsara user account

As a member of a :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` project you shall have received a SURFsara user account.
Please use the username and password sent to you and login to the `SURFsara portal`_ .

* **Step 2**: Accept the Usage Agreement in the portal

Once you login to the portal please agree to our usage terms and conditions to be able to
gain access to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`. You can perform this action on the
"Usage Agreement" tab as shown in the image below. Please note that you will be denied
access to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` if you do not accept this agreement.

.. image:: /Images/usage_agreement.png
   :align: center

* **Step 3**: Upload your SSH public key to the portal

In order to access :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` you need to have a file on your local computer
(say, your laptop) with a private SSH key, and you need to upload its matching
public SSH key on the `SURFsara portal`_. Then, when you are going to connect to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`
from your laptop, the SSH private and public keys will be compared and, if they successfully relate to one-another,
your connection will be established. Note that uploading your key to the portal is an *one time* task.

If you already have an SSH key-pair you can proceed to upload it.
Else you have to generate a key-pair in your laptop or other machine that you use to
connect to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`. If you need help to generate an SSH key-pair, see:

.. toctree::
   :maxdepth: 1

   ssh_keys

Once you have generated your SSH key-pair, upload your public key to our `SURFsara portal`_.
Click on the tab "Public ssh keys" on the left pane of
the portal and add your public key by copying the contents of your public key file
(e.g. ``cat ~/.ssh/id_rsa.pub``) as shown below:

.. image:: /Images/add_ssh_key.png
   :align: center

Field [1] SSH key: here you paste your public key

Field [2] Password: here you enter your password for your account

Field [3] Add sshkey: press the key for the changes to take effect

From now on you can login to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` with your SSH keys from your laptop (or other
computer where your SSH key was generated/transferred).
See next, :ref:`how to login <ssh-login>`.


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

* Login to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` via a terminal with the following command:

.. code-block:: bash

   ssh [USERNAME]@[Spider UI HOSTNAME]

* For example, the user `homer` will login as:

.. code-block:: bash

      ssh homer@spider.surfsara.nl
      #[homer@htp-ui ~]$  # this is the first prompt upon login

Congrats! You've just logged in to Spider.

.. note::

   In case that you have multiple keys in your ``.ssh/`` folder, you would need to specify the key that matches the .pub file you uploaded on the SURFsara portal, i.e. ``ssh -i ~/.ssh/surfsarakey homer@spider.surfsara.nl``

.. note::

   The first time you login to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`, you need to accept Spider's SSH key fingerprint. Public key fingerprints can be used to validate a connection to a remote server. Spider's public key fingerprint is:
   ``SHA256:HO8Cz3Fns+DoiK+VFlILbTGYkAOy5i/izzFYc005z+s (ECDSA)``


.. _getting-around:

==============
Getting around
==============

As a user on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` you are a member of a project, and each project member gets
access to the following directories:

.. _home-directory:

Home directory
==============

* ``/home/$USER``: each project member in a project has her/his personal home space. Only the account owner can read and write data in this directory

.. _project-spaces-directories:

Project spaces directories
==========================

Project space is a POSIX storage place allocated to each :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` project. It includes the following shares:

* ``/project/[PROJECTNAME]/Data``: any project-specific data. Any member of the project can read data in this directory, but only the data manager(s) can write data
* ``/project/[PROJECTNAME]/Software``: any project-specific software. Any member of the project can read/execute software in this directory, but only the software manager(s) can install software
* ``/project/[PROJECTNAME]/Share``: any data to be shared among the project members. Any member of the project can read and write data in this directory
* ``/project/[PROJECTNAME]/Public``: Any member of the project can write in this directory. Any data stored here will be read-only by all users on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` and exposed publicly via http (see :ref:`how <web-public-view>`)

The summary table below gives a quick overview of your project space permissions ('r'-read/'w'-write/'x'-execute):

============================   ===============================   ===================================   ================================   ==================================
Directories vs. Access Roles   ``/project/[PROJECTNAME]/Data``   ``/project/[PROJECTNAME]/Software``   ``/project/[PROJECTNAME]/Share``   ``/project/[PROJECTNAME]/Public``
============================   ===============================   ===================================   ================================   ==================================
Project Data manager(s)        rwx                               r-x                                   rwx                                rwx
Project Software manager(s)    r-x                               rwx                                   rwx                                rwx
Project normal user(s)         r-x                               r-x                                   rwx                                rwx
Other Spider project user      ---                               ---                                   ---                                r--
Outside Spider user            ---                               ---                                   ---                                r-- (via the :ref:`web views <web-public-view>`)
============================   ===============================   ===================================   ================================   ==================================


.. _submitting-a-job:

================
Submitting a job
================

On :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` you will use Slurm to schedule, manage and execute your
jobs. Slurm (short for Simple Linux Utility for Resource Management) is
an open source, fault-tolerant, highly scalable, cluster management and job
scheduling system for Linux clusters. Further information can be found at the
`Slurm documentation page`_.  You can see the currently installed version of Slurm by typing
``sinfo --version`` on the command line.

Let's run our first job on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`. Download the sample job script to your ``home`` account
on the :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` login and inspect the file before submitting it to the cluster:

.. code-block:: bash

   wget https://raw.githubusercontent.com/sara-nl/spiderdocs/master/source/scripts/welcome-to-spider.sh
   chmod u+x welcome-to-spider.sh

* Submit your job to the cluster:

.. code-block:: bash

   sbatch welcome-to-spider.sh
   #Submitted batch job [JOBID]

* Check the status of your submitted and not completed job(s):

.. code-block:: bash

   squeue --job [JOBID] # status of [JOBID]
   squeue -u $USER # status of all my jobs
   scontrol show jobid [JobID] # detailed info of [JOBID]

* Check your job output:

.. code-block:: bash

   cat slurm-[JOBID].out

* Once your job has completed, you can get job statistics and accounting:

.. code-block:: bash

   sacct -j [JOBID] --format=JobID,JobName,AveCPU,MaxRSS,Elapsed


More examples of how to use :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` Slurm can be found in section
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
``squeue``     displays the state of all submitted jobs
``scancel``    cancels a submitted job
``scontrol``   shows detailed job information (useful for debugging)
``sacct``      shows detailed accounting information for jobs
============   ============


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:

.. _`SURFsara portal`: https://portal.surfsara.nl/
.. _`Slurm documentation page`: https://slurm.schedmd.com/
