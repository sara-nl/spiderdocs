.. _ada-interface:


=============
Browser
=============

View dCache repository in browser
=================================

dCache storage can be viewed both through the Ada tools or through your browser using the web client, this is just one additional way you can explore the storage space. You can log-in using you Spider credentials [spexone-username]

NOTE: you may be asked for a browser certificate, just select cancel and you will be asked for your credentials

`https://webdav-secure.grid.surfsara.nl/pnfs/grid.sara.nl/data/[PROJECT]/`

===============
rClone / webdav
===============

**rclone** is a webdav client that supports by default 4 parallel streams of data, and is installed on the spider platform. 

**macaroons** are a token based authentication method supported by dCache. Macaroons can be used to give access to dCache data in a very granular way. This enables data managers autonomously share their data in dCache without having to reach out to SURFsara to request access. 

Create a macaroon
=================

.. code-block:: bash

    get-macaroon \ 
        --url https://webdav.grid.surfsara.nl:2880/pnfs/grid.sara.nl/data/[PROJECT] \
        --duration P7D \ 
        --chroot \ 
        --user [PROJECT]-[USER] \ 
        --permissions DOWNLOAD,UPLOAD,DELETE,MANAGE,LIST,READ_METADATA,UPDATE_METADATA \
        --ip '0.0.0.0/0' #totally open example \
        --output rclone [PROJECT_macaroon]



Share macaroons
===============

The config file generated in the step above can be shared with project members and collaborators for them to access their data. The holder of this config file can operate on the dCache project data directly and thus, the config file should be shared with the project team in a non-public space, for example user's home directories, or the 'Shared' or 'Data' project space directories on Spider.

.. code-block:: bash

    cp [PROJECT_macaroon].conf /project/[PROJECT]


Copy data from dCache
=====================

.. code-block:: bash

    rclone --config=[PROJECT_macaroon].conf copy [PROJECT_macaroon]:/[SOURCE] ./[DESTINATION] -P

Example, copy an existing test folder to Spider

.. code-block:: bash

    rclone --config=[PROJECT_macaroon].conf copy [PROJECT_macaroon]:/tests/ ./tests/ -P


Write data to dCache
===================

.. code-block:: bash

    rclone --config=[PROJECT_macaroon].conf copy ./[SOURCE]/ [PROJECT_macaroon]:[DESTINATION] -P
===
ADA
===

ADA is a wrapper of tools created by SURFsara to simplify your interactions with dCache. Rclone can support uploading and downloading data but other operations such as listing or deleting files and directories can be performed directly on the dCache API. ADA wraps all of this functionality into one clean package saving you the hassle of having to download and troubleshoot multiple packages and dependencies. ADA is installed on Spider

Check your access to the system
===============================

.. code-block:: bash

    ada --tokenfile [PROJECT_macaroon].conf --whoami

.. code-block:: json

    {
    "status": "AUTHENTICATED",
    "uid": 51539,
    "gids": [
        51181
    ],
    "username": "spexone-klutz",
    "rootDirectory": "/pnfs/grid.sara.nl/data/spexone/disk",
    "homeDirectory": "/"
    }


Create a directory on dCache
=============

.. code-block:: bash

    ada --tokenfile [PROJECT_macaroon].conf --mkdir [DIRECTORY]


Move files on dCache
=============

.. code-block:: bash

    ada --tokenfile [PROJECT_macaroon].conf --mv [SOURCE] [DESTINATION]

List files on dCache
=============

.. code-block:: bash

    ada --tokenfile [PROJECT_macaroon].conf --longlist [DIRECTORY]

Recursively remove folders 
=============

.. code-block:: bash

    ada --tokenfile [PROJECT_macaroon].conf --delete [DIRECTORY] --recursive --force

View your usage
===============

.. code-block:: bash

    rclone --config=[PROJECT_macaroon].conf size [PROJECT_macaroon]:/