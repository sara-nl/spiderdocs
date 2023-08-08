.. _workflows:

*********
Workflows
*********

.. Tip:: This is a quickstart on the platform. In this page you will learn:

     * creating a job dependency with Slurm
     * using Picas pilot framework from Spider


.. _slurm-job-dependencies:

======================
Slurm job dependencies
======================

A job can be given the constraint that it only starts after another job has finished.
Lets say that you have two Slurm jobs, A and B. You want job B to start after job A
has successfully completed. Here are the steps:

* Submit job A and keep the returned job ID::

    sbatch <jobA.sh>

* Submit job B with a condition to start after job A, by providing its assigned job ID. This way job B only starts after Job A has successfully completed::

    sbatch --dependency=afterok:<jobID_A> jobB.sh

* We can also tell Slurm to run job B, even if job A fails::

    sbatch --dependency=afterany:<jobID_A> jobB.sh


* If you want job B to start after several other jobs have completed, use the delimiter ':' as::

    sbatch --dependency=afterok:<jobID_A:jobID_C:jobID_D> jobB.sh


Job dependency example
======================

Now we show an example of how to use the dependencies. In this example it is shown how to run a job that depends on another job to finish before it starts.
 
First make two files, ``hello.sh`` which contains
 
.. code-block:: bash

   #!/bin/bash
    
   date
   sleep 30
   date
   echo "hello world"
    
and ``bye.sh`` which contains
    
.. code-block:: bash

   #!/bin/bash
    
   date
   echo "bye!"
 
 
And make the scripts executable with ``chmod +x hello.sh`` and ``chmod +x bye.sh``. 

The ``sleep 30`` command stops the code for 30 seconds and then the ``date`` command shows you the time, so you can see that the second job waits for the dependent to finish before starting.
 
Now you can submit the jobs with: 

.. code-block:: bash
 
   jobid=$(sbatch --parsable hello.sh)
   sbatch --dependency=afterok:$jobid bye.sh

   Submitted batch job 2560644

The first command submits a job and returns only the JobID value with ``--parsable``, and saves this value to a variable called ``jobid``. The second command only starts after the job with jobid has finished in a success state with ``afterok``. For more information on the dependency flag, see `the SLURM man-pages <https://slurm.schedmd.com/sbatch.html>`_. 

Now you can see your jobs in the queue with:
 
.. code-block:: bash

   squeue -u homer
              JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
            2560644    normal   bye.sh    homer PD       0:00      1 (Dependency)
            2560643    normal hello.sh    homer  R       0:11      1 wn-hb-04
 
The ``bye.sh`` script is pending (PD), waiting until ``hello.sh`` is finished, which is running (R). A bit later the jobs are finished:
 
.. code-block:: bash

   squeue -u homer
            JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
 
And now we can see the output of the log files:
 
.. code-block:: bash

  cat slurm-2560643.out

  Wed Aug 17 11:27:25 CEST 2022
  Wed Aug 17 11:27:55 CEST 2022
  hello world
 

.. code-block:: bash

   cat slurm-2560644.out
   
   Wed Aug 17 11:27:56 CEST 2022
   bye!
 
And we see that the first job slept for 30 seconds and the second job waited until the first was finished!

.. seealso:: For more information on job dependencies, see also the ``-d, --dependency`` section in the man page of the sbatch command.


.. _picas-on-spider:

=====
PiCaS
=====

When you run many jobs on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` it can be difficult to keep track of the state of these jobs,
especially when you start running hundreds to thousands of jobs. Although Slurm
offers some functionality for tracking the status of the jobs, via the Slurm job ID,
in many cases a `Pilot job framework`_, such as `PiCaS`_, is necessary for this purpose.

Access on PiCaS is *not* provided by default to the :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` projects. To request for PiCaS access, please contact our
:ref:`our helpdesk <helpdesk>`.

