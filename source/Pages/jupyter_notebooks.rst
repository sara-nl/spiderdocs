.. _jupyter-notebook-section:
*****************
Jupyter Notebooks
*****************

.. Tip:: Jupyter notebooks are very popular in science for interactive work. In this page you will learn:

     * how to use Jupyter notebooks on Spider
     * which available flavors to choose

Two methods of running jupyter notebooks in jupyter lab are discussed here: with virtual environments and with singularity containers. Some of this has also been covered in :ref:`the compute section <compute-on-spider>`.

======================
Where to run notebooks
======================

Interactive notebooks should be run on the worker nodes mentioned in :ref:`prepare-workloads` and **not** on the UI machines. Building the environments and containers can be done on the UI, but once you start to run your code, please connect to a machine interactively with:

.. code-block:: bash

   srun --partition=short --time=12:00:00 --pty bash -i -l

Which will open an interactive session on a machine in the short partition for 12 hours. In this way, the other users on the UI machines will not be disadvantaged by resources being used up by the notebook users.

.. WARNING:
   If all resources (worker nodes in the selected partition) are in use, the ``srun`` command will hang until the resource becomes available. 


===================
Virtual environment 
===================

Starting with python *virtual environments* called a ``venv``, these are a contained python environment you can create and load that has all the python modules and packages installed that the user needs. This ensures no componentes leak into the system environment. 

You can create a virtual environment (or venv) at a path by doing:

.. code-block:: bash
   
   python3.9 -m venv test_venv/

This will create a folder called ``test_venv`` which contains the entire python environment. You can also use other python versions if you prefer. To load this environment run:

.. code-block:: bash
   
   source test_venv/bin/activate

This will show in some shells a ``(test_venv)`` next to your command line. In the environment you can now install packages using pip:

.. code-block:: bash
   
   pip install jupyterlab pandas docopt

To start a jupyter session, run

.. code-block:: bash
   
   jupyter lab --ip="*" --no-browser

Where the ``ip`` flag and the ``no-browser`` respectively ensure that the session is forwarded through the network and that no browser is opened in an ``X11`` session that may be running through your ``ssh`` connection.

To properly forward the lab session to your local machine, a second terminal has to be opened running:

.. code-block:: bash
   
   ssh -NL 8888:wn-db-06:8888 spider

where the machine name has to match where the kernel is running (``wn-db-06`` has to match) and the forwarded port (in this example ``8888``) has to match the port given by the jupyter-lab instance. Again, **do not run notebooks on UI machines**. Now that the tunnel is opened and should forward the connection to your browser, open the link provided by jupyter in your favorite browser. The link has the shape ``http://localhost:8888/lab?token=abc123``.

Once you are done with the virtual environment and want to go back to the inital user environment type:

.. code-block:: bash

   deactivate

and the python environment is unloaded. To reload the environment again do:

.. code-block:: bash

   source test_venv/bin/activate

.. WARNING::
   Some jupyter instances provide a link of that contains ``hostname:8888``. Replace ``hostname`` with ``localhost`` or ``127.0.0.1`` to properly fetch the notebook.

=====================
Singularity container
=====================

Pre-built container
===================

To run a notebook in a singularity container, we have to fetch or build the container first. A tutorial on containers can be found in :ref:`singularity-building`, but note that this particular example focuses on using GPUs. A more general introduction is provided here.

First we start by fetching a container:

.. code-block:: bash

   singularity build jupyter.sif docker://jupyter/scipy-notebook:latest

This will pull one of the official jupyter containers from docker hub, and build a singularity container from it. This container encapsulates the entire environment and can be entered to start a notebook session. Supported jupyter containers can be found `here <https://hub.docker.com/r/jupyter/>`_, and more docker images in general can be found at `docker hub <https://hub.docker.com/>`_.

After the build procedure is complete, you can start the jupyter instance on a worker node (**not** a UI) with 

.. code-block:: bash

   singularity run jupyter.sif

which will automatically start the instance. Alternatively, you can start an interactive shell session in the container and start it manually:

.. code-block:: bash

   singularity shell jupyter.sif
   jupyter lab

To receive the notebook locally in your browser, as mentioned above, a tunnel has to be opened in a new terminal, with:

.. code-block:: bash
   
   ssh -NL 8888:wn-db-01:8888 spider

Where, again, the machine name and port name have to match where you are running the job and the port chosen by jupyter, respectively. Now you can open the link provided by jupyter, which has the shape of ``http://localhost:8888/lab?token=abc123``.

.. tip:
   
   To have a folder on the host machine available in your container (such as ``/project/``), use the following flag ``--bind /src/path:/dest/path`` to make ``/src/path`` available in the container at ``/dest/path``. But beware: this flag has to be put **before the container name** in the command.

If the forwarding or other steps do not work, please contact :ref:`our helpdesk <helpdesk>`.

Custom image
============

Singularity images can be customised to suit your needs, by adding extra steps during the build process. This is done with so-called 'definition' files. These are plaintext files with instructions for the singularity build. For a full overview, see the `singularity documentation <https://docs.sylabs.io/guides/latest/user-guide/definition_files.html>`_. Here is a small example of a custom image that can be expanded. This example also has `docopt` installed during installation, and calling the ``singularity run`` command opens the container and starts the notebook instance for you. Make a file called ``jup-custom.def`` and fill it with:

.. code-block:: bash

   Bootstrap: docker
   From: jupyter/scipy-notebook:latest

   %post
     pip install docopt

   %runscript
     jupyter lab --ip=0.0.0.0

   %help
     This is a demo container to show how to run jupyter lab 

You can build this with:

.. code-block:: bash

   singularity build jup-custom.sif jup-custom.def

and once it is finished building, you can enter the `sif` file with the ``singularity shell`` command, or start jupyter directly with ``singularity run``. You still have to forward the connection as described above before you can open the notebook in a browser. To save your notebook, in the browser you can use `Save As` from the menu. For more information on running jupyter lab and notebooks, see the `official jupyter documentation <https://docs.jupyter.org/en/latest/>`_.

To get a full overview of what is possible during building in terms of installing packages, raising permissions, setting paths, mounting local folders and more, see the `official singularity documentation <https://docs.sylabs.io/guides/latest/user-guide/definition_files.html>`_.

Notebook resources
==================

A few resources on prebuilt images and documentation:

| https://hub.docker.com
| https://docs.sylabs.io/guides/latest/user-guide/

.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`
