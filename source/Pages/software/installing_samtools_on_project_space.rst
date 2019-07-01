.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _installing-samtools:

*******************
Installing samtools
*******************

Here is an example of installing samtools by building it from the source instead of
:ref:`using Miniconda2 <installing-miniconda>`.

* Download the samtools packages in the Software space of the project:

.. code-block:: bash

     wget https://github.com/samtools/samtools/releases/download/1.3.1/samtools-1.3.1.tar.bz2
     tar -xf samtools-1.3.1.tar.bz2
     cd samtools-1.3.1
     ./configure --prefix=/project/your-project/Software/samtools
     make
     make install

*  Add the following line to export the following path in your $HOME/.bashrc:

.. code-block:: bash

     export PATH=/project/[PROJECTNAME]/Software/samtools/bin:$PATH

*  Logout and login for the changes to take effect.

All the members in your project can now use this software by exporting the paths as
shown in the step above.
