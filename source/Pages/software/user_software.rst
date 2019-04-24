.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _user-software:

.. contents::
    :depth: 2

***********************
User installed software
***********************

.. _userspace-sw:

======================
Software on user space
======================

Software that does not require sudo rights or root privileges can be setup in
user-space. In order to make this software available on all nodes for your jobs
we advise you to place/compile such software in your globally mounted home
directory.

.. _user-sw-setup-sharing:

=================
Setup and sharing
=================

User installed software in the home directory can be shared amongst different
users by setting the appropriate user permissions on the installed software
directory and files. This can be done via the ``chmod`` command and help on this
commands can be found by typing ``man chmod`` on the command line after
:ref:`login <login>` into the system.

=========================================
Software installation as software manager
=========================================

As a part of project :ref:`environment <project-environment>`, you also have access to software space where software can be installed and shared with project members. Only dedicated software managers have permissions to write in this space, and all members in the project have read and execute permissions in this space. Below we provide an example of how to install software without root privileges with Miniconda and by building from source.

* Download and install the latest Miniconda2 package, which contains the conda package manager and python 2.7. The path shown below points to a path in the Software space of the project.

  .. code-block:: bash

     wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
     chmod +x Miniconda2-latest-Linux-x86_64.sh
     ./Miniconda2-latest-Linux-x86_64.sh -b -p /project/your-project/Software/Miniconda2


  Add the following line to export the following path in your $HOME/.bashrc

  .. code-block:: bash

     export PATH=/project/your-project/Software/Miniconda2/bin:$PATH 

  Logout and login for the changes to take effect. Run the following to install samtools with conda.

  .. code-block:: bash

     conda install samtools

If members in your project also wish to use the software installed by the software manager, all they need to do is export the paths as shown in the step above.

* Below is an example of installing samtools by building it from the source instead of using Miniconda2. The path shown below points to a path in the Software space of the project.

  .. code-block:: bash

     wget https://github.com/samtools/samtools/releases/download/1.3.1/samtools-1.3.1.tar.bz2
     tar -xf samtools-1.3.1.tar.bz2
     cd samtools-1.3.1  
     ./configure --prefix=/project/your-project/Software/samtools
     make
     make install

  Add the following line to export the following path in your $HOME/.bashrc

  .. code-block:: bash

     export PATH=/project/your-project/Software/samtools/bin:$PATH

  Logout and login for the changes to take effect.

If members in your project also wish to use the software installed by the software manager, all they need to do is export the paths as shown in the step above.


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

