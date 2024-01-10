.. _ada-interface:

*************
ADA interface
*************

Our ADA (Advanced dCache API) interface is based on the dCache API and the webdav
protocol to access and process your data on dCache from any platform and with various authentication methods.

**rclone** is a webdav client that supports by default 4 parallel streams of data, and is installed on the spider platform.

**macaroons** are a token based authentication method supported by dCache. Macaroons can be used to give access to dCache data in a very granular way. This enables data managers autonomously share their data in dCache without having to reach out to SURFsara to request access.

A quick start up guide for ADA is captured in the video below:

.. raw:: html

    <iframe
        width="600" height="400"
        src="https://www.youtube.com/embed/Bh0kpTcUUcw?controls=2">
    </iframe>

.. _browser-view:

============
Browser view
============

dCache storage can be viewed both through the Ada tools or through your browser
using the web client, this is just one additional way you can explore the storage
space.

As a Data manager you have direct credentials on dCache and it is possible
to access the browser view using you Spider credentials [project-username]
in the following link:

https://webdav-secure.grid.surfsara.nl/pnfs/grid.sara.nl/data/[PROJECT]/

.. note:: You may be asked for a browser certificate, just select cancel and you will be asked for your credentials

.. _using-ada:

=========
Using ADA
=========

ADA is a wrapper of tools created by SURFsara to simplify your interactions
with dCache. Rclone can support uploading and downloading data but other
operations such as listing or deleting files and directories can be performed
directly on the dCache API. ADA wraps all of this functionality into one clean
package saving you the hassle of having to download and troubleshoot multiple
packages and dependencies. ADA is installed on Spider.

This section provides examples and the steps to start using ADA to interact
with your dCache storage.

Create a macaroon
=================

* Requirements: credential to dCache

  * username/pwd or
  * x509 proxy

* Spider role: Data manager
* Action: Create a macaroon
* Output: rclone tokenfile `[PROJECT_tokenfile].conf`. You can share this file with any member in the project in next step.
* Description: the DM creates a macaroon for a shared directory (including the sub-directories & files). In the next step he will share the macaroon with the project team in a non-public space, either user's home directories, or the 'shared' or 'data' project space directories.
* Example:

.. code-block:: bash

    get-macaroon \
        --url https://webdav.grid.surfsara.nl:2880/pnfs/grid.sara.nl/data/[PROJECT] \
        --duration P7D \
        --chroot \
        --user [PROJECT]-[USER] \
        --permissions DOWNLOAD,UPLOAD,DELETE,MANAGE,LIST,READ_METADATA,UPDATE_METADATA \
        --ip [IP RANGE] \
        --output rclone [PROJECT_tokenfile]


These permissions can be given comma separated upon creation of the macaroon:

===================  ===============================  
Permission           Function                    
===================  ===============================  
DOWNLOAD             Read a file
UPLOAD               Write a file
DELETE               Delete a file or directory
MANAGE               Rename or move a file or directory
LIST                 List objects in a directory
READ_METADATA        Read file status
UPDATE_METADATA      Stage/unstage a file, change QoS
===================  ===============================  


Share macaroons
===============

The config file generated in the step above can be shared with project members
and collaborators for them to access their data. The holder of this config file
can operate on the dCache project data directly and thus, the config file should
be shared with the project team in a non-public space, for example user's home
directories, or the 'Shared' or 'Data' project space directories on Spider.

* Requirements: the rclone tokenfile `[PROJECT_tokenfile].conf`
* Spider role: Data manager
* Actions: Share [PROJECT_tokenfile].conf in a project space that can be read by other project users
* Output: the tokenfile `tokenfile.conf` is stored in a shared space
* Example:

.. code-block:: bash

    cp [PROJECT_tokenfile].conf /project/[PROJECT]/Data


Inspect the macaroon
====================

* Requirements: the rclone tokenfile `[PROJECT_tokenfile].conf`
* Spider role: Normal user
* Actions: View macaroon
* Output: the list activities and directories that you can use on dCache
* Example:

