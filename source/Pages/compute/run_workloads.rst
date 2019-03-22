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

.. code-block:: console

   #!/usr/bin/env python
   print("Hello World")

This python script can be locally executed as;

.. code-block:: console

   $ srun python hello_world.py
   Hello World

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

.. code-block:: console

   ##!/bin/bash
   ##SBATCH -N 1
   ##SBATCH -c 1
   ##SBATCH -t 1:00
   srun python /home//hello_python_test/hello_world.py

You can submit this job script to the Slurm managed job queue as;

.. code-block:: console

   $ sbatch hello_world.sh
   Submitted batch job 808

The job is scheduled in the queue with ``jobid 808`` and the stdout output of
the job is saved in the ascii file ``slurm-808.out``.

.. code-block:: console

   $ more slurm-808.out
   Hello World

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

.. code-block:: console

   ##!/bin/bash
   ##SBATCH -N 1      #request 1 node
   ##SBATCH -c 1      #request 1 core and 8GB RAM
   ##SBATCH -t 5:00   #request 5 minutes jobs slot

   mkdir "$TMPDIR"/myanalysis
   cp -r $HOME/mydata "$TMPDIR"/myanalysis
   cd "$TMPDIR"/myanalysis

   # = Run you analysis here =

   ##when done, copy the output to your /home storage
   tar cf output.tar output/
   cp "$TMPDIR"/myanalysis/output.tar $HOME/
   echo "SUCCESS"
   exit 0




.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:

.. _`Slurm documentation page`: https://slurm.schedmd.com/
