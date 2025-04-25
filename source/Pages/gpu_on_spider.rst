.. _gpu-on-spider:

*****************
GPUs on Spider
*****************

.. Tip:: This is a quickstart for using GPUs. In this page you will learn:

     * how to access GPU nodes
     * how to build and run a singularity container that:

        * uses GPUs
        * runs CUDA code
        * runs python code
        * runs jupyter notebooks

===============
Using GPU nodes
===============

To run your program on GPU nodes some guidelines for the user have to be taken into account. Firstly, GPUs and their drivers are only available on the GPU nodes ``wn-ga-[01-02]`` and ``wn-gb-[01-05]`` and **not** on the UI nodes. 


To *interactively* log in to a GPU node run:

.. code-block:: bash

   srun --partition=gpu_a100_7c --time=00:60:00 --gpus=a100:1 --pty bash -i -l

This will open a bash session on a machine in the ``gpu_a100`` partition for 60 minutes.

.. tip::

   Asking for more GPUs than the total available on a node does not give an error, your jobs will run on the maximum number.


All GPU nodes run Nvidia hardware and the CUDA drivers are available on the GPU nodes. Other GPU software needs to be obtained and deployed by the user. We suggest users to :ref:`create <singularity-building>` or make use of `pre-build Singularity containers <https://catalog.ngc.nvidia.com/containers>`_. The Spider team can provide assistance to users who are not familiar with container. In this case please submit your request for assistance via our :ref:`our helpdesk <helpdesk>`.

In case the version number of the drivers has to be known, the user can find the version number and other information on the GPU hardware with:

.. code-block:: bash

   srun -p GPU_PARTITION --gpus GPU:N_GPUS nvidia-smi

where the GPU_PARTITION is either ``gpu_a100_22c`` or ``gpu_a100_7c`` depending on which one you are planning to use. The ``gpu_a100_7c`` partition has an AMD CPU with 7 cores, while the ``gpu_a100_22c`` has an Intel with 22 cores per GPU. Both partitions have the exact same A100 cards. The ``--gpus`` flag specifies which type of GPU you want to use and how many, you will get ``N_GPUS`` up to the maximum in the cluster of type ``GPU`` which is ``a100``. 

The compilation and running of code is recommended to be done inside of a singularity container, so start by building a singularity image. More information on singularity on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` can be found at :ref:`singularity containers <singularity-containers>`. Once the container is available, the program can be run.

Next, some short examples for building and running commands are shown. A more in-depth container build procedure is shown :ref:`here <singularity-building>`.


Simple building example
=======================

Building can be done as follows:


.. code-block:: bash

   singularity build ubuntu.sif docker://ubuntu

In this example, the latest stable version of ubuntu is used (found `here <https://hub.docker.com/_/ubuntu>`__). For running libraries like tensorflow or pytorch or CUDA tools, please create or obtain appropriately compiled containers. A few links to more resources are given :ref:`here <resources-singularity>`.

After the singularity image has been sucessfully built, the user can enter a shell in the container with:

.. code-block:: bash

   singularity shell --nv ubuntu.sif

In the shell, commands can be run which are executed in the container environment. You can also run a command directly in the container and get the output using ``exec``.

.. code-block:: bash

   singularity exec --nv ubuntu.sif echo "hello world"

.. WARNING::
   The ``--nv`` flag is necessary to expose the GPUs on the host to the container.

Here follows an example for running the container in batch mode with a shell script. Start by making a file called ``script.sh`` containing:

.. code-block:: bash

   #!/bin/bash

   #SBATCH -p gpu_v100
   #SBATCH -G v100:1
   #SBATCH -e slurm-%j.out
   #SBATCH -o slurm-%j.out

   singularity exec --nv ubuntu.sif echo "hello world"

The flags ``-e`` and ``-o`` instruct SLURM in which files to write respectively *stderr* and *stdout* of the job. In this case they are both sent to the same file, this is done for comparison in the next step. If you now run this shell script on the ``ui-[01-02]`` nodes with ``bash script.sh``, it will result in:

.. code-block:: bash

   INFO:    Could not find any nv files on this host!
   hello world

