.. _advanced-usage:
*****************
Advanced Spider commands
*****************

Job dependencies
================

In this example it is shown how to run a job that depends on another job to finish before it starts.
 
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

   squeue -u lodewijkn
              JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
            2560644    normal   bye.sh lodewijk PD       0:00      1 (Dependency)
            2560643    normal hello.sh lodewijk  R       0:11      1 wn-hb-04
 
The ``bye.sh`` script is pending (PD), waiting until ``hello.sh`` is finished, which is running (R). A bit later the jobs are finished:
 
.. code-block:: bash

   squeue -u lodewijkn
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

Recurring jobs
==============

If there is a recurring job you want run on a certain schedule, in principle there is ``cron`` available on Spider. However, cron is tied to a single machine, which in the case of Spider would be either a user-interface (ui) node, or a worker node (wn). If a cron job is setup on one of these machines and this machine is not available, your job will not run. 

For more robust recurring jobs, there is ``scrontab``, a SLURM integration of cron. ``scrontab`` has identical syntax to ``cron``. However, the job you submit is added to the SLURM database and run on the defined schedule when the resources are available. The job will only start once the resources are available, so your job may not always run at the exact same time (unlike ``cron``). Your job will be scheduled to run on a worker node, regardless of where it was submitted. 

Therefore we advice users to use ``scrontab`` instead of ``crontab`` when they want to set up cron jobs. The ``scrontab`` documentation can be found `here <https://slurm.schedmd.com/scrontab.html>`_.
