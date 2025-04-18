.. _pilotjobspicas:

*************
Pilot jobs and PiCaS
*************


.. _pilot-jobs:

===============
Pilot job framework
===============

A common problem many users of HPC systems face nowadays is that with the number of jobs submmited to the job scheduler increasing, the overhead for managing these jobs becomes larger. 
Think of checking the status of all those jobs, finding out which jobs have succeed and which jobs need to be resubmitted.

Pilot job framework is a solution to this problem. Such framework starts by user submitting a number of pilot jobs to the job scheduler. These pilot jobs are unlike normal jobs which executes the task directly. 
Once a pilot job is running on the work nodes, it will contact a central server to be assigned a task and get all the information needed for executing this task. 
Once the assigned task is finished, the pilot job will report the successful completion and request a new task.
In the meantime, the central server handles the request from pilot jobs and keeps a log of what tasks are being handled, are finished, and can still be handed out. 
When the task server doesn’t hear about the progress or completion of a task it has distributed, it will assume the pilot job is either dead or the job has failed. 
As a result, the task will be automatically reassigned to another pilot job which equals to job resubmission. 

Besides reducing the overhead for job management including tracking and resubmission, the pilot job framework also has the advantage of minimizing data transfer workload to the work nodes if many jobs works on the same datasets.

The picture below illustrates the workflow of pilot job systems: 
(1), the user uploads work to the central database. This could be a list of parameter settings that need to be executed using some application on a computational resource. 
The user then (2) submits jobs just containing the application to the compute cluster or serve, which handles retrieving from (3) and updating of (4) the job database. 
This process continues until all the work present in the database has been done, the application has crashed or the job has run out of time on the computational resource. 
When all work has been done, the user retrieves (5) the results from the database.


.. image:: /Images/pilot_job.png
   :align: center


.. _picas:

===============
PiCaS
===============

PiCaS is a pilot job system where PiCaS server use tokens to communicate tasks with PiCaS clients on the worker nodes.


.. _token:

Token
==========================

A token describes an individual task which needs to be processed. 
Tokens can contain any kind of information about a task: (a description of) the work that needs to be done, output, logs, a progress indicator etc.

.. _picas_source_code:

PiCaS source code
==========================

The source code of PiCaS is on `Github Picas Client`_.

.. _picas_server:

PiCaS server
==========================

PiCaS server, also called a Token Pool Server, is the central repository for the tasks. The PiCaS server is based on  CouchDB, 
a NoSQL database, and the client side is written in Python.
On the server side we have a queue which keeps track of which tokens are available, locked or done. 
This allows clients to easily retrieve new pieces of work and allows also easy monitoring of the resources. 
As every application needs different parameters, the framework has a flexible data structure that allows users to save different types of data. 

.. _picas_client:

PiCaS client
==========================

The PiCaS client library was created to ease communication with the CouchDB back-end. It allows users to easily upload, fetch and modify tokens. 
The system has been implemented as a Python Iterator, which means that the application is one large for loop that keeps on running as long as there is work to be done. 
The client is written in Python and uses the python couchdb module, which requires at least python version 3.


.. _picas_example:

PiCaS example
==========================

For PiCaS pilot job examples, please check `PiCaS example`_.


.. _picas_access:

Request access to PiCaS
==========================

Any user with a project on the system and allocated quotas can get a PiCaS account and also obtain a database on the CouchDB server. 
If you want to request access, just contact us at helpdesk@surfsara.nl to discuss your design implementation and request your PiCaS credentials.

.. Links:

.. _`Github Picas Client`: https://github.com/sara-nl/picasclient/
.. _`PiCaS example`: https://github.com/sara-nl/picasclient/
