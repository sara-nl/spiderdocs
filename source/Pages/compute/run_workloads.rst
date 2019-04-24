.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _run-workloads:

.. contents::
    :depth: 4

******************
Run your workloads
******************

.. _job-submit-output:

===================
Job submission & output retrieval
===================

Run a local Job
===============

The ``srun`` command runs a job on a cluster managed by Slurm. It comes with a
great deal of options for which help is available by typing ``srun --help`` on
the command line after logging in to the system. Alternatively, you can also get
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


Submit a Job script
====================

The ``sbatch`` command submits a job description script with 1 or more ``srun``
commands to the batch queue. Slurm manages this queue and schedules the
individual ``srun`` jobs for execution on the available worker nodes, taking
into account the global options specified with ``#SBATCH <options>`` in the job
description script as well as any local options specified for individual
``srun <options>`` jobs.

Below we provide an example for ``sbatch`` job submission with options. Here we
submit and execute the above mentioned ``hello_world.py`` script to the
queue via ``sbatch`` and provide options ``- N 1`` to request only 1 node,
``-c 1`` to request for 1 core and 8GB memory (coupled) and ``-t 1:00`` to
request a maximum run time of 1 minute. The job script, ``hello_world.sh``,
is an executable bash script with the following code;

.. code-block:: bash

   #!/bin/bash
   #SBATCH -N 1
   #SBATCH -c 1
   #SBATCH -t 1:00
   srun python /home/[username]/[path-to-script]/hello_world.py

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

.. _interactive-jobs:

============================
Interactive jobs & debugging
============================

We suggest you, where possible, to first debug your job template on the login
node. In doing so, please take into account that the login node is a shared
resource and hence any job testing should consume the least demanding set of
resources. For debugging with high resource demands it is possible to set up
interactive jobs on other (test) nodes for this specific purpose. If you have
high resource demands for testing your jobs, please contact
:ref:`our helpdesk <helpdesk>`.


.. ==================
 How to cancel jobs
 ==================


 .. ===================
  How to monitor jobs
  ===================

 .. * Job status
 .. * Job usage (cores, memory, scratch)

 .. =============
  Compute usage
  =============

 .. * Own CPU hours consumed (for any project member)
 .. * CPU hours consumed from all project members & budget left  (only for project admins)


========================
Using local ``/scratch``
========================

If you run jobs that require intensive I/O processes, we advise you to use
``/scratch`` because it is local SSD on every compute node of the the
Spider. This is a temporary storage that can be used only during the
execution of your job and will be arbitrarily removed at any point once your
job has finished running.

In order to access the ``/scratch`` filesystem within your jobs, you should
use the ``$TMPDIR`` variable in your job script. We advise you the following
job workflow:

* At the start of your job, copy the necessary input files to ``$TMPDIR``
* Run your analysis and produce your intermediate/output files on ``$TMPDIR``
* Copy the output files at the end of the job from ``$TMPDIR`` to your home directory

Here is a job script template for ``$TMPDIR`` usage;

.. code-block:: bash

   #!/bin/bash
   #SBATCH -N 1      #request 1 node
   #SBATCH -c 1      #request 1 core and 8GB RAM
   #SBATCH -t 5:00   #request 5 minutes jobs slot

   mkdir "$TMPDIR"/myanalysis
   cp -r $HOME/mydata "$TMPDIR"/myanalysis
   cd "$TMPDIR"/myanalysis

   # = Run you analysis here =

   #when done, copy the output to your /home storage
   tar cf output.tar output/
   cp "$TMPDIR"/myanalysis/output.tar $HOME/
   echo "SUCCESS"
   exit 0

==============================================================
Using local ``/scratch`` with input/output data from/to dCache
==============================================================

Below we show another example where local ``/scratch`` is used and the input/output data are stored on dCache. You need a valid :ref:`proxy <data-transfers>` to interact with dCache using the storage clients.

Here is a job script template for ``$TMPDIR`` usage;

.. code-block:: bash
   
   #!/bin/bash
   #SBATCH -N 1      #request 1 node
   #SBATCH -c 1      #request 1 core and 8GB RAM
   #SBATCH -t 5:00   #request 5 minutes jobs slot
   
   mkdir "$TMPDIR"/myanalysis
   cd "$TMPDIR"/myanalysis
   gfal-copy gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/path-to-your-data/your-data.tar file:///`pwd`/your-data.tar
   
   # = Run you analysis here =
   
   #when done, copy the output to dCache
   tar cf output.tar output/
   gfal-copy file:///`pwd`/output.tar gsiftp://gridftp.grid.sara.nl:2811/pnfs/grid.sara.nl/data/path-to-your-data/output.tar 
   echo "SUCCESS"
   exit 0

Please note that in the above example, it is assumed that the data is present on the disk storage on dCache. If the data is stored on Tape, it may need to be copied to disk first (called as staging). We refer to the Grid documentation on how to `stage`_ data. 


=================
Slurm constraints
=================

Regular constraints
===================

The Slurm scheduler will schedule your job on any compute node that can fulfil
the constraints that you provide with your ``sbatch`` command upon job
submission.

The minimum constraints that we ask you to provide with your job are given in
:ref:`prepare-workloads`.

Many other constraints can also be provided with your job submission. However,
by adding more constraints it may become more difficult to schedule and execute
your job. See the Slurm manual (https://slurm.schedmd.com) for more information
and please note that not all constraint options are implemented on Spider. In
case you are in doubt then please contact :ref:`our helpdesk <helpdesk>`.

Spider-specific constraints
===========================

In addition to the regular ``sbatch`` constraints, we also have introduced a
number of Spider-specific constraints that are tailored to the hardware of our
compute nodes for the Spider platform.

These specific constraints need to be specified via constraint labels to ``sbatch``
on job submission via the option ``--constraint=<constraint-label-1>,<constraint-label-2>,...,<constraint-label-n>``

Here a comma separated list implies that all constraints in the list must be
fulfilled before the job can be executed.

In terms of Spider-specific constraints, we support the following constraints
to select specific hardware:

1) cpu architecture constraint labels : 'ivy' , 'skylake'

2) local scratch constraint labels    ; 'hdd' , 'ssd'

As an example we provide below a bash shell script ``hello_world.sh`` that executes a compiled C script called 'hello'. In this script the #SBATCH line specifies that this script may only be executed on a node with 2 cpu-cores where the node must have a skylake cpu-architecture and ssd (solid state drive) local scratch disk space.

.. code-block:: bash

   #!/bin/bash
   #SBATCH -c 2 --constraint=skylake,ssd
   echo "start hello script"
   /home/[username]/[path-to-script]/hello
   echo "end hello script"

From the command line interface the above script may be submitted to Slurm via:
``sbatch hello_world.sh``

Please note that not all combinations will be supported. In case you submit a
combination that is not available you will receive the following error message:

   'sbatch: error: Batch job submission failed: Requested node configuration is not available'



.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:

.. _`Slurm documentation page`: https://slurm.schedmd.com/
.. _`stage`: http://doc.grid.surfsara.nl/en/latest/Pages/Advanced/grid_storage.html#staging-groups-of-files
