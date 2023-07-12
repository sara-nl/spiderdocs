.. _agh_admin_guide:

***************
AGH Admin Guide
***************

====================
Adding New Users
====================

---------------------------------------------------------
Invite New Members to the Collaborative Organization (CO)
---------------------------------------------------------

AGHub's authentication is managed using SRAM, for more information on adding new users to the AGH CO, please see SRAM documentation here:

`SRAM Documentation <https://wiki.surfnet.nl/display/SRAM/Invite+admins+and+members+to+a+collaboration/>`_ 

Also, an AGHub user will require a Research Drive account. Users can be added through the Research drive Dashboard.

The research drive can be accessed here:
https://amsterdamumc.data.surfsara.nl/index.php/login

Follow the steps below to add a new user to the AGH CO:
- Go to Menu->Dashboard
- Click the 'Gebruiksaccounts' tab, and then the 'Uitnodigen' button.

Next, create an a subfolder for the user in the 'AGHub' folder. 

Once the user has created their account, you will receive a mail notification. At that point,
you can give the user permission to access his/her folder by clicking the 'Sharing' icon behind the folder name
and entering the user's email address (as indiciated in the notification email). 


---------------------
Add Groups for Access
---------------------

Users access is provisioned based on user groups they are assigned to. Users are automatically added to aghub_cpu and aghub_login, but need to be added to sw/data/user to control their access to the project space. For now sw/data/user groups control access to the aghub project, for now there is only one AGHub project (/project/aghub)

After adding new users, please refer then to the `AGH getting started guide` for setting up their new account and logging into the cluster.

==================================================
Managing storage - dCache / External Project Space
==================================================

---------------------
Accessing the storage
---------------------

There is no dedicated API door, so only rclone functionality is available, not ADA. There is also a dedicated webdav-agh domain or 'door' to help keep the AGH cluster access restricted. Data can only be uploaded to whitelisted IP's which can be requested through SURF's servicedesk.

"""""""""""""""
Simple download
"""""""""""""""

In order to use the AGH external storage with the use of an additional client, you can make use of the system package curl.

**Example**

.. code-block:: bash

  curl -u $USER https://webdav-agh.grid.surfsara.nl/tape/get-macaroon.sh


----------------------------------------
Granting access to storage - create a token for AGH
----------------------------------------

AGH end-point and caveat requirements here, the wedav-agh end point is dedicated for the AGH project.

After granting access to a user they can then make use

**Example**

.. code-block:: bash

  get-macaroon \
    --url https://webdav-agh.grid.surfsara.nl/tape/ \
    --user [AGH-USERNAME] \
    --permissions UPLOAD \ # should include upload only
    --duration P7D \ # whenever possible add a time limit
    --output rclone [TOKEN NAME] \
    --ip [Restricted range] \
    --chroot


=================================
 Accessing accounting information
=================================

In order to view the respective usage of projects

.. code-block:: bash

  sudo /usr/local/bin/spider-acc \
      report [PROJECTNAME] \
      --start 2021-01-01 \
      --end 2022-06-20
