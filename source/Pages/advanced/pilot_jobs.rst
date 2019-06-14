.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _pilot_jobs:

.. contents::
    :depth: 2

***********
Pilot Jobs
***********

=============================
Pilot Jobs on Spider
=============================

When you run many jobs it can be difficult to keep track of the state of these jobs, especially when you start running hundreds to thousands of jobs. Although Slurm offers some functionality for tracking jobs, via the Slurm job ID, we believe that in many cases it can be easier for Spider users to instead use a pilot job framework for this purpose.

.. _pilot-job-frameworks:

====================================
  Pilot Job Frameworks
====================================

Pilot job frameworks start by submitting a number of pilot jobs to the job scheduler (i.e. to Slurm via for example sbatch). These pilot jobs are like normal Slurm jobs, but instead of executing the task directly they contact a central server once they are running on a worker node. Then, and only then, will they be assigned a task and start executing that task. The central server handles the request from pilot jobs and keeps a log of what tasks are being handled, are finished, and can still be handed out. The pilot job can request a new task, report the successful completion of a task just executed or report that it is still working on the task it received previously. When the task server does not hear about the progress or completion of a task it has distributed, it will assume the pilot job is either dead or that the job has failed. As a result the task will be assigned to another pilot job after it has made a request for a new task.

A pilot job will not die after it has successfully completed a task, but immediately ask for another one. It will keep asking for new jobs, until there is nothing else to do, or its wall-clock time is up. This can reduce the overhead for job submission and administration considerably. The second advantage of pilot job frameworks is that you do not have to worry about job failures. When jobs fail they will not request and process new tasks. 

More information about pilot job frameworks can also be found on our `Grid Pilot Job`_ documentation


.. _picas-and-couchdb:

====================================
  The PiCas Pilot Job Framework on Spider
====================================

In pilot job frameworks, your job task description database is hosted on a central server which is not necessarily tied to the computing infrastructure (e.g. Spider). In fact, typically you can have simple access from anywhere to the central server for pilot jobs with your internet browser or with HTTP command line clients like wget and curl. 

On Spider we support a lightweight pilot job framework that we have named PiCaS. The job task description database for PiCaS is based on `CouchDB`_ (see also the `CouchDB book`_), a NoSQL database, and the client side is written in Python. A more detailed description of PiCaS is provided on our `Grid PiCaS`_ documentation.

Now let’s say that you have a number of tasks to be processed on the Spider worker nodes. Each task requires a set of parameters to run. The parameters of each task (e.g., run id, input files, etc) construct an individual piece of work, called a token, which is just a task description - not the task itself.

The repository for all your task descriptions is PiCaS, i.e. the job task description database that hosts your pool of tokens. This database is hosted on our central PiCas server. The pilot jobs request the next free token for processing from PiCaS. The content of the tokens is opaque to PiCaS itself and can be anything your application needs. PiCaS works as a queue, providing a mechanism to step through the work one token at a time. It is also a pilot job system, indicating that the client communicates with the PiCaS server to fetch work.

The state of a token in the PiCas database can be modified by your job. In our standard PiCaS database setup we support the 'todo', 'locked', 'error' and 'done' states for a token. These tokens combined with their corresponding database views allow you to quickly check the state of your all job tokens and thus monitor their progress. Basically this means that PiCaS provides you with your own centralized job database to keep track of all your work. 

The basic PiCaS implementation discussed here and supported on Spider is purposely very generic. However, the lightweight implementation means that it can be easily extended for specific needs by a project. For more information on our PiCaS implementation please contact :ref:`our helpdesk <helpdesk>`.



.. _picas-authentication:

====================================
  PiCaS Access and Authentication
====================================

A compute project on Spider can request a project specific PiCaS allocation. To request access to PiCaS please contact :ref:`our helpdesk <helpdesk>`. After your request has been granted you will receive a separate set of PiCaS credentials that are not related to Spider. To communicate with the PiCaS server you need these PiCaS credentials that consist of three values: (i) a PiCaS username, (ii) a PiCaS database name, and (iii) a PiCaS database password.

To contact the PiCaS database server via the PiCaS client you need to provide these credentials to the client. To avoid having to type these credentials every time your clients needs to connect to the server we suggest the following method to store your PiCaS credentials.

Step-1, please create a PiCaS configuration directory in your home directory. Here we will call this directory ``picas_cfg``, but you are free to give it any other name. 

.. code-block:: bash

        mkdir /home/<user>/picas_cfg
        chmod go-rwx /home/<user>/picas_cfg

Please check the settings of your directory with ``ls -la``. The output should be similar to

.. code-block:: bash

        ls -la /home/<user>/picas_cfg
        drwx------ 1 <user> <user>    3 May  7 08:33 picas_cfg

Step-2, create a new file called ``picasconfig.py`` in the ``picas_cfg`` directory.

.. code-block:: bash

        cd /home/<user>/picas_cfg
        touch picasconfig.py

Step-3, add the following lines to the ``picasconfig.py`` file
 
.. code-block:: bash

        PICAS_HOST_URL="https://picas.surfsara.nl:6984"
        PICAS_DATABASE=""
        PICAS_USERNAME=""
        PICAS_PASSWORD=""

Step-4, now insert in the ``picasconfig.py`` file your picas credentials, i.e your PiCaS database name, username and password in the relevant fields of these lines, i.e. between the quotes.

Step-5, save the ``picasconfig.py`` file and for additional security set it to read-write (rw) access for you only

.. code-block:: bash

        chmod go-rw /home/<user>/picas_cfg/picasconfig.py

Check the permissions of your ``picasconfig.py`` file with ``ls -la``. The output should be similar to

.. code-block:: bash

        ls -la /home/<user>/picas_cfg/picasconfig.py
        -rw------- 1 <user> <user> 126 May  7 08:33 picasconfig.py

Step-6, add the ``picas_cfg`` directory to your PYTHONPATH environment variable so that python can locate it. We recommend that you set this variable in your /home/<user>/.bashrc file by adding the following lines to it:

.. code-block:: bash

        PYTHONPATH=/home/<user>/picas_cfg:$PYTHONPATH
        export PYTHONPATH

You are now ready to start using your PiCaS credentials without having to type them each time you or your jobs need to connect to the PiCaS server. An example of how this has been implemented is provided on our `Grid PiCaS`_ example page. For questions about the implementation on Spider please contact :ref:`our helpdesk <helpdesk>`.


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`


.. Links:
.. _`Grid Pilot Job`: http://doc.grid.surfsara.nl/en/latest/Pages/Practices/pilot_jobs.html
.. _`CouchDB`: http://couchdb.apache.org/
.. _`CouchDB book`: http://guide.couchdb.org/
.. _`Grid PiCaS`: http://doc.grid.surfsara.nl/en/latest/Pages/Practices/picas/picas_overview.html#picas-overview
.. _`PiCaS Grid documentation`: http://doc.grid.surfsara.nl/en/latest/Pages/Practices/picas/picas_example.html#picas-example
