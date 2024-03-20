
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