as the UI nodes do not have access to GPUs and thus do not have an nv file to point the container to the required libraries. Running the script in batch mode with ``sbatch script.sh``, the ``-p`` flag is used, and the job ends up on a GPU node. The output becomes:

.. code-block:: bash

   hello world

Of course, this ubuntu image does not have any of the tools needed to build GPU-native code or libraries that can run on the GPU. Refer to :ref:`this section <resources-singularity>` for more resources and :ref:`this section <cuda-example>` for an example.

.. tip::

   While you do not get the warning about finding the nv file when using the ``--nv`` flag, you also have to specify the name of the GPU to use, otherwise none are allocated to you! This can be done with the ``--gpus`` or ``-G`` flag, as can be seen in the example shell script. 

Now you are ready to build on top of a base container and run your code on a GPU!

.. _accounting-gpu:

Accounting of GPU usage
=======================

Currently the usage of GPU nodes is accounted for in GPU hours. This means that even though multiple cores are used simultaneously, one hour of use of a GPU node is billed as 1 GPU-hour. By default, half the CPU cores of the node (22) are used when you use half of the available GPUs. When using GPUs the CPU cores are not counted and fall under the GPU hours. In contrast to generic CPU use in a 'regular' job, where one hour of multi-core usage is billed as multiple CPU hours, depending on the number of cores. 


.. _singularity-building:

============================================
Building and running a singularity container
============================================

In this section we show how to build a singularity container use it to run code in its environment. There is extensive documentation from singularity itself `here <https://docs.sylabs.io/guides/latest/user-guide/index.html>`__. 

The steps in this section are done on GPU nodes, to ensure availability of the drivers, which may be needed in some compilation steps.

Building directly from dockerhub
================================

There are multiple ways to build a container. To build directly from docker hub, for example the latest version of tensorflow, one can invoke:

.. code-block:: bash
   
   singularity build --nv tf_latest.sif docker://tensorflow/tensorflow:latest

and the image ``tf_latest.sif`` from `dockerhub <https://hub.docker.com>`_ will be built, containing the contents of the latest ``tensorflow`` image from the makers of tensorflow. The docker image is converted by singularity to a singularity container. You can also get an image from a different source, such as the Nvidia container repository:

.. code-block:: bash

   singularity build --nv nvidia-tf.sif docker://nvcr.io/nvidia/tensorflow:22.07-tf2-py3

An Nvidia image contains all the necessary prerequisites to run on Nvidia GPUs, which is preferable on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`. The tag on the docker image in this case refers to the build release date, the tensorflow version and the python version: july 2022, TF v2, python3.

To directly run the container in memory without writing an image to disk invoke:

.. code-block:: bash

   singularity run --nv docker://nvcr.io/nvidia/tensorflow:22.07-tf2-py3

In the examples below, the base images are taken from the internet and expanded upon using *definition* files, to build custom singularity containers. The singularity documentation on definition files can be found `here <https://docs.sylabs.io/guides/latest/user-guide/quick_start.html#singularityce-definition-files>`__.

.. _cuda-example:

Running CUDA code 
=================

Here, we show the method of using a *definition file*, as opposed to above, where directly building from a repository is shown. A definition file contains the steps that are followed during the building of the container and steps that are performed when, for example, ``singularity run`` is called. The contents of the definition file are shown before these contents are explained. Start by making the file called ``cuda_example.def`` and add all the steps we want to take to make a container:

.. code-block:: bash
   
   Bootstrap: docker
   From: nvidia/cuda:11.7.0-devel-centos7

   %post
   #This section is run inside the container 
   yum -y install git make
   mkdir /test_repo
   cd /test_repo
   git clone https://github.com/NVIDIA/cuda-samples.git
   cd /test_repo/cuda-samples/Samples/2_Concepts_and_Techniques/eigenvalues/
   make

   %runscript
   #Executes when the "singularity run" command is used
   #Useful when you want the container to run as an executable
   cd /test_repo/cuda-samples/Samples/2_Concepts_and_Techniques/eigenvalues/
   ./eigenvalues

   %help
   This is a demo container to show how to build and run a CUDA application
   on a GPU node

