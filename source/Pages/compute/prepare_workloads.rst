.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. contents::
    :depth: 2

.. _prepare-workloads:

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


.. _spider-cluster-resources

======================
Spider cluster resources
======================

.. sinfo
.. show node info

Spider users can check the availability of Spider resources by typing ``sinfo`` on the command line of the Spider login node. This shows the available partitions (job queues) and the worker nodes assigned to these partitions. Technical information about the individual worker nodes can obtained by typing ``scontrol show node``. Similarly the current state of the job queue is obtained by typing ``squeue``.  


.. _slurm-cpu-cores

======================
Compute resources per requested CPU core
======================
.. the '-c' option is -c, --cpus-per-task=<ncpus> (https://slurm.schedmd.com/sbatch.html) 

On Spider we provision compute resources, in terms of RAM memory and local scratch, per requested number of CPU cores to Slurm. For every Slurm job we provide **8 GB RAM and 80 GB scratch space per requested CPU core**. 

All jobs on Spider that require more than 1 cpu, 8 GB RAM and/or 80 GB of local scratch space must specify their requirements via the ``-c`` option. For example, by specifying ``-c 4`` you request 4 cores, 32 GB RAM and 320 GB of local scratch space.

Note that the ``--mem`` option is not supported on Spider and memory requirements must be specified via the coupling to CPU cores as explained above. The scratch space requested by specifying the ``-c`` option only refers to the scratch space locally on the worker node that is assigned to the job. For jobs that use the storage mounted via the shared filesystem, i.e. /project, /catalog and /home, the local scratch space is not directly relevant.


.. _slurm-partitions

======================
Slurm Partitions
======================

We have configured two partitions (queues) on Spider. These can be requested via the ``-p option``, as shown in the table above:

  * If no partition is specified, the jobs will be scheduled on the normal partition  which has a maximum walltime of 120 hours and can run on any worker nodes.
  * Infinite queues can run only on a subset of worker nodes (see ``info``) with a maximum walltime of 720 hours. Please note that jobs you run here are at your own risk. Jobs running on this partition can be killed without warning for system maintenance activities and we will not be responsible for data loss or loss of compute hours.


.. _multi-node-jobs

======================
Multi-node Jobs
======================

Spider is designed for high throughput computing of large data sets (many terabytes to petabytes) and for independent jobs. It is therefore expected that each Slurm job on Spider fits within the capacity of a single worker node. For such regular jobs we advise to always only use 1 node per job script i.e., ``-N 1``. 

If you need multi-node job execution, it may be worth to consider an HPC facility. If in doubt or if you require information about the HPC systems available at SURFsara then please contact ref:`our helpdesk <helpdesk>`.


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:

.. _`Slurm overview page`: https://slurm.schedmd.com/overview.html
