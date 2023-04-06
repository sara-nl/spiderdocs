************
Getting help
************

.. Tip:: Perhaps you are puzzled with something and seek for help on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`. In this page you will find:

     * our Helpdesk details
     * how to get expert advice for project challenges
     * the most commonly asked questions and workarounds for known issues
     * some tutorial as prerequisites to use the platform


.. _helpdesk:

========
Helpdesk
========

If you run into problems and cannot find an answer in our :ref:`contents` or the
:ref:`FAQ`, we encourage you to contact our experts who are there to support
the :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` users. Send us an email with your question at:
helpdesk@surfsara.nl

Find more about SURFsara support availability and response times `here`_.


.. _expertise:

=========
Expertise
=========

Our support team is specialized in advising on data processing strategies and
collaborative data analysis. Over the years the team has gained experience in
many unique projects, all requiring a unique combination of generic components
to implement their ideal data processing setup. Our team is available to support
a range of proven solutions for each problem:

* off-the-shelf data staging processes from a variety of (external) storage systems
* off-the-shelf processing orchestration processes
* specialized consultancy for automated production pipes


.. _FAQ:

===
FAQ
===

I cannot login after adding/changing my ssh keys
================================================

If you added or changed your SSH key on the `SURFsara portal <https://portal.surfsara.nl/>`_, access to the login node
may not be immediately possible. It can take *up to 15 minutes* to be able to login
to :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`. In case that it takes longer time, please contact us at :ref:`helpdesk <helpdesk>`.

The FACL permissions on my file do not match the folder the files are stored in
===============================================================================

This type permissions mismatch can occur when ``mv`` is used, as the move command keeps the original ACL entries from the original file. This behaviour is part of ``mv`` and can not be changed. The permission mismatch occurs when a file with no extra ACL entries is moved to a folder that has some non-trivial ACL entries set up. Using the ``cp`` command will allow the user to preserve the original ACL entries or accept the ACL entries from the destination folder to be enforced onto the copied files. This will ensure that no such permission mismatch occurs. Similarly, the ``rsync`` command will also allow the user to control what kind of ACL is applied to the files in the destination.


.. I cannot login and getting a "host key has just changed" message
.. ================================================================

.. If the host key has changed on the login node recently it will effect the 'known hosts' file that you
.. have on your PC. In order to work around this you must:

.. * remove the :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` entry from your `known hosts file` this will be different depending on your operating system of choice
.. * try to log back into the login node, you will be prompted to automatically add the new host key to your PC


.. _tutorials:

=========
Tutorials
=========

* Tutorial for `Introduction to Unix`_
* Tutorial for `Introduction to batch scheduling systems`_
* Tutorial for `Slurm Quickstart`_

.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. Links:

.. _`Here`: https://www.surf.nl/en/about-surf/helpdesk-data-and-computing-services
.. _`Introduction to Unix`: https://swcarpentry.github.io/shell-novice/
.. _`Introduction to batch scheduling systems`: https://psteinb.github.io/hpc-in-a-day/
.. _`Slurm Quickstart`: https://slurm.schedmd.com/quickstart.html