This container will take a base image from `docker-hub <https://hub.docker.com/>`_ and use a pre-built `nvidia/cuda <https://hub.docker.com/r/nvidia/cuda>`_ container of a specific version. This container also contains the necessary CUDA tools to compile binaries that run on GPUs. After starting from this base-image, in the next steps some tools are installed, directories are created and filled with a git repository. From this repository a single example of a CUDA applictation is compiled. When running the container on the command line, this application is run automatically.

Now that we have the definition file, we can build the singularity image with:

.. code-block:: bash
   
   singularity build --fakeroot --nv --sandbox cuda_example.sif cuda_example.def

In this command some flags are used, these and more are explained in the table below.

===============   ======================================================================================
Flag              Functionality         
===============   ======================================================================================
``--fakeroot``    raises permissions inside the container to ``sudo``, necessary for installing packages
``--nv``          exposes the nvidia drivers of the host to the container (makes them available)
``--sandbox``     allows the final container to be changed in *write-mode*, should only be used for debugging!
``--writable``    allows writing into a sandboxed container when invoking ``singularity shell``
===============   ======================================================================================

``--fakeroot`` was needed for installing ``git`` and ``make`` in the container, as of 2024 it is not strictly necessary. ``--nv`` is necessary to access the GPU from within the container, and ``--sandbox`` is used to allow the user after running this example to go into the container and make changes to folders, files or run other commands that change the state of the container. If container ``--fakeroot`` building permissions are not enabled for you on the GPU nodes, please contact us at :ref:`our helpdesk <helpdesk>`.

Once the container is built - which can take a few minutes as multiple base containers have to be retrieved from the internet - you can run it using 

.. code-block:: bash

   singularity run --nv cuda_example.sif

which will output the result of the *eigenvalues-test*, as was instructed in the definition file under ``%runscript``. To run commands from within a shell in the container that allow for making changes, do

.. code-block:: bash

   singularity shell --nv --writable cuda_example.sif

The container was exposed to the GPU at build-time, and at run-time it also has to be exposed with ``--nv``, otherwise it can not find the drivers! In case the container is still under development and needs debugging, use the ``--writable`` flag so that missing packages/libs can be added to the container at runtime. These packages have to be added in the definition file for the final singularity build.

.. tip::
  
   Only use ``--sandbox`` and ``--writable`` when developing the image. Once the build is settled, create the container with a definition file and distribute it as-is for maximum stability.

There is also a full HPC development image made available by Nvidia, called "HPC SDK", which is the software development kit that contains all the compilers, libraries and tools necessary to build efficient code that runs on GPUs. This image can be found `here <Https://catalog.ngc.nvidia.com/orgs/nvidia/containers/nvhpc>`__.

Running python
==============

Popular python interfaces for modelling are tensorflow, keras, pytorch, and more. An example for using tensorflow in singularity is provided below, but some warnings have to be taken into account, due to the default behaviour of singularity with the host machine. 

Starting on a machine in the GPU partition, we create a definition file ``nv-tf-22.07.def`` containing:

.. _nv-tf-22.07:

.. code-block:: bash

  Bootstrap: docker
  From: nvcr.io/nvidia/tensorflow:22.07-tf2-py3

  %post
  cd /tmp
  git clone https://github.com/tensorflow/docs
 
  %runscript
  cd /tmp/docs/site/en/tutorials/keras
  python
 
  %help
  This is a demo container to show how to run tensorflow in python

and build the container using the usual 

.. code-block:: bash

   singularity build --nv nv-tf-22.07.sif nv-tf-22.07.def

In this definition file, the tensorflow docs and tutorials are installed as an example to show how to do it. 

.. WARNING::
   Running ``pip`` inside the container using ``singularity shell`` when it is in ``--writable`` mode will write the python libraries to the default **mounted** location. This location is the ``$HOME``-folder of ``$USER``. As such, pip packages will end up on the host machine and not in the container. To avoid this behaviour, only run ``pip`` during the building of the image in the definition file, or change the mounting behaviour of singularity when entering the shell. For example, mount the local path of your project as working directory as the ``$HOME`` in the container. 

   For information on this, read ``man singularity-shell`` and `bind mounts <https://singularity-userdoc.readthedocs.io/en/latest/bind_paths_and_mounts.html>`_.

