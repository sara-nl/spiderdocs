.. _change_log_list:

****************
Change log list
****************

List of notable changes with most recent first:

==========
Ongoing
==========

Update
==========

==========
2022-03-11
==========

Interruption
============
* Nodes wn-hb-01 and wn-hb-03 nodes failed to reconnect to CephFS client after MDS server crash. Nodes restarted 2022-03-15

==========
2022-02-23
==========

Interruption
============
* Nodes wn-ca-07 and wn-ca-09 node down due to hypervisor crash. Jobs running on the node may have failed.

==========
2022-02-11
==========

Interruption
============

* Wn-ca-03 node down due to hypervisor crash. Jobs running on the node may have failed.

==========
2022-01-26
==========

Interruption
============

* Wn-ca-01 node down due to hypervisor crash. Jobs running on the node may have failed.

==========
2021-12-20
==========

Update
======

* Updated the underlying CEPH cluster of our CephFS system. No expected impact on the service.

==========
2021-11-17
==========

Interruption
============

* Wn-ca-04 node down due to hypervisor crash. Jobs running on the node may have failed.

==========
2021-08-26
==========

Addition
========

* Added redundancy login node to support live changes and updates. The ``/scratch`` space will no longer be available on the login node.

==========
2021-02-23
==========

Update
======

* Updated the OS of the computing nodes & supporting infrastructure to CentOS 8, see more :ref:`maintenance-instructions`.

==========
2020-09-25
==========

Interruption
============

* Issues with the batch machine. Running jobs should not be effected, but new jobs cannot be created.