.. code-block:: bash

    # Your macaroon is the value of 'bearer_token'
    $ cat [PROJECT_tokenfile].conf
    [tokenfile]
    type = webdav
    bearer_token = MDAxY2xvY2F0aWXXXXXXXXXXXXXXXX
    url = https://webdav.grid.surfsara.nl:2880/
    vendor = other
    user =
    password =

    #View the macaroon details
    $ view-macaroon [PROJECT_tokenfile].conf
    location Optional.empty
    identifier NDFXzXXX
    cid iid:03FXXX//
    cid id:39147;35932,30013;[Data Manager Name]
    cid before:2020-02-05T11:01:11.577Z
    cid home:/[Project folder]
    cid root:/[Project folder]
    cid activity:DOWNLOAD,UPLOAD,MANAGE,LIST
    signature fefef25a4973e59b10ad464054dXXXXXXX


Use the macaroon
================

This section describes how to work with your files.

* Requirements: the rclone tokenfile `[PROJECT_tokenfile].conf`
* Spider role: Normal user

.. Tip:: If you want to use an environment variable to set the token file, rather than having to pass it on the command line every time then you can do: ``$export ada_tokenfile=/path-to-mytoken/[PROJECT_tokenfile].conf`` and then you can omit the option '--tokenfile' from all of the ada commands

.. Tip:: You can get extra information about the submitted command and the rest call details by using the `--debug` option in your ada command.

Check your access to the system
-------------------------------

**--whoami**

* Action: request authentication details
* Output: information about the token owner and permissions
* Example:

.. code-block:: bash

    ada --tokenfile [PROJECT_tokenfile].conf --whoami

.. code-block:: bash

    {
    "status": "AUTHENTICATED",
    "uid": 515XX,
    "gids": [
        511XX
    ],
    "username": "[Data Manager name]",
    "rootDirectory": "/pnfs/grid.sara.nl/data/[Project]/disk",
    "homeDirectory": "/"
    }

Listing files
-------------

**--list <directory>**

**--longlist <file|directory>**

**--longlist --from-file <file-list>**

* Action: List files or directories
* Output: List or long list of the files from the directory that the macaroon allows permission
* Example:

.. code-block:: bash

   ada --tokenfile [PROJECT_tokenfile].conf --longlist /[DIRECTORY]


Get file or directory details
-----------------------------

**--stat <file|directory>**

* Action: Show all details of a file or directory
* Output: metadata information
* Example:

.. code-block:: bash

   ada --tokenfile [PROJECT_tokenfile].conf --stat /[FILE or DIRECTORY]


Create a directory on dCache
----------------------------

**--mkdir <directory>**

* Action: Create directories
* Output: New directory created
* Example:

.. code-block:: bash

   ada --tokenfile [PROJECT_tokenfile].conf --mkdir /[DIRECTORY]


Moving or renaming files
------------------------

**--mv <file|directory> <destination>**

* Action: Move file or directory. This can be used as an option also to rename a directory if the move is done in the same directory. Specify the full path and name to the source and target directory
* Output: File or Directory moved to a different dCache location or renamed
* Example:

.. code-block:: bash

   ada --tokenfile [PROJECT_tokenfile].conf --mv /[SOURCE] /[DESTINATION]


Recursively remove folders
--------------------------

**--delete <file|directory> [--recursive [--force]]**

* Action: Delete files or directories
* Output: File or Directory is deleted
* Recursive deletion: To recursively delete a directory and ALL of its contents, add --recursive. You will need to confirm deletion of each subdir, unless you add --force.
* Alternative: `rclone purge`
* Example:

.. code-block:: bash

   ada --tokenfile [PROJECT_tokenfile].conf --delete /[FILE or DIRECTORY]
   ada --tokenfile [PROJECT_tokenfile].conf --delete /[FILE or DIRECTORY] --recursive
   ada --tokenfile [PROJECT_tokenfile].conf --delete /[DIRECTORY] --recursive --force
   # alternative
   $ rclone --config=[PROJECT_tokenfile].conf purge PROJECT_tokenfile]:/disk/rec-delete/


Checksum
--------

**--checksum <file>**

**--checksum <directory>**