.. WARNING::
   As the home folder is mounted by default in singularity, and python searches certain folders by default, it is possible that inside the container packages from the host machine are called, instead of what is inside the container. For example, the ``~/.local`` folder on the host machine can have precedence over site-packages in the container. To avoid errors from mounting or binding at all, use the flags ``--no-home`` or ``--no-mount=[]``. If errors appear relating to CUDA ``.so`` files, or versions of packages are mismatching, ensure that the user-space is not accidentally providing libraries to the container.

.. tip::
   Use singularity only to control the versioning of the environment and encapsulate your libraries in the container and thus control their versioning. Code and data files can be fed to singularity, so keep such files external to the container.


The example we are about to execute in the container comes from the tensorflow library: `classifying pieces of clothing <https://www.tensorflow.org/tutorials/keras/classification>`_. Now create a file to run ``fashion.py``, set it to executable with ``chmod 755 fashion.py`` and add the following:

.. _fashion:

.. code-block:: python

  #!/usr/bin/env python

  # TensorFlow and tf.keras
  import tensorflow as tf

  # Helper libraries
  import numpy as np
  import matplotlib.pyplot as plt

  print(tf.__version__)

  fashion_mnist = tf.keras.datasets.fashion_mnist

  (train_images, train_labels), (test_images, test_labels) = fashion_mnist.load_data()

  class_names = ['T-shirt/top', 'Trouser', 'Pullover', 'Dress', 'Coat',
                 'Sandal', 'Shirt', 'Sneaker', 'Bag', 'Ankle boot']

  train_images = train_images / 255.0
  test_images = test_images / 255.0

  model = tf.keras.Sequential([
      tf.keras.layers.Flatten(input_shape=(28, 28)),
      tf.keras.layers.Dense(128, activation='relu'),
      tf.keras.layers.Dense(10)
  ])

  model.compile(optimizer='adam',
                loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
                metrics=['accuracy'])

  model.fit(train_images, train_labels, epochs=10)

  test_loss, test_acc = model.evaluate(test_images,  test_labels, verbose=2)
  print('\nTest accuracy:', test_acc)

  probability_model = tf.keras.Sequential([model,
                                           tf.keras.layers.Softmax()])

  predictions = probability_model.predict(test_images)
  print(predictions[0])

This example will create a model that recognizes the clothes in a picture, and a prediction of a set of test images is done at the end. The result can be compared to the `official example <https://www.tensorflow.org/tutorials/keras/classification>`_. The matplotlib output is omitted in this example for simplicity. This output can be seen in the section on :ref:`jupyter notebooks <jupyter-notebooks>`.

Now this code can be run on a GPU node with:

.. code-block:: bash

   singularity exec --nv nv-tf-22.07.sif ./fashion.py

Or run it interactively on a GPU node in the container line-by-line with:

.. code-block:: bash

   singularity shell --nv nv-tf-22.07.sif 

If there is an output in the terminal running the python code similar to:

.. code-block:: bash

   2022-07-29 11:53:24.017428: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1532] Created device /job:localhost/replica:0/task:0/device:GPU:0 with 30987 MB memory:  -> device: 0, name: Tesla V100-PCIE-32GB, pci bus id: 0000:00:06.0, compute capability: 7.0

this means the GPU is being used for your computations.

Also, by wrapping the singularity command in a shell script called ``fashion.sh`` and adding the appropriate ``#SBATCH`` commands at the top, the script can be submitted to the batch system with ``sbatch fashion.sh``. The script would look like:

.. code-block:: bash

   #!/bin/bash
   
   #SBATCH -p gpu_v100
   #SBATCH -G v100:1
   
   singularity exec --nv nv-tf-22.07.sif ./fashion.py


.. _jupyter-notebooks:

Running jupyter notebooks
=========================

Many users prefer working in interactive notebooks during development of their models. Here an example is shown of running tensorflow in a jupyter notebook. There is also a more general section in this documentation on jupyter notebooks :ref:`here <jupyter-notebook-section>`.

.. tip::
   Make sure you use the GPU version and not the CPU version of your software in the container.

We start with the image from the :ref:`previous subsection <nv-tf-22.07>`, the tensorflow container from the Nvidia repository with the added examples: ``nv-tf-22.07.sif``. This image also contains jupyter by default.

