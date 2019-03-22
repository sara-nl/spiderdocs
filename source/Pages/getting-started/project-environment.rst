.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _project-environment:

.. contents::
    :depth: 2

********************
Project environment
********************

Each user on Spider is a part of a project, and each user gets access to the following services through their project:  

1. Login node: This is your entry and access point to Spider. From this node you can submit jobs, transfer data and prototype your application. It has a software environment very similar to the worker nodes where your submitted jobs will run. As the ``/home/$USER`` directory, which is where you land when you login, is accessible from all worker nodes it is a suitable place to port your software to (also see :ref:`os-version`).  

2. Project storage space: A member within a project can be either have the role of "project-admin" or a "project-user". A project is allocated several 'storage spaces' that can be easily accessed with simple linux commands e.g., cp. These 'storage spaces' are described below: 

* ``/home/$USER``: Each member in a project will have her/his own /home/$USER space.  

* ``/project/your-project/Data``: This is a storage allocation that allows read access to every "project-user" associated with the project, and read and write access to the "project-admin" of the project. 

* ``/project/your-project/Shared``: This is a storage allocation that allows read and write access to all members associated with the project. 

* ``/project/your-project/Public``: This is a storage allocation that allows read access to all members using Spider. 

.. 3. Compute: which partitions and nodes are available be default?

 4. Software: cvmfs a standard service by default or only upon request

 5. Extra services: If the above are not default, these can be listed as extra services avaialable upon request. Also to decide - reservations, courses, etc.


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`


