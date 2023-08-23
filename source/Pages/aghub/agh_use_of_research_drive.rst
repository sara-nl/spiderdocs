.. _agh_research_drive:

*************************
AGH Use of Research Drive
*************************

---------------------
Use of research drive
---------------------

Due to AGH being a secure compute environment, it is not possible to directly download or upload data from/to the internet.
Instead, we use the SURF Research Drive to transfer data to and from the cluster. 


---------------------
Setting up an account
---------------------

To this end, you should have received an invitation mail for the Research Drive. Within this mail there is a link to
create an account. After following this link, there are two options: 

* If your organization allows logging in through Surfconext, you are advised to use that option. You can then login with  your institutional account credentials.

* Alternatively, you can select the option to set up a password directly. Note that you will *not* be guided to a new page, but instead directly receive a (temporary) password in the mail. 

After you have created an account, an AGHub Admin has to create and give you access to your own AGHub folder. This can take
up to a day during working days. If you have not received permissions after a day, please contact an AGH Admin.
Up till then, you will have an empty home folder.

After you have received permissions, you can access the AGH project folder through the Research Drive.

----------------------------------------------------
Accessing the Research Drive from your local machine
----------------------------------------------------

The research drive can be accessed in multiple ways:

* The web browser: `Research Drive <https://amsterdamumc.data.surfsara.nl/>`_.

* A sync client on your local machine. This will automatically sync the contents of the
Research Drive to a folder on your local machine. This way, you can easily transfer data to and from the cluster. 
This client is available for Windows, Mac and Linux. The following page describes how to set up the client:
`ownCloud client <https://wiki.surfnet.nl/display/RDRIVE/ownCloud+desktop+client>`_.

* RClone. This is a command line tool that allows you to sync the Research Drive to a folder 
on your local machine. This is especially useful if you want to automate the syncing process. RClone also allows you to
mount the research drive folder on your local machine. Setting up RClone is described on the following page:
`rClone access <https://wiki.surfnet.nl/display/RDRIVE/Access+Research+Drive+via+Rclone>`_.

-------------------------------------------------
Accessing the Research Drive from the AGH cluster
-------------------------------------------------

The research drive can be accessed from the cluster through the use of RClone. How to set this up is described on the
following page: `rClone access <https://wiki.surfnet.nl/display/RDRIVE/Access+Research+Drive+via+Rclone>`_.

After finishing this, there should be a rclone config being available which the name
that was chosen during configuration (e.g. 'RD').



----------------------------------------------
Use of rclone to transfer data to and from AGH
----------------------------------------------

In the previous section, you have set up a configuration with a specific name (e.g. 'RD'). 
Now, tClone can be used to transfer data to and from the AGH cluster to the research drive. 
This can be done in two ways:

1. A direct copy command: 

.. code-block:: bash
    rclone copy /path/to/local/file RD:your_folder_name/file
    rclone ls RD:your_folder_name

(`your_folder_name` is the name of the folder you see when executing `rclone ls RD:`)


2. By mounting the research drive to a folder on the cluster. This can be done by the following command:

.. code-block:: bash
    rclone mount RD:your_folder_name ~/rd

(This assumes there is already a folder named `rd` in your home directory, as this
folder is created by the init script (see :ref:`_agh_getting_started`)).

You can now move the rclone process to the background by pressing CTRL+Z and then typing 'bg'.


Now, files in the folder 'rd' will mirror the files in the research drive. 
Also, if you have set up a sync client or a similar rclone configuration on your local machine,
any files copied to the rd folder will immediately appear in the mounted folder on your local machine. 
Vice versa, any files copied in the mounted folder on your local machine will immediately appear in the 
rd folder on the cluster.

Note that the mounted folder will be empty if you have not copied any files to the research drive yet.

To unmount the folder, you can move the rclone process to the foreground by typing 'fg' and then pressing CTRL+C.
Alternatively, you can use the command 'fusermount -u rd' to unmount the folder.


--------------------------------
Recommended rclone mount options
--------------------------------

For day to day use, we recommend a few options to make the connection more reliable:

.. code-block:: bash
    rclone mount --use-cookies --timeout 15m --cache-dir ~/.rd_cache --vfs-cache-mode full --no-modtime RD:your_folder_name  ~/rd

The option '--use-cookies' will make sure that you get connected to the same backend to prevent file locking issues. 
The option '--timeout 15m' is needed for the transfer of large files (increase if needed). 
The option '--cache-dir .rd_cache --vcf-cache-mode full' will cache files locally to enable random access file access patterns. 
The option '--no-modtime' will not update the modification time of files on the research drive (can speed things up).

Also, you can run the rclone mount command in a screen session to prevent the connection from being terminated when you
log out of the cluster. To facilitate this, we have created a script that
automatically sets up the screen session and executes the rclone mount command. 

To use this script, run the following command:

.. code-block:: bash
    mount_rd RD:your_folder_name

(This assumes that you have named your configuration 'RD'. If you have chosen a different name, replace 'RD' with the
name of your configuration.)

To unmount the research drive, run the following command:

.. code-block:: bash
    fusermount -u ~/rd