**--checksum --from-file <file-list>**

* Action: Get the checksum of a files or files inside a directory or list of files
* Output: Show MD5/Adler32 checksums for files
* Example:

.. code-block:: bash

  ada --tokenfile [PROJECT_tokenfile].conf --checksum /[FILE or DIRECTORY]
  # create a filelist and get checksums for files in it
  ada --tokenfile [PROJECT_tokenfile].conf --list /disk/mydir > files-to-checksum
  sed -i -e 's/^/\/disk\/mydir\//' files-to-checksum
  ada --tokenfile [PROJECT_tokenfile].conf --checksum --from-file files-to-checksum
  #/disk/file1  ADLER32=80690001
  #/disk/file2  ADLER32=80690001
  #/disk/file3  ADLER32=80690001


View your usage
---------------

* Action: get your storage usage with Rclone
* Example:

.. code-block:: bash

   rclone --config=[PROJECT_tokenfile].conf size [PROJECT_tokenfile]:/


Staging
-------

The dCache storage at SURFsara consists of magnetic tape storage and hard disk
storage. If your quota allocation includes tape storage, then the data stored
on magnetic tape has to be copied to a hard drive before it can be used.
This action is called Staging files or ‘bringing a file online’.

Your macaroon needs to be created with UPDATE_METADATA permissions to allow for staging operations.

**--stage <file>**

**--stage <directory>**

**--stage --from-file <file-list>**

* Action: Stage a file from tape or files in directory or a list of files (restore, bring it online)
* Output: the file or list of files comes online on disk
* Example:

.. code-block:: bash

   #list files to get the status
   ada --tokenfile [PROJECT_tokenfile].conf --longlist /[PROJECT_tape_dir]
   #file1  1186443  2020-02-13 16:27 UTC  tape  NEARLINE
   #file2  1635     2018-10-24 15:34 UTC  tape  NEARLINE

   #stage a single file
   ada --tokenfile [PROJECT_tokenfile].conf --stage /[PROJECT_tape_dir]/file1

   #stage a list of files
   ada --tokenfile [PROJECT_tokenfile].conf --stage --from-file files-to-unstage

Unstaging
---------

Your macaroon needs to be created with UPDATE_METADATA permissions to allow for unstaging operations.

**--unstage <file>**

**--unstage <directory>**

**--unstage --from-file <file-list>**

* Action: Unstage/Release a file from tape or files in directory or a list of files
* Output: the file or list of files is unstaged and may be removed for the disk any time so dCache may purge its online replica.

.. code-block:: bash

   #unstage a single file
   ada --tokenfile [PROJECT_tokenfile].conf --unstage /[PROJECT_tape_dir]/file1

   #unstage a list of files
   ada --tokenfile [PROJECT_tokenfile].conf  --list /tape > files-to-unstage
   sed -i -e 's/^/\/tape\//' files-to-unstage
   ada --tokenfile [PROJECT_tokenfile].conf  --unstage --from-file files-to-unstage


.. _transfer-data-rclone:

Transfer Data
=============

In order to transfer files from/to dCache we use the same [PROJECT_tokenfile].conf
and the rclone client to trigger webdav transfers as shown below.

Copy data from dCache
---------------------

.. code-block:: bash

    rclone --config=[PROJECT_tokenfile].conf copy [PROJECT_tokenfile]:/[SOURCE] ./[DESTINATION] -P

Example, copy an existing test folder to Spider:

.. code-block:: bash

   rclone --config=[PROJECT_tokenfile].conf copy [PROJECT_tokenfile]:/tests/ ./tests/ -P


Write data to dCache
--------------------

.. code-block:: bash

   rclone --config=[PROJECT_tokenfile].conf copy ./[SOURCE]/ [PROJECT_tokenfile]:[DESTINATION] -P


Notes on data transfers:

