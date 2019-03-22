.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _common-commands:

.. contents::
    :depth: 2

***************
Common commands
***************

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

.. srun        runs a job from the command line or from within a job script
.. example with
 sacct -u homer --format=JobID,JobName,MaxRSS,Elapsed
 sacct -j 810 --format=JobID,JobName,MaxRSS,Elapsed
 scontrol  show jobid -dd 810

.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`


.. Links:

.. _`Slurm documentation page`: https://slurm.schedmd.com/
