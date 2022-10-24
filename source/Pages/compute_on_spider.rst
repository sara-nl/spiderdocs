.. _compute-on-spider:
*****************
Compute on Spider
*****************

.. Tip:: This is a quickstart on the platform. In this page you will learn:

     * how to prepare and run your workloads
     * about job types, partitions and Slurm constraints


.. _prepare-workloads:

=======================
Prepare your workloads
=======================

.. The current Spider nodes each have 12 physical cores, 96 GB RAM and 0.95 TB scratch space. Each node has a 10 Gb/s connection.

.. Job resources can be specified and requested either on a local job level by
 applying options to srun (link to below) or for all jobs within a job script
 by applying options to sbatch (link to below).

When you submit jobs to the batch system, you create a job script where you
specify the resources that your programs need from the system to execute
successfully.

Before submitting your jobs, it is a good practice to run a few tests of your
programs locally (on the login node or other system) and observe:

i) the time that your programs take to execute
ii) the amount of cores that your software needs to execute these tasks
iii) the maximum memory used by the programs during execution

We suggest you, where possible, first debug your job template on the login
node. In doing so, please take into account that the login node is a shared
resource and hence any job testing should consume the least demanding set of
resources. If you have high resource demands please contact
:ref:`our helpdesk <helpdesk>` for support in testing your jobs.

Once you get a rough estimate of the resources above, you are set to go. Create
your job script to request from the scheduler the estimated resources.

In the current setup of Slurm on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`, we ask you to specify at least
the following attributes:

==================    ===================   =================
SBATCH directive      Functionality         Usage example
==================    ===================   =================
``-N <number>``       the number of nodes   ``#SBATCH -N 1`` (the job will run on a single node)
``-c <number>``       the number of cores   ``#SBATCH -c 2`` (the job will use 2 cores couple to 16000 MB memory)
``-t HH:MM:SS``       the wall-clock time   ``#SBATCH -t 1:00:00`` (the job will run max for 1 hour)
``-p <partition>``    partition selection   ``#SBATCH -p normal`` (the job will run max for 120 hours)
``-p <partition>``    partition selection   ``#SBATCH -p infinite`` (the job will run max for 720 hours)
``-p <partition>``    partition selection   ``#SBATCH -p short`` (the job will run max for 12 hours)
``-p <partition>``    partition selection   ``#SBATCH -p interactive`` (the job will run max for 12 hours)
``-p <partition>``    partition selection   ``#SBATCH -p gpu_v100`` (the job will run on V100 nodes with a max of 120 hours)
``-p <partition>``    partition selection   ``#SBATCH -p gpu_a100`` (the job will run on A100 nodes with a max of 120 hours)
==================    ===================   =================

The specifics of each partition can be found with ``scontrol show partitions``, the information per machine can be found with ``scontrol show node NAME``, where NAME is the name of the worker node and for a simple overview use ``sinfo``.


==================
Run your jobs
==================


Running a local Job with `srun`
===============================

The ``srun`` command creates an allocation and executes an application on a cluster managed by Slurm.
It comes with a great deal of options for which help is available by typing ``srun --help`` on
the login node. Alternatively, you can also get
help at the `Slurm documentation page`_.

The ``srun`` command when used on the command line is executed locally by Slurm,
an example of this is given below. A python script, ``hello_world.py``, has the
following content;

.. code-block:: bash

   #!/usr/bin/env python
   print("Hello World")

This python script can be locally executed as;

.. code-block:: bash

   srun python hello_world.py
   #Hello World

Typically ``srun`` should only be used with a job script that is submitted with
``sbatch`` to the Slurm managed job queue.

Running an interactive Job with `srun`
======================================

You can start an interactive session on a worker node. This helps when you want to debug your pipeline or compile some software directly on the node.
You will have direct access to your home and project space files from within your interactive session.

The interactive jobs will also be ‘scheduled’ along with batch jobs for resources so they may not always start immediately.

The example below shows how to start an interactive session on a normal partition worker node with maximum time of one hour, one core and one task per node;

.. code-block:: bash

  srun --partition=normal --time=00:60:00 -c 1 --ntasks-per-node=1 --pty bash -i -l

To stop your session and return to the login node, type ``exit``.

The example below shows how to start an interactive session on a single core of a specific worker node; 

.. code-block:: bash

  srun -c 1 --time=01:00:00 --nodelist=wn-db-02 --x11 --pty bash -i -l


Submitting a Job Script with `sbatch`
=====================================

The ``sbatch`` command submits ``batch script`` or ``job description script`` with 1 or more ``srun``
commands to the batch queue. This script is written in bash, and requires SBATCH header lines that define
all of your jobs global parameters. Slurm then manages this queue and schedules the
individual ``srun`` jobs for execution on the available worker nodes. Slurm takes
into account the global options specified with ``#SBATCH <options>`` in the job
description script as well as any local options specified for individual
``srun <options>`` jobs.

Below we provide an example for ``sbatch`` job submission with options. Here we
submit and execute the above mentioned ``hello_world.py`` script to the
queue via ``sbatch`` and provide options ``- N 1`` to request only 1 node,
``-c 1`` to request for 1 core and 8000 MB memory (coupled) and ``-t 1:00`` to
request a maximum run time of 1 minute. The job script, ``hello_world.sh``,
is an executable bash script with the following code;

.. code-block:: bash

   #!/bin/bash
   #SBATCH -N 1
   #SBATCH -c 1
   #SBATCH -t 1:00
   srun python /home/[USERNAME]/[path-to-script]/hello_world.py

You can submit this job script to the Slurm managed job queue as;

.. code-block:: bash

   sbatch hello_world.sh
   #Submitted batch job 808

The job is scheduled in the queue with ``jobid 808`` and the stdout output of
the job is saved in the ascii file ``slurm-808.out``.

.. code-block:: bash

   more slurm-808.out
   #Hello World

More information on ``sbatch`` can be found at the `Slurm documentation page`_.


Using local ``scratch``
========================

If you run jobs that require intensive IO processes, we advise you to use
``scratch`` because it is the local SSD on every compute node of the the
:abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`. This is a temporary storage that can be used only during the
execution of your job and will be arbitrarily removed at any point once your
job has finished running.

