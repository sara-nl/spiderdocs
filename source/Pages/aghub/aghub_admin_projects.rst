.. _agh_admin_projects:

***************
AGH Creating a new Project
***************

====================
Creating a Project space in AGHub
====================

The facl tool is available to administrators on the AGHub system. This tool can be run using sudo on the UI.

---------------------------------------------------------
Overview of the facl
---------------------------------------------------------

.. code-block:: bash

  $ facl --help
    Usage: facl [OPTIONS] COMMAND [ARGS]...

      This script configures the ACL entries for a given project or catalog
      following the file permission convention defined for the SPIDER cluster or a
      custom template defined by the user.

      If the folder structure of the project / catalog  does not exist, the script
      can create it before enforcing the ACL configuration.

    Options:
      --help  Show this message and exit.

    Commands:
      catalog   Apply the default ACL scheme to a given catalog
      project   Apply the default ACL scheme to a given project

---------------------
Creating project groups in SRAM
---------------------

Projects require three groups to be managed the first is the administrator who will be uploading the data. These groups are described here in the Spider documentation:
https://spiderdocs.readthedocs.io/en/latest/Pages/about.html#project-space

Examples for the three groups are below:

* Normal User *

  - Name - should be [project-name]_user
  - Short name - must be [project-name]_user
  - Description - Normal User group for the [project-name] project on AGHub

* Data Manager *

  - Name - should be [project-name]_data
  - Short name - must be [project-name]_data
  - Description - Data manager group for the [project-name] project on AGHub
  
* Software Manager *

- Name - should be [project-name]_sw
- Short name - must be [project-name]_sw
- Description - Software manager group for the [project-name] project on AGHub
  
From SRAM you can map users to these groups in order to grant / manage their access. 

---------------------
Creating the Project in Spider
---------------------

Following the example with a test project, please see below for an example command to create a test catalogue with the test user group created above, please NOTE, the group in SRAM does not perfectly map, and instead follows quite a verbose syntax and so the group above will look like the group below:

.. code-block:: bash

  sudo /usr/local/bin/facl project \
    --name test \
    --data-group sram-aghub-amsterdamumc-aghub-test_data \
    --sw-group sram-aghub-amsterdamumc-aghub-test_sw \
    --user-group sram-aghub-amsterdamumc-aghub-test_user \
    --apply

---------------------
Managing Catalogues
---------------------

Users can be added to projects in SRAM by adding them to the respective user groups

In order to remove a project space please open a ticket at SURF's servicedesk:
https://servicedesk.surf.nl/
      



