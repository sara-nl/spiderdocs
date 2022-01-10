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

* Upgrading cluster from CentOS 8.4 to CentoOS Stream. No expected impact on job processing.

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