In order to access the ``scratch`` filesystem within your jobs, you should
use the ``$TMPDIR`` variable in your job script. We advise you the following
job workflow:

* At the start of your job, copy the necessary input files to ``$TMPDIR``
* Run your analysis and produce your intermediate/output files on ``$TMPDIR``
* Copy the output files at the end of the job from ``$TMPDIR`` to your home directory

``TMPDIR`` is ``/tmp`` which is a 'bind mount' from ``/scratch/slurm.<JOBID>`` so you will only see your own job files in ``/tmp`` and all files will be removed after the job finishes.

.. Tip:: TMPDIR variable can only be used within the SLURM jobs. It can not be used nor tested on the UI because there is no scratch space. 

Here is a job script template for ``$TMPDIR`` usage;

.. code-block:: bash

   #!/bin/bash
   #SBATCH -N 1      #request 1 node
   #SBATCH -c 1      #request 1 core and 8000 MB RAM
   #SBATCH -t 5:00   #request 5 minutes jobs slot

   mkdir "$TMPDIR"/myanalysis
   cp -r $HOME/mydata "$TMPDIR"/myanalysis
   cd "$TMPDIR"/myanalysis

   # = Run your analysis here =

   #when done, copy the output to your /home storage
   tar cf output.tar output/
   cp "$TMPDIR"/myanalysis/output.tar $HOME/
   echo "SUCCESS"
   exit 0


=========
Job types
=========

CPU jobs
========

* For regular jobs we advise to always only use 1 node per job script i.e., ``-N 1``. If you need multi-node job execution, consider better an HPC facility.
* On :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` we provide **8000 MB RAM per core**.

  * This means that your memory requirements can be specified via the number of cores *without* an extra directive for memory
  * For example, by specifying ``-c 4`` you request 4 cores and 32000 MB RAM
* On :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` we provide **80 GB scratch disk per core**.

  * This means that your scratch disk requirements can be specified via the number of cores *without* an extra directive for storage
  * For example, by specifying ``-c 2`` you request 2 cores and 160 GB scratch disk
  * When you target specifically our fat nodes with 12TB available scratch, the provided scratch disk per requested core is 200 GB

