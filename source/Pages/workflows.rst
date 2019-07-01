.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _workflows:

*********
Workflows
*********

.. Tip:: This is a quickstart on the platform. In this page you will learn:

     * creating a job dependency with Slurm
     * using Picas pilot framework from Spider


.. _slurm-job-dependencies:

======================
Slurm job dependencies
======================

A job can be given the constraint that it only starts after another job has finished.
Lets say that you have two Slurm jobs, A and B. You want job B to start after job A
has successfully completed. Here are the steps:

* Submit job A and keep the returned job ID::

    sbatch <jobA.sh>

* Submit job B with a condition to start after job A, by providing its assigned job ID. This way job B only starts after Job A has successfully completed::

    sbatch --dependency=afterok:<jobID_A> jobB.sh

* We can also tell Slurm to run job B, even if job A fails::

    sbatch --dependency=afterany:<jobID_A> jobB.sh


* If you want job B to start after several other jobs have completed, use the delimiter ':' as::

    sbatch --dependency=afterok:<jobID_A:jobID_C:jobID_D> jobB.sh

.. seealso:: For more information on job dependencies, see also the ``-d, --dependency`` section in the man page of the sbatch command.



.. _picas-on-spider:

=====
PiCaS
=====

When you run many jobs on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` it can be difficult to keep track of the state of these jobs,
especially when you start running hundreds to thousands of jobs. Although Slurm
offers some functionality for tracking the status of the jobs, via the Slurm job ID,
in many cases a `Pilot job framework`_, such as `PiCaS`_, is necessary for this purpose.

Access on PiCaS is *not* provided by default to the :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` projects. To request for PiCaS access, please contact our
:ref:`our helpdesk <helpdesk>`.

If you already have access on PiCaS, then you can use it directly from :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)`, i.e. you can establish a connection to your `CouchDB`_
database and use the python `PiCaS client`_ either from the login node or the worker nodes.

To connect with your PiCaS database you need somehow to provide your credentials
(username, password, database name). It is possible to specify the password on the
command line, however for security reasons this should be avoided on shared systems
(like the login node) because it can allow other local users to read the password (e.g. with
the ``ps`` command). Also to avoid having to type these credentials
every time your client connects to your database or using them within your jobs,
we advice you to authenticate to PiCaS with the steps below.

* Create a PiCaS configuration directory in your home directory. Here we will call
this directory ``picas_cfg``, but you are free to give it any other name.

.. code-block:: bash

        mkdir /home/[USERNAME]/picas_cfg
        chmod go-rwx /home/[USERNAME]/picas_cfg

* Check the settings of your directory with ``ls -la``. The output should be similar to:

.. code-block:: bash

        ls -la /home/homer/picas_cfg
        drwx------ 1 homer homer  3  May  7 08:33 picas_cfg


* Create a new file called ``picasconfig.py`` inside the ``picas_cfg`` directory:

.. code-block:: bash

        cd /home/[USERNAME]]/picas_cfg
        touch picasconfig.py

* Add the following lines to the ``picasconfig.py`` file:

.. code-block:: bash

        PICAS_HOST_URL="https://picas.surfsara.nl:6984"
        PICAS_DATABASE="[YOUR_DATABASE_NAME]"
        PICAS_USERNAME="[YOUR_USERNAME]"
        PICAS_PASSWORD="[YOUR_PASSWORD]"

* Storing cleartext passwords in any medium is dangerous, so we need to make sure it is not readable by others. Save the ``picasconfig.py`` file and for additional security set it to read-write (rw)
access for you only:

.. code-block:: bash

        chmod go-rw /home/[USERNAME]/picas_cfg/picasconfig.py

* Check the permissions of your ``picasconfig.py`` file with ``ls -la``. The output should be
similar to:

.. code-block:: bash

        ls -la /home/homer/picas_cfg/picasconfig.py
        -rw------- 1 homer homer  126 May  7 08:33 picasconfig.py

* Finally, add the ``picas_cfg`` directory to your PYTHONPATH environment variable so that python can locate it. We recommend that you set this variable in your /home/[USERNAME]]/.bashrc file by adding the following lines to it:

.. code-block:: bash

        PYTHONPATH=/home/[USERNAME]/picas_cfg:$PYTHONPATH
        export PYTHONPATH

You are now ready to start using your PiCaS credentials without having to type them each time you or your jobs need to connect to the PiCaS server.
Good practices to build worflows with PiCaS can be found in `PiCaS example`_.


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`


.. Links:

.. _`Pilot job framework`: http://doc.grid.surfsara.nl/en/latest/Pages/Practices/pilot_jobs.html
.. _`PiCaS`: http://doc.grid.surfsara.nl/en/latest/Pages/Practices/picas/picas_overview.html#picas-overview
.. _`CouchDB`: http://couchdb.apache.org/
.. _`PiCaS client`: http://doc.grid.surfsara.nl/en/latest/Pages/Practices/picas/picas_overview.html#picas-client
.. _`PiCaS example`: http://doc.grid.surfsara.nl/en/latest/Pages/Practices/picas/picas_example.html#picas-example
