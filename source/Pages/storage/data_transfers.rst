.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _data-transfers:

.. contents::
    :depth: 2

**************
Data transfers
**************

On this page you will find general information about data transfers to and from
Spider.

.. _data-transfers-within-ht:

=====================================
Data transfers within Spider
=====================================

To transfer data between directories located within Spider we advise
you to use the unix commands ``cp`` and ``rsync``. Other options may be
available, but these are currently not supported by us.

Help on these commands can be found by (i) typing ``man cp`` or ``man rsync``
on the command line after logging into the system, or (ii) by contacting
:ref:`our helpdesk <helpdesk>`.


.. _data-transfers-to-and-from-ht:

======================================
Data transfers to/from Spider
======================================

To transfer data to and from Spider we advise you to use ``scp``,
``rsync``, ``curl`` or ``wget``. Other options may be available, but these 
are currently not supported by us.

Help on the above commands can be found by (i) typing ``man [COMMAND]`` after
logging into the system. For those cases that require another client for data
transfers, we kindly request that you to contact us via
:ref:`our helpdesk <helpdesk>`.

Below we provide a number of examples.

======================================
Data transfers between Spider and the SURFsara Data Archive  
======================================

For long-term preservation of precious data SURFsara hosts the `Data Archive`_. This Data Archive allows their users to safely archive up to Petabytes of valuable   research data using modern tape library technology. Data ingested into the Data Archive is kept in two different tape libraries at two different locations in The Netherlands. The Data Archive is connected to all compute infrastructures, including Spider, at SURFsara via a fast network connection and users with a Data Archive login have immediate, 24/7 access to the service. The Data Archive service is described in more detail on the `Data Archive - description`_ page.

In order to store and retrieve data to/from the SURFsara Data Archive on Spider you need to have a separate Data Archive login account. Information about obtaining a login account can be found on the `Data Archive - obtaining an account`_ page. 

If you are logged in as a user on Spider then we support ``scp`` and ``rsync`` to transfer data between Spider and Data Archive as follows,  

Transfer data from Spider to Data Archive:  

.. code-block:: bash

        scp /home/<spider-user>/transferdata.tar.gz <archive-user>@archive.surfsara.nl:/home/<archive-user>/  
        rsync -a -W /home/<spider-user>/transferdata.tar.gz <archive-user>@archive.surfsara.nl:/home/<archive-user>/  

Retrieve data from Data Archive on Spider:  

.. code-block:: bash

        scp <archive-user>@archive.surfsara.nl:/home/<archive-user>/transferdata.tar.gz /home/<spider-user>/  
        rsync -a -W <archive-user>@archive.surfsara.nl:/home/<archive-user>/transferdata.tar.gz /home/<spider-user>/

Best practices for the usage of Data Archive are described on the `Data Archive - usage`_ page.  

Side note: If the file to be retrieved from Data Archive to Spider is not directly available on disk then the scp/rsync command will hang until the file is moved from tape to disk. Data Archive users can query the state of their files by logging into the Data Archive user interface and performing a ``dmls -l`` on the files of interest. Here the state of the file is either on disk (REG) or on tape (OFL). The Data Archive user interface is accessible via ``ssh`` from anywhere for users that have a login account and an example is given below,  

.. code-block:: console

        ssh <archive-user>@archive.surfsara.nl
	touch test.txt
	dmls  -l test.txt 
	-rw-r--r--  1 raymondo    raymondo    0 2019-04-25 15:24 (REG) test.txt


======================================
Data transfers between Spider and your own Unix-based (Linux, Unix, Mac-OS) system  
======================================

If you are logged in as a user on Spider then we support ``scp`` and ``rsync`` to transfer data between Spider and your own Unix-based system as follows,

Transfer data from Spider to your own Unix-based system:  

.. code-block:: bash

        scp /home/<spider-user>/transferdata.tar.gz <own-system-user>@own_system.nl:/home/<own-system-user>/  
        rsync -a -W /home/<spider-user>/transferdata.tar.gz <own-system-user>@own_system.nl:/home/<own-system-user>/  

Retrieve data from own Unix-based system on Spider:  

.. code-block:: bash

        scp <own-system-user>@own_system.nl:/home/<own-system-user>/transferdata.tar.gz /home/<spider-user>/  
        rsync -a -W <own-system-user>@own_system.nl:/home/<own-system-user>/transferdata.tar.gz /home/<spider-user>/

.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`


.. Links:
.. _`Data Archive`: https://www.surf.nl/en/secure-long-term-storage-with-data-archive
.. _`Data Archive - description`: https://userinfo.surfsara.nl/systems/data-archive/description
.. _`Data Archive - obtaining an account`: https://userinfo.surfsara.nl/systems/data-archive/obtaining-account
.. _`Data Archive - usage`: https://userinfo.surfsara.nl/systems/data-archive/usage