GPU jobs
========
* For more information on using GPUs on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`, see the :ref:`dedicated section <gpu-on-spider>`.
* For jobs that require GPU resources a specific partition is available (see :ref:`partitions <partitions>` for all the different partitions).
* Access to the GPU paritions needs to be requested and received.


.. _partitions:

================
Slurm partitions
================

We have configured four CPU and two GPU partitions on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` as shown in the :ref:`table above <prepare-workloads>`:

  * If no partition is specified, the jobs will be scheduled on the normal partition  which has a maximum walltime of 120 hours and can run on any worker nodes.
  * Infinite partition jobs have a maximum walltime of 720 hours. Please note that you should run on this partition at your own risk. Jobs running on this partition can be killed without warning for system maintenances and we will not be responsible for data loss or loss of compute hours.
  * Short partition is meant for testing jobs. It allows for 2 jobs per user with 8 cores max per job and 12 hours max walltime.
  * Interactive partition is meant for testing jobs and has 12 hours maximum walltime.
  * GPU V100 contains 1 Nvidia V100 (32GB) card per node.
  * GPU A100 contains 2 Nvidia A100 (40GB) cards per node.

=================
Slurm constraints
=================


Regular constraints
===================

The Slurm scheduler will schedule your job on any compute node that can fulfil
the constraints that you provide with your ``sbatch`` command upon job
submission.

The minimum constraints that we ask you to provide with your job are given in
the example above.

Many other constraints can also be provided with your job submission. However,
by adding more constraints it may become more difficult to schedule and execute
your job. See the Slurm manual (https://slurm.schedmd.com) for more information
and please note that not all constraint options are implemented on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`. In
case you are in doubt then please contact :ref:`our helpdesk <helpdesk>`.


Spider-specific constraints
===========================

In addition to the regular ``sbatch`` constraints, we also have introduced a
number of Spider-specific constraints that are tailored to the hardware of our
compute nodes for the :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` platform.

These specific constraints need to be specified via constraint labels to ``sbatch``
on job submission via the option ``--constraint=<constraint-label-1>,<constraint-label-2>,...,<constraint-label-n>``

Here a comma separated list implies that all constraints in the list must be
fulfilled before the job can be executed.

In terms of Spider-specific constraints, we support the following constraints
to select specific hardware:


==========================    ===================    =================
SBATCH directive              Functionality          Worker Node
==========================    ===================    =================
``--constraint=skylake``      cpu architecture       ``wn-db-[01-06]``
``--constraint=napels``       cpu architecture       ``wn-hb-[01-05]``
``--constraint=rome``         cpu architecture       ``wn-ca-[01-25], wn-ha-[01-05]``
``--constraint=ssd``          local scratch          ``all nodes``
``--constraint=amd``          cpu family             ``wn-ca-[01-25], wn-ha-[01-05], wn-hb-[01-05]``
``--constraint=intel``        cpu family             ``wn-db-[01-06], wn-gb-[01-04], wn-gp-[01-02]``
==========================    ===================    =================


As an example we provide below a bash shell script ``hello_world.sh`` that executes a compiled C script called 'hello'. In this script the #SBATCH line specifies that this script may only be executed on a node with 2 cpu-cores where the node must have a skylake cpu-architecture and ssd (solid state drive) local scratch disk space.

.. code-block:: bash

   #!/bin/bash
   #SBATCH -c 2 --constraint=skylake,ssd
   echo "start hello script"
   /home/[USERNAME]/[path-to-script]/hello
   echo "end hello script"

From the command line interface the above script may be submitted to Slurm via:

``sbatch hello_world.sh``

Please note that not all combinations will be supported. In case you submit a
combination that is not available you will receive the following error message:

   'sbatch: error: Batch job submission failed: Requested node configuration is not available'

======================
Querying compute usage
======================


Overview
===========================

``sacct`` and ``sreport`` are slurm tools that allows users to query their usage from the slurm database. The accounting tools ``sacct`` and ``sreport`` are both documented on the `Slurm documentation page`_.

These slurm queries result in a users total usage for a user. The sum of Raw CPU times / 3600 gives total core usage for the defined period. `-d Produces delimited results for easier exporting / reporting`

Examples
===========================

.. code-block:: bash

   # look into the details of your usage by job
   sacct \
      -X #sum\
      -S2020-07-01 -E2020-07-30 \
      --format=jobid,jobname,cputimeraw,user,alloccpus,state,partition,account,exitcode

.. code-block:: bash

   #view the spexone project usage and your user's usage
   sreport \
      -t second \
      -T cpu cluster \
      AccountUtilizationByUser \
      Start="2020-07-01" \
      End="2020-07-30"


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:

.. _`Slurm documentation page`: https://slurm.schedmd.com/
