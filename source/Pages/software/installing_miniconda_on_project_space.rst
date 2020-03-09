.. _installing-miniconda:

********************
Installing Miniconda
********************

* Download and install the latest Miniconda2 package, which contains the conda package manager and python 2.7. The path shown below points to a path in the Software space of the project.

.. code-block:: bash

     wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
     chmod +x Miniconda2-latest-Linux-x86_64.sh
     ./Miniconda2-latest-Linux-x86_64.sh -b -p /project/[PROJECTNAME]/Software/Miniconda2

* Add the following line to export the following path in your $HOME/.bashrc:

.. code-block:: bash

     export PATH=/project/[PROJECTNAME]/Software/Miniconda2/bin:$PATH

* Logout and login for the changes to take effect. Run the following to install samtools with conda:

.. code-block:: bash

     conda install samtools

All the members in your project can now use this software by exporting the paths as 
shown in the step above.
