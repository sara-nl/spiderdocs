
.. _mpi-file-utils:

*****************
MPI File Utils
*****************

The `mpiFileUtils <https://mpifileutils.readthedocs.io/en/v0.11.1/index.html>`_ is a MPI-based tool for managing datasets using multiple processes. The mpiFileUtils has been proven to copy, delete, and compare data sets with significantly performance improvement compared to traditional single-process tools such as cp and rm. 

.. note::

	If you wish to try the mpiFileUtils on Spider, please contact us at :ref:`our helpdesk <helpdesk>` to provide you with further information about the tools installation.  
   

*****************
Utilities
*****************

The mpiFileUtils tools are MPI tools thus must be run with mpirun in a cluster. On Spider, mpirun is installed at `/usr/lib64/openmpi/bin/mpirun`, and mpiFileUtils tools are installed at `/data/mpifileutils/install/bin`. 

The most often used mpiFileUtils tools are:

- `dcp <https://mpifileutils.readthedocs.io/en/v0.11.1/dcp.1.html>`_ - Copy files.
- `drm <https://mpifileutils.readthedocs.io/en/v0.11.1/drm.1.html>`_ - Remove files.
- `dsync <https://mpifileutils.readthedocs.io/en/v0.11.1/dsync.1.html>`_ - Synchronize source and destination directories or files.
- `dcmp <https://mpifileutils.readthedocs.io/en/v0.11.1/dcmp.1.html>`_ - Compare contents between directories or files.
- `dbz2 <https://mpifileutils.readthedocs.io/en/v0.11.1/dbz2.1.html>`_ - Compress and decompress a file with bz2.
- `dtar <https://mpifileutils.readthedocs.io/en/v0.11.1/dtar.1.html>`_ - Create and extract tape archive files.
- `dchmod <https://mpifileutils.readthedocs.io/en/v0.11.1/dchmod.1.html>`_ - Change owner, group, and permissions on files.
- `dwalk <https://mpifileutils.readthedocs.io/en/v0.11.1/dwalk.1.html>`_ - List, sort, and profile files.


*****************
Examples commands
*****************

The dcp is used for recursively copying files and directories which are located on a distributed parallel file system, such as CephFS. 

To copy dir1 as dir2,

.. code-block:: Bash

 mpirun -np 8 -oversubscribe dcp --chunksize 8MB /source/dir1 /dest/dir2


The :code:`-np 8` indicates that it will run 8 processes in your current run-time environment. The :code:`--chunksize 8MB` is the divided chunck size while copying a large file using multiple processes. The default chunksize is 4MB. You can adjust the values of :code:`-np` and :code:`--chunksize` to achieve the best performance. Adding :code:`-oversubscribe` to the command is to indicate that more processes should be assigned to any node in an allocation than that node has slots for. 

To remove a directory and its contents recursively in parallel,

.. code-block:: Bash

 mpirun -np 8 -oversubscribe drm -v /dir/to/delete



The dsync works similarly to dcp and synchronizes two files or two directory trees.
To synchronize dir2 to match dir1,

.. code-block:: Bash

 mpirun -np 8 -oversubscribe dsync --chunksize 8MB /source/dir1 /dest/dir2

The parallel MPI application dtar can create archive fles in pac file format and also create an index to record the number if items.
To create an archive of dir named dir.tar,

.. code-block:: Bash

 mpirun -np 8 -oversubscribe dtar -c -f dir.tar dir/

The :code:`-c -f` create a tar archive with the specified name of archive file.

The dtar can extract only only archives that were created by tar, but also archives that have been compressed with gzip, bz2.
To extract an archive named dir.tar,

.. code-block:: Bash

 mpirun -np 8 -oversubscribe dtar -x -f dir.tar 




*****************
Usage tips
*****************

- The mpiFileUtils don't have checkpoint, so provide sufficient time for the tools to complet before it is terminated.
- When using dcp to copy data, if a long-running copy is killed before finish, delete the partial copy and run dcp again from the beginning.
- Due to MPI configuration in Spider, it is not possible to use mpiFileUtils on multiple nodes. You can make use of the mpiFileUtils on a single node.
- In terms of error, inspect stdout and stderr output for errors.

