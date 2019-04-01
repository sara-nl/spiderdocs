.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _prepare-workloads:

.. contents::
    :depth: 2

**********************
Prepare your workloads
**********************

=======================
Job management overview
=======================

On Spider you will use Slurm to schedule, manage and execute your
jobs. Slurm (short for Simple Linux Utility for Resource Management) is
an open source, fault-tolerant, and highly scalable cluster management and job
scheduling system for Linux clusters. Further information can be found at the
`Slurm overview page`_.

======================
Estimate job resources
======================

.. The current Spider nodes each have 12 physical cores, 96 GB RAM and 0.95 TB scratch space. Each node has a 10 Gb/s connection.

.. Job resources can be specified and requested either on a local job level by
 applying options to srun (link to below) or for all jobs within a job script
 by applying options to sbatch (link to below).

When you submit jobs to the batch system, you create a job script where you
specify the resources that your programs need from the system to execute
successfully.

Before submitting your jobs, it is a good practice to run a few tests of your
programs locally (on the login node or other system) and observe:

i) the time that your programs take to execute and
ii) the amount of cores that your software needs to execute these tasks
iii) the maximum memory used by the programs during execution

Once you get a rough estimate of the resources above, you are set to go. Create
your job script to request from the scheduler the estimated resources.

In the current setup of Slurm on Spider, we ask you to specify at least
the following attributes:

==================    ===================   =================
SBATCH directive      Functionality         Usage example
==================    ===================   =================
``-N <number>``       the number of nodes   ``#SBATCH -N 1`` (the job will run on a single node)
``-c <number>``       the number of cores   ``#SBATCH -c 2`` (the job will use 2 cores couple to 16GB memory)
``-t HH:MM:SS``       the wall-clock time   ``#SBATCH -t=1:00:00`` (the job will run max for 1 hour)
``-p <partition>``    partition selection   ``#SBATCH -p normal`` (the job will run max for 120 hours)
``-p <partition>``    partition selection   ``#SBATCH -p infinite`` (the job will run max for 720 hours)
==================    ===================   =================

Some notes:

* For regular jobs we advise to always only use 1 node per job script i.e., ``-N 1``. If you need multi-node job execution, consider better an HPC facility.
* On Spider we provide **8 GB RAM per core**.

  * This means that your memory requirements can be specified via the number of cores *without* an extra directive for memory
  * For example, by specifying ``-c 4`` you request 4 cores and 32 GB RAM

* We have configured two partitions on Spider as shown in the table above:

  * If no partition is specified, the jobs will be scheduled on the normal partition  which has a maximum walltime of 120 hours and can run on any worker nodes.
  * Infinite queues can run only on two worker nodes with a maximum walltime of 720 hours. Please note that you should run on this partition at your own risk. Jobs running on this partition can be killed without warning for system maintenances and we will not be responsible for data loss or loss of compute hours.

.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:

.. _`Slurm overview page`: https://slurm.schedmd.com/overview.html
