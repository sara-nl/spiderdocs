.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _singularity:

.. contents::
    :depth: 2

***********
Singularity
***********

=============================
Containers on Spider
=============================

On Spider we support Singularity. Singularity is a container solution
for building software stacks in the form of images. Singularity enables these
images to be run in user space. We dot not provide a space for building
Singularity images, but we do support the execution of these images by users
on Spider.

The currently supported version of Singularity on Spider can be found
by typing ``singularity --version`` on the command line after
:ref:`login <login>` into the system. Additional information can be found
on the `Singularity SURFsara`_ page and more generic info can be found at 
the `Sylabs documentation`_.


.. _upload-singularity-image:

====================================
Upload your image to Spider
====================================

Your Singularity image can be viewed as a single file containing all the necessary software for your purpose. When compared to traditionally compiled software it is similar to a binary file containing the executable software. The image can be placed anywhere on Spider, as long as the location is accessible to your processing jobs. However, we strongly recommend that you place your Singularity images in one of the dedicated locations for user space software that are described on the `User installed software`_ page.  


.. _submit-singularity-job:

====================================
Submit a Singularity job on Spider
====================================

Regular jobs and Singularity based jobs are very similar. In many cases for your job submission script you simply add ``singularity exec`` in front of the commands to be executed within your job. However, please note that in some cases you may need to also use directory binding via the ``--bind`` option (see :ref:`bind-directories-singularity`). Below we provide an example comparing a regular job with a Singularity job.

Regular job on Spider:

.. code-block:: bash

        #!/bin/bash
        #SBATCH -n 1
        #SBATCH -t 10:00
        #SBATCH -c 1
        echo "Hello I am running a regular job using the software installed on the host system"
        echo "I am running on " $HOSTNAME
        python /home/<spider-user>/hello_world.py


Singularity job on Spider (in this example the image is placed in the home directory of the user):

.. code-block:: bash

        #!/bin/bash
        #SBATCH -n 1
        #SBATCH -t 10:00
        #SBATCH -c 1
        echo "Hello I am running a singularity job using the software installed in my image"
        echo "I am running on " $HOSTNAME
        singularity exec --pwd $PWD /home/<spider-user>/my-singularity-image.simg python /home/<spider-user>/hello_world.py


Please note that that the ``--pwd $PWD`` is recommended for use. This is because by default, Singularity makes the current working directory within the container the same as on the host system (Spider). For resolving the current working directory, Singularity looks up the physical absolute path (see ``man pwd`` for more info). However, some directories on Spider may be symbolic links and the current working directory would then resolve differently than expected. This would then result in your files not being where you expected them to be (combined with some warning messages).


.. _bind-directories-singularity:

====================================
Binding directories for a Singularity job
====================================

By default Singularity does not `see` the entire directory structure on Spider. This is because by default the file system overlap between the host system and the image is only partial. Additional directories can be made available by the user in severals ways: (i) You can create the directories within the image, see e.g. `Singularity SURFsara`_ (note that this requires sudo rights and thus needs to be done outside of Spider), or (ii) you can bind new directories at the time of execution via the ``--bind`` option. For binding directories it is only necessary to specify the top directory. Below we provide an example for binding the ``cvmfs`` directory. This is necessary if your Singularity image is distributed via `Softdrive`_.

Singularity job on Spider (in this example the image is placed in the Softdrive directory):

.. code-block:: bash

        #!/bin/bash
        #SBATCH -n 1
        #SBATCH -t 10:00
        #SBATCH -c 1
        echo "Hello I am running a singularity job using the software installed in my image on Softdrive"
        echo "I am running on " $HOSTNAME
        singularity exec --bind /cvmfs --pwd $PWD /cvmfs/softdrive.nl/<spider-user>/my-singularity-image.simg python /home/<spider-user>/hello_world.py

Please note that it is possible to bind several directories by providing a comma separated list to the ``--bind`` option, e.g. ``--bind /cvmfs,/project``. Additional information can be found in the `Sylabs documentation`_.


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`


.. Links:
.. _`Singularity SURFsara`: https://userinfo.surfsara.nl/systems/shared/software/Singularity
.. _`Sylabs documentation`:  https://www.sylabs.io/docs/
.. _`User installed software`: http://doc.spider.surfsara.nl/en/latest/Pages/software/user_software.html
.. _`Softdrive`: http://doc.spider.surfsara.nl/en/latest/Pages/software/user_software.html#softdrive
