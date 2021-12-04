    
.. _maintenance-instructions:

***************************
Maintenance instructions
***************************

.. _new-spider-release-feb-2021:

===========================
New Spider release Feb 2021
===========================

Highlights in this release:

 - OS update of the cluster to CentOS 8
 - SLURM scheduler software update to version 20.11.3
 - Refactoring our resource provisioning and software deployment practices
 - Optimising our external network interfaces
 - Increasing the cluster capacity with two new worker nodes
 - Adding a short queue for small testing jobs
 
Testing phase 
=============

**Dates: 03/02/2021 - 12/02/2021**

During the testing phase you can test your pipelines on two new worker nodes, fully configured with the upgrades outlined above and confirm whether or not your work 
will be impacted by the upgrade. This is optional but highly recommended to ensure that your jobs will be running as expected after the upgrade of the production cluster.

.. Note::
   Any jobs running on the upgraded nodes during the testing phase will be killed when the testing phase ends, on 12/02/2021 end of the day.
   
   
.. Note::
   Any jobs running on the production nodes (i.e. excluding the upgraded nodes) during the testing phase will not be affected.

**How to test your pipelines**

You may submit your jobs on the new nodes by using any of the following directives. Any of the options below will make sure that your jobs run on an upgraded node:

========================    =============================================   =================
SBATCH directive            Functionality                                   Usage example
========================    =============================================   =================
``--partition=revamped``    access to the upgraded nodes                    ``sbatch --partition=revamped <job script>``
``--constraint=centos8``    access to cluster nodes running Centos 8        ``sbatch --constraint=centos8 --partition=revamped <job script>``
``--constraint=rome``       access to cluster nodes of cpu familiy 'rome'   ``sbatch --constraint=rome --partition=revamped <job script>``
========================    =============================================   =================

**Useful commands**

``sinfo -a``: check all available partitions and the associated nodes

``scontrol show node "wn-ca-01"`` or ``scontrol show node "wn-ca-02"``: check the specifications of the upgraded nodes

**Known issues**

- CentOS 8 does not provide to users a python interpreter, only python3. If you still use python2 in your code, you may want to consider decommissioning your old environment in favor of python3 or use conda or Singularity containers to create an execution environment tailored to your preferred python version.
- The grid software stack including proxy authentication is not available on the upgraded nodes. We are working on a solution. -> SOLVED
- The ``TMPDIR`` variable is not available on the upgraded nodes. We are working on a solution. -> SOLVED

**Feedback**

Please report any issues or other feedback from testing your pipelines on the upgraded nodes to our `Service Desk`_. 


Downtime phase 
==============

**Dates: 15/02/2021 - 19/02/2021**

During the downtime phase the login node will not be reachable and new jobs won't be accepted. Your data on dCache will still be accessible from any other computer/platform outside Spider.


.. Note::
   On 12/02/2021 end of the day, the cluster will stop accepting new jobs. Any running jobs on the production worker nodes will not be affected. Any jobs running on the upgraded nodes or the ``infinite`` partition will be killed.
   

**Getting in touch**

Please contact our `Service Desk`_ in case of any questions regarding the downtime. 


.. _`Service Desk`: https://servicedesk.surfsara.nl/jira/plugins/servlet/desk/portal/1

