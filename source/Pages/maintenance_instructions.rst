
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
 - SLURM scheduler software update to version 20.02.5
 - Refactoring our resource provisioning and software deployment practices
 - Optimising our external network interfaces
 - Increasing the cluster capacity with two new worker nodes
 - Adding a short queue for small testing jobs
 
Testing phase 
=============

**Dates: 03/02/2021 - 12/02/2021**

During this phase you can test your pipelines on two new worker nodes, fully configured with the upgrades outlined above and confirm whether or not your work 
will be impacted by the upgrade. This is optional but highly recommended to ensure that your jobs will be running as expected after the upgrade.

.. Note::
   Any jobs running on the upgraded nodes during the testing phase will be killed when the testing phase ends, on 12/02/2021 end of the day.

**How to test your pipelines**

You may submit your jobs on the new nodes by using any of the following directives. Any of the options below will make sure that your jobs run on an upgraded node:

========================    =============================================   =================
SBATCH directive            Functionality                                   Usage example
========================    =============================================   =================
``--partition=revamped``    access to the upgraded nodes                    ``sbatch --partition=revamped <job script>``
``--constraint=centos8``    access to cluster nodes running Centos 8        ``sbatch --constraint=centos8 <job script>``
``--constraint=rome``       access to cluster nodes of cpu familiy 'rome'   ``sbatch --constraint=rome <job script>``

**Useful commands**

``sinfo -a``: check all available partitions and the associated nodes
``scontrol show node "wn-ca-01"`` or ``scontrol show node "wn-ca-02"``: check the specifications of the upgraded nodes

**Feedback**

Please report any issues or other feedback from testing your pipelines on the upgraded nodes to our `Service Desk`_. 


Downtime phase 
==============

**Dates: 15/02/2021 - 19/02/2021**



.. _`Service Desk`: https://servicedesk.surfsara.nl/jira/plugins/servlet/desk/portal/1