.. code-block:: bash

   ssh USERNAME@spider.surfsara.nl
   srun --partition=gpu_v100 --gpus v100:1 --time=12:00:00 --x11 --pty bash -i -l
   singularity shell --nv nv-tf-22.07.sif

where USERNAME is your username and the partition is a GPU partition, like ``gpu_v100``, ``gpu_a100_7c`` or ``gpu_a100_amd_22c`` depending on your project. The ``singularity shell`` command is needed to start jupyter from the command inside the container. The tutorials were cloned during the building of the image. The container is read-only, and some of the examples will require to download and store some files. To have writing functionality available for the examples, build the image with ``--sandbox`` and run it with ``--writable``, as mentioned in :ref:`this section <cuda-example>`.

Start the notebook with:

.. code-block:: bash

   cd /tmp/docs/site/en/tutorials/keras
   jupyter notebook --ip=0.0.0.0

The python output will return an address like ``http://127.0.0.1:8888/?token=abc123``. Opening this address in your browser will give you access to the notebook, but only if there is a tunnel that forwards the jupyter kernel to your machine. Now, we have open a tunnel to forward the port on which the python kernel communicates to the local machine where the user works. In this way, the notebook can be openened in the browser:

.. code-block:: bash

   ssh -NL 8888:wn-gp-01:8888 USERNAME@spider.surfsara.nl

where USERNAME is your username and ``wn-gp-01`` should changed to the node on which the python kernel is running. This tunneling command has to be running in **a separate terminal**, and ensures the communication from port 8888 (right hand side) on the remote machine is forwarded to port 8888 (left hand side) on the local machine. The port that is given when you start the jupyter notebook defaults to 8888, but if it is already in use, the value will be different. The used value can be seen in the jupyter output in the terminal.

Now you can run an example from the ``keras`` folder by going to the http-address provided by jupyter.

.. WARNING::
   Some jupyter instances provide a link of that contains ``hostname:8888``. Replace ``hostname`` with ``localhost`` or ``127.0.0.1`` to properly fetch the notebook.

The terminal will now have CUDA output, while the notebook contains all the python and graphical output. Again, if there is an output in the terminal running the notebook similar to:

.. code-block:: bash

   2022-07-29 11:53:24.017428: I tensorflow/core/common_runtime/gpu/gpu_device.cc:1532] Created device /job:localhost/replica:0/task:0/device:GPU:0 with 30987 MB memory:  -> device: 0, name: Tesla V100-PCIE-32GB, pci bus id: 0000:00:06.0, compute capability: 7.0
 
this means the GPU is being used for your computations. Now you can run the classification (fashion) notebook and compare with the output of the `repository <https://www.tensorflow.org/tutorials/keras/classification>`_ to see if you get similar results.

Advanced GPU querying
=====================

Some of the GPU nodes in spider have multiple GPUs installed. This opens up the avenue where multiple users use the same node simultaneously. Here are some more advanced commands to explore a few options.

To get one GPU and leave the other GPU on the node available for other users, do:

.. code-block:: bash

   srun -p gpu_a100_22c --gpus=a100:1 --pty bash

To run on 2 GPUs simultaneously and have no other users on the nodes do:

.. code-block:: bash

   srun -p gpu_a100_22c --nodes=1 --exclusive --gpus=a100:2 --pty bash

.. WARNING::
   Do not request multiple GPUs unless you are sure your code can run on multiple GPUs. If you need exclusive acces to the node, use the ``--exclusive`` flag.

By default, half the cores of the node (22) are used when you use 1 out of 2 GPUs. To use only a single CPU core while using GPU do:

.. code-block:: bash
   
   srun -p gpu_a100_22c --cpus-per-task=1 --gpus=a100:1 --pty bash

For more information read the `man-pages of SLURM <https://slurm.schedmd.com/man_index.html>`_.

.. _resources-singularity: 

Resources on singularity and containers
=======================================

| https://docs.sylabs.io/guides/latest/user-guide/
| https://hub.docker.com/r/nvidia/cuda
| https://catalog.ngc.nvidia.com/
| https://gpucomputing.shef.ac.uk/education/creating_gpu_singularity

.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`
