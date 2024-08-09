
.. _shared-memory:

*****************
Shared memory
*****************

What is shared memory
---------------------

The shared memory is a path on the system where you can directly write files into the RAM of the machine. It looks and behaves like the regular file system. This way you can bypass the storage of a device and work directly in memory. The path to this memory is ``/dev/shm``.

When to use shared memory
-------------------------

When working on many small files simultaneously, such as tarring or untarring the files to/from the regular file system. As the file system performance is not optimal in these situations, it may be better to copy the files into ``/dev/shm`` to a path of your choosing and work there before moving the result onto the regular file system or dCache.

Considerations on shared memory
-------------------------------

As shared memory is in RAM there are some considerations:  
 - The size is limited to less than the RAM size, because the OS also needs RAM to run
 - The storage is not permanent, on a reboot all is lost
 - It is shared with other processes and users, so these may interfere with your usage and can read your data

Example
-------

Here is a job script template for ``/dev/shm`` usage:

.. code-block:: bash
   
   #!/bin/bash
   #SBATCH -N 1      #request 1 node
   #SBATCH -c 1      #request 1 core and 8000 MB RAM
   #SBATCH -t 5:00   #request 5 minutes jobs slot

   # extract a tar file in memory
   cp /path/to/tarfile/file_in.tar /dev/shm
   cd /dev/shm
   tar xvf file_in.tar

   # run the analysis on 2 extracted files 
   python analysis.py /dev/shm/extracted_file1.in
   python analysis.py /dev/shm/extracted_file2.in

   # tar the 2 output file (*.out) into an output tar file
   tar cvf file_out.tar extracted_file1.out extracted_file2.out
   cp file_out.tar /path/to/tarfile/

   echo "SUCCESS"
   exit 0

