.. _service-notices-list:

********************
Service notices list
********************

List of notable changes and incidents on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` with most recent first:

==========
2024
==========

* 2024-05-06 from 9.00 am till 10.30am: ui-01 has crashed and was not accessible until it was rebooted.
* 2024-04-16 from 6.05am till 12.55pm: transient behaviour for ssh access via ui-01 and ui-02
* 2024-03-28: User application causing a lot of Out of Memory events on the following nodes: wn-ca-08, wn-ca-13, wn-ca-15, wn-ca-21, wn-ca-23, wn-ha-01, wn-ha-04, wn-ha-05. The nodes were rebooted and jobs running on them failed.
* 2024-03-19 from 9:00am till 12:30pm: Maintenance on the underlying Cloud infrastructure. The compute nodes may experience small disruptions. 
* 2024-02-15 from 11:00am till 17:00pm: Issues on CephFS with many queued operations. The nodes wn-ca-14, wn-dc-12, wn-hb-04, wn-dc-16, wn-dc-18 had to be rebooted. Jobs affected by the reboots will show up as failed.
* 2024-02-08 to 2024-02-09: Interruption of service due to CephFS issues. Some running user jobs had to be cancelled or failed.

==========
2023
==========

* 2023-12-07: High load on CephFS triggered by user activity. Some operations are slower but jobs are not affected. 
* 2023-11-24 at 17:00 till 2023-11-27: Problematic hardware causing slow connection and multiple failures on half the cluster. The affected nodes were rebooted and the jobs running on the nodes may have failed. 
* 2023-11-07 from 16:00pm till 19:00pm : CephFS overload triggered by user activity causing connectivity issues to the local filesystem. The nodes were rebooted and the jobs running on the nodes may have failed.
* 2023-07-13 to 2023-07-14 at 13:15pm : Problematic hardware causing slow operations on CephFS (/home and /project folders). Some users experience connection issues.
* 2023-06-05: Reduced capacity for maintenance.
* 2023-04-28 to 2023-05-04: Spider system downtime to upgrade the storage system. The generic UIs and worker nodes will not be accessible during this time.
* 2023-01-20: GPUs have been added to the Spider service.

==========
2022
==========

* 2022-09-25: The cluster has been updated from CentOS 8.4 to CentoOS Stream. No expected impact on job processing.
* 2022-05-03 to 2022-05-04: System downtime to restore services affected by underlying system maintenance. 
* 2022-05-02: Upgrade of the underlying Cloud infrastructure to the next Openstack release. The upgrade of the services can impact the networking on Spider nodes.
* 2022-03-11: Nodes wn-hb-01 and wn-hb-03 nodes failed to reconnect to CephFS client after MDS server crash and were restarted. Jobs running on the nodes may have failed.
* 2022-02-23: Nodes wn-ca-07 and wn-ca-09 node down due to hypervisor crash. Jobs running on the nodes may have failed.
* 2022-02-11: Wn-ca-03 node down due to hypervisor crash. Jobs running on the node may have failed.
* 2022-01-26: Wn-ca-01 node down due to hypervisor crash. Jobs running on the node may have failed.

==========
2021
==========

* 2021-12-20: Updated the underlying CEPH cluster of our CephFS system. No expected impact on the service.
* 2021-11-17: Wn-ca-04 node down due to hypervisor crash. Jobs running on the node may have failed.
* 2021-08-26: Added redundancy login node to support live changes and updates. The ``/scratch`` space will no longer be available on the login node.
* 2021-02-23: Updated the OS of the computing nodes & supporting infrastructure to CentOS 8, see more :ref:`maintenance-instructions`.
* 2021-02-15 to 2021-02-23:  New Spider release. See :ref:`maintenance-instructions`.

==========
2020
==========

* 2020-09-25: Issues with the batch machine. Running jobs should not be effected, but new jobs could not be created.
