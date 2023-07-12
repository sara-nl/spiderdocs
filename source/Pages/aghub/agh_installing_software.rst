.. _agh_installing_software:

*********************************
Installation of software packages
*********************************

The AGH is a unique environment, as there is no direct internet connection.

In general, to install software, one can upload a package to the AGH through the 
research drive, and then install it using standard approaches. 

However, some software packages require large number of dependencies, which can be 
a hassle to install. Conda is a recommended method for installing such software
and its dependencies. However, this normally requires an active internet connection.

-----------------------------------------------
Install custom conda environments on the AGH
-----------------------------------------------

In :ref:`_agh_getting_started`, we describe how you can install a default conda environment
within your home directory by running the script `/project/aghub/Share/init/init.sh`.
This will contain many of the normally used software packages. However, if you need to
install additional software, you can use conda-pack to transfer a conda environment from
your local machine to the AGH. This is a convenient way to install software.


Steps:

1. Create a conda environment on your local machine. For example, you can create a conda environment
   with the name 'myenv' by running the command `conda create -n myenv`. 

2. Install the software packages that you need in this environment. For example, you can install
   the package 'numpy' by running the command `conda install numpy`.

3. Install conda-pack by running the command `conda install conda-pack`.

4. Pack the conda environment by running the command `conda pack -n myenv -o myenv.txz`. This will
   create a tarball file 'myenv.txz' that contains the conda environment.

5. Upload the tarball file to the AGH. You can do this by uploading the file to the research drive
   and then copying it to the AGH. For example, if you mounted the research drive on your local machine
   in the folder ~/rd, you can execute `cp myenv.txz ~/rd/` to copy the file to the research drive. 
   It should then immediately appear in the `~/rd` folder on the AGH.

6. Create a folder for your environment: `mkdir -p ~/envs/myenv`

7. Unpack the tarball file: `tar -xvf ~/rd/myenv.txz -C ~/envs/myenv`

8. Activate the environment: `conda activate ~/envs/myenv`

9. Run the command `conda-unpack` to finalize the installation.


-----------------------------------------------
Using Singularity to run software in containers
-----------------------------------------------
Singularity is a containerization software that allows users to run software packages
from an image file. It is similar to Docker, but is more suitable for HPC.
It is an alternative method for installing software packages on the AGH.


On AGH, we already have pre-built image that contains commonly used software packages.
To use this image, you can load the module and then run the image as a command. For example, 
to run the image as a bash shell, you can do:

.. code-block:: bash

    singularity shell /project/aghub/Share/images/conda.sif

This will modify your environment to include the conda environment. You can see this from the
modified shell prompt ('Apptainer>').  Now e.g. you can start ipython by running the command `ipython`. 


Alternatively, you can also directly  execute a specific command:

.. code-block:: bash

    singularity run /project/aghub/Share/images/conda.sif ipython

For more information on how to use Singularity, please refer to the `Singularity documentation <https://sylabs.io/guides/3.5/user-guide/index.html>`_.

Note that the use of singularity has one drawback: it does not allow you to run slurm commands from *within* the container.
Note that you can use execute software in a singularity image in your batch jobs,  however, you cannot run tools like snakemake 
from within the container to submit Slurm jobs. This is because the singularity image is not aware of the Slurm environment.