If you already have access on PiCaS, then you can use it directly from :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`, i.e. you can establish a connection to your `CouchDB`_
database and use the python `PiCaS client`_ either from the login node or the worker nodes.

To connect with your PiCaS database you need to provide your credentials
(username, password, database name). It is possible to specify the password on the
command line, however for security reasons this should be avoided on shared systems
(like the login node) because it can allow other local users to read the password (e.g. with
the ``ps`` command). Also to avoid having to type these credentials
every time your client connects to your database or using them within your jobs,
we advice you to authenticate to PiCaS with the steps below.

* Create a PiCaS configuration directory in your home directory. Here we will call this directory ``picas_cfg``, but you are free to give it any other name.

.. code-block:: bash

        mkdir /home/[USERNAME]/picas_cfg
        chmod go-rwx /home/[USERNAME]/picas_cfg

* Check the settings of your directory with ``ls -la``. The output should be similar to:

.. code-block:: bash

        ls -la /home/homer/picas_cfg
        drwx------ 1 homer homer  3  May  7 08:33 picas_cfg


* Create a new file called ``picasconfig.py`` inside the ``picas_cfg`` directory:

.. code-block:: bash

        cd /home/[USERNAME]]/picas_cfg
        touch picasconfig.py

* Add the following lines to the ``picasconfig.py`` file:

.. code-block:: bash

        PICAS_HOST_URL="https://picas.surfsara.nl:6984"
        PICAS_DATABASE="[YOUR_DATABASE_NAME]"
        PICAS_USERNAME="[YOUR_USERNAME]"
        PICAS_PASSWORD="[YOUR_PASSWORD]"


* Storing cleartext passwords in any medium is dangerous, so we need to make sure it is not readable by others. Save the ``picasconfig.py`` file and for additional security set it to read-write (rw) access for you only:


.. code-block:: bash

        chmod go-rw /home/[USERNAME]/picas_cfg/picasconfig.py


* Check the permissions of your ``picasconfig.py`` file with ``ls -la``. The output should be similar to:


.. code-block:: bash

        ls -la /home/homer/picas_cfg/picasconfig.py
        -rw------- 1 homer homer  126 May  7 08:33 picasconfig.py

* Finally, add the ``picas_cfg`` directory to your PYTHONPATH environment variable so that python can locate it. We recommend that you set this variable in your /home/[USERNAME]]/.bashrc file by adding the following lines to it:

.. code-block:: bash

        PYTHONPATH=/home/[USERNAME]/picas_cfg:$PYTHONPATH
        export PYTHONPATH

You are now ready to start using your PiCaS credentials without having to type them each time you or your jobs need to connect to the PiCaS server.
Good practices to build worflows with PiCaS can be found in `PiCaS example`_.

.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`


.. _snakemake-on-spider:

=========
Snakemake
=========

Snakemake is a workflow management tool that uses `makefiles <https://en.wikipedia.org/wiki/Make_(software)>`_ to define analyses and provide reproducable and scalable results. The workflow can be developed locally and then moved to server, cluster, cloud or grid to scale up the data size and computational needs.

Snakemake has integrations with `Slurm <https://slurm.schedmd.com/>`_, `PBS <https://adaptivecomputing.com/cherry-services/torque-resource-manager/>`_ and `SGE <https://en.wikipedia.org/wiki/Oracle_Grid_Engine>`_ for deploying to compute clusters, see the documentation `here <https://snakemake.readthedocs.io/en/stable/executing/cluster.html>`_.

For a showcase that demonstrates the power of snakemake, we advise you to go through the tutorial found `here <https://snakemake.readthedocs.io/en/stable/tutorial/tutorial.html>`_.

You can find the full documentation located at the `read the docs page <https://snakemake.readthedocs.io/en/stable/index.html>`_.


.. _dask-on-spider:

====
Dask
====

Dask is not a workflow management tool, but it does help in automating some parts of your analysis when you want to *scale up*. 
Dask helps you split up work and scale to an arbitrary amount of machines. It helps you manage data that is too large for a single machine and run your code in parallel on multiple machines.