* The rclone ``copy`` mode will just copy new/changed files. The rclone ``sync`` (one way) mode will create a directory identical to the source so be careful because this can cause data loss. We suggest you to test first with the ``–dry-run`` flag to see exactly what would be copied and deleted.
* You can increase the number of parallel transfers with the ``--transfers [Number]`` option.
* When copying a small number of files into a large destination you can add the ``--no-traverse option`` in the rclone copy command for controlling whether rclone lists the destination directory or not. This can speed transfers up greatly.
* If you are certain that none of the destination files exists you can add the ``--no-check-dest option`` in the rclone copy command to speed up the transfers.
* For very large files it is important to set the ``–timeout`` option high enough. As a rule of thumb, set it to 10 minutes for every GB of the biggest file in a collection. This may look ridiculously large, but it provides a safe margin to avoid problems with timeout issues
* Using ``--multi-thread-streams 1`` increases the performance for large files copied to dCache.


.. code-block:: bash

   #example command to upload a big file
   rclone --timeout=240m  --multi-thread-streams 1 --config=[PROJECT_tokenfile].conf copy ./[SOURCE]/ [PROJECT_tokenfile]:[DESTINATION] -P

.. _dcahce-events:

=======================
Event-driven processing
=======================

Events are useful when you want to know something you’re interested in happened in your dCache project
space, such as when new data is available or when files are staged from tape, etc.

* Subscribe to changes in a given directory:

.. code-block:: bash

   ada --tokenfile [PROJECT_tokenfile].conf --events changes-in-dir /[PROJECT_directory] --recursive

* Check the available channels listening to events:

.. code-block:: bash

   ada --tokenfile [PROJECT_tokenfile].conf --channels

* Report staging events

When you start this channel, all files in the scope will be listed, including their locality and QoS.
This allows your event handler to take actions, like starting jobs to process the files that are online.
When all files have been listed, the command will keep listening and reporting all locality and QoS changes.

.. code-block:: bash

   ada --tokenfile [PROJECT_tokenfile].conf --report-staged staging-in-tape-dir /[PROJECT_directory] --recursive


==============
Authentication
==============

In this page we gave an extended example on using ada with macaroons authentication.
Ada can be used with multiple authentication options.

===================  ===============================  ===================
Authentication       ADA commands                     When to use
===================  ===============================  ===================
Macaroon             ``ada --tokenfile <filename>``   You don't have direct access on dCache but you have a token from the project data manager that allows you certain permissions on the data
Username/password    ``ada --netrc [filename]``       You have direct usr/pwd access credentials on dCache
X509 Certificate     ``ada --proxy [filename]``       You have direct VO membership access on dCache
===================  ===============================  ===================

Here is an example of a .netrc file that you can create in your home to use username/password authentication:

.. code-block:: bash

   $ cat ~/.netrc:
   machine webdav.grid.surfsara.nl
   login [your-ui-username]
   password [your-ui-password]
   machine dcacheview.grid.surfsara.nl
   login [your-ui-username]
   password [your-ui-password]


================
Run ADA anywhere
================

In this page we gave an extended example on using ada on the Spider platform.
Ada is portable and can be used on any platform. On the SURFsara UIs ADA is already
on board. If you want to interact with the dCache API and transfer files from your
own machine then you need to install the following prerequisites:

* ``jq``: the only dependency for executing ada commands
* ``rclone``: the client to perform transfers (MacOS: brew install rclone)

As a Data manager if you wish to create macaroons from any platform, e.g. your
local machine, then you need to install the following `get-macaroon` and `view-macaroon` scripts:

* ``wget https://raw.githubusercontent.com/sara-nl/GridScripts/master/get-macaroon``
* ``wget https://raw.githubusercontent.com/sara-nl/GridScripts/master/view-macaroon``
* And their dependencies: ``pymacaroons, python3-html2text``

=======================
Ada configuration files
=======================

The user specific configuration files are written in ~/.ada/

1) The URL to query the API is stored in `/etc/ada.conf` (system default) or `~/.ada/ada.conf` (user specific, optional)
2) The bearer tokens information based on a tokenfile is stored in `~/.ada/headers/`. The authorization_header is created for security to prevent from reading the token as argument and be displayed in 'ps' info. This way the token is read from a hidden file in the user home dir
3) The Events information such as the last eventID is stored in `~/.ada/channels/`
