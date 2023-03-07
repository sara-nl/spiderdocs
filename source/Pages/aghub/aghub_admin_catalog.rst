.. _agh_admin_guide:

***************
AGH Creating a Catalogue
***************

====================
Creating a Catalogue in AGHub
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
Creating a catalogue groups in SRAM
---------------------

Catalogues require two groups to be managed the first is the administrator who will be uploading the data, and the second will be the users who you want to grant access to the data. It is important to create the user group in SRAM before creating the cataglogue so that it can be mapped. For creating the group in SRAM, please see below for an example in a test catalogue:

  - Name - for clarity please create the name as [catalogue-name]_cuser e.g. test_cuser
  - Short name - must be [catalogue-name]_cuser e.g. test_cuser
  - Description - long free text description of the group e.g. test user group for aghub data release


Please also create a data manager group who will have write permissions to the catalogue:
  - Name - for clarity please create the name as [catalogue-name]_cuser e.g. test_cdata
  - Short name - must be [catalogue-name]_cdata e.g. test_cdata
  - Description - long free text description of the group e.g. test user group for aghub data release
  
From SRAM you can map users to these groups in order to grant their access. It is also possible to create multiple groups / catalogue, the syntax is below.


---------------------
Creating the Catalogue in Spider
---------------------

Following the example with a test catalogue, please see below for an example command to create a test catalogue with the test user group created above, please NOTE, the group in SRAM does not perfectly map, and instead follows quite a verbose syntax and so the group above will look like the group below:

.. code-block:: bash

  sudo /usr/local/bin/facl catalog \
    --name "test" \
    --provider-group sram-aghub-amsterdamumc-aghub-test_cdata \
    --user-groups sram-aghub-amsterdamumc-aghub-test_cuser \
    --user-groups sram-aghub-amsterdamumc-aghub-test2_cuser \
    --apply

---------------------
Managing Catalogues
---------------------

Users can be added to catalogues in SRAM by adding them to the cuser group
Groups can be added or removed to catalogues by editing the facl script, for example if you created a catalogue with the following command:

.. code-block:: bash

  sudo /usr/local/bin/facl catalog \
    --name "test" \
    --provider-group aghub_adm \
    --user-groups sram-aghub-amsterdamumc-aghub-test_cuser \
    --user-groups sram-aghub-amsterdamumc-aghub-test2_cuser \
    --apply

Then to remove the second group you would execute the following command:

.. code-block:: bash

  sudo /usr/local/bin/facl catalog \
      --name "test" \
      --provider-group aghub_adm \
      --user-groups sram-aghub-amsterdamumc-aghub-test_cuser \
      --apply
      