The basic idea is that you define your analysis steps first. Dask takes the data shapes and operations, and prepares a schema of steps that are to be performed by your cluster. When all is ready, you submit your calculation and dask deploys it on a cluster. After the calculation is done, the data and output are aggregated into files that can be handled for post-processing.

Dask has excellent tutorials, which can be found `here <https://tutorial.dask.org/>`_. The full documentation can be found `here <https://docs.dask.org/en/stable/>`_.

RS-DAT
======

RS-DAT or Remote Sensing Data Analysis Tools, created by the `NLeSC <https://www.esciencecenter.nl/>`_, integrates Dask, Jupyter and the dCache storage system of SURF into one contained framework, which is then run from your local machine while deploying to a cluster.

The package can be found `here <https://github.com/RS-DAT/JupyterDaskOnSLURM>`_ and the installation instruction can be found `here <https://github.com/RS-DAT/JupyterDaskOnSLURM/blob/main/user-guide.md>`_. Note that RS-DAT is designed around the `Spider data processing platform <https://spiderdocs.readthedocs.io>`_ and the `Snellius supercomputer <https://servicedesk.surf.nl/wiki/display/WIKI/Snellius>`_, but can be run on any Slurm cluster. The instructions for running on a generic cluster are available in the project documentation.

The examples are available `here <https://github.com/RS-DAT/JupyterDask-Examples>`_, but be aware that only the first of the three examples works without an access token to the data stored on dCache. The example, however, does give a good impression of the power or RS-DAT.


.. _cron-jobs:

=========
Cron jobs
=========

If you need to automate (part of) your workflow it is possible to set up cronjobs on Spider.
Please note that cronjobs on Spider can be used for testing purposes *only* and we do not offer
this functionality as part of our service. If you wish to use cron jobs for production workflows
please contact :ref:`our helpdesk <helpdesk>`.

There are some restrictions when setting up a cronjob on Spider. The Spider login ``spider.surfsara.nl``
is automatically directed to two different login nodes ``ui-01.spider.surfsara.nl`` or
``ui-02.spider.surfsara.nl`` and cronjobs will be linked to the UI where they where created.
If you would like to make changes in your cronjob you need to login directly to the login node (ui-01 or ui-02)
where it was created (tip: to check which node you are on, you can type the command ``hostname``). This
may also affect your workflows in case of maintenance on the login node you run your cronjobs. 

For a more sustainable option for automated jobs see :ref:`the next subsection <recurring-jobs>`.

.. _recurring-jobs:

Recurring jobs
==============

Cron is tied to a single machine, which in the case of Spider is a user-interface (ui) node or a worker node (wn). If a cron job is setup on one of these machines and this machine is not available, your job will not run. 

For more robust recurring jobs, there is ``scrontab``, a SLURM integration of cron. ``scrontab`` has identical syntax to ``cron``. However, the job you submit is added to the SLURM database and run on the defined schedule when the resources are available. The job will only start once the resources are available, so your job may not always run at the exact same time (unlike ``cron``). Your job will be scheduled to run on a worker node, regardless of where it was submitted. 

Therefore we advice users to use ``scrontab`` instead of ``crontab`` when they want to set up recurring jobs. The ``scrontab`` documentation can be found `here <https://slurm.schedmd.com/scrontab.html>`_.

.. WARNING::
   Jobs submitted with scrontab are treated as regular jobs in the SLURM queue and will keep running until they finished or killed. To avoid filling up the queue with test jobs that run long, please use short lived jobs like ``hello world`` when testing.


.. Links:

.. _`Pilot job framework`: http://doc.grid.surfsara.nl/en/latest/Pages/Practices/pilot_jobs.html
.. _`PiCaS`: http://doc.grid.surfsara.nl/en/latest/Pages/Practices/picas/picas_overview.html#picas-overview
.. _`CouchDB`: http://couchdb.apache.org/
.. _`PiCaS client`: http://doc.grid.surfsara.nl/en/latest/Pages/Practices/picas/picas_overview.html#picas-client
.. _`PiCaS example`: http://doc.grid.surfsara.nl/en/latest/Pages/Practices/picas/picas_example.html#picas-example
