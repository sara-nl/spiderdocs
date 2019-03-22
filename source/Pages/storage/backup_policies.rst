.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _backup-policies:

.. contents::
    :depth: 2


***************
Backup policies
***************

Your project data (including your ``HOME`` directory) is stored on a
POSIX-compliant filesystem, called ``CephFS`` (short for Ceph Filesystem).
``CephFS`` is a network file system based on a highly scalable ``Ceph`` storage
cluster. It allows both to add a lot of storage to the system when needed,
while sustaining a lot of concurrent access to many users at the same time.

The data stored on CephFS is disk only, replicated three times for redundancy.
For disk-only data there is **no backup**. If you cannot afford to lose this
data, we advise you to copy it elsewhere as well.

.. Add information about the Data Archive.

.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:

.. _`Data Archive`: https://userinfo.surfsara.nl/systems/data-archive
