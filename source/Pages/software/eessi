.. _eessi:

*************
EESSI
*************


.. _eessi-repository:

===============
EESSI repository
===============

EESSI, short for the European Environment for Scientific Software Installations, is a collaborated project between different European partners in HPC community to build a common stack of scientific software installations for HPC systems and beyond. 
Through the EESSI project, a shared stack of scientific software installations is distributed via CVMFS. 

The official website of EESSI can be found in `EESSI website`_. To get an overview of all the available software in EESSI per specific CPU target, please check `EESSI available software`_.
Below we give instructions on how to make use of EESSI repository in Spider.


.. _eessi-basic-usage:

===============
Basic usage
===============

To access the EESSI software stack, first set up the EESSI environment by running the command:

.. code-block:: bash

  source /cvmfs/software.eessi.io/versions/2023.06/init/bash

You should be able to see the following output

.. code-block:: bash

  Found EESSI repo @ /cvmfs/software.eessi.io/versions/2023.06!
  archdetect says x86_64/amd/zen2
  Using x86_64/amd/zen2 as software subdirectory.
  Found Lmod configuration file at /cvmfs/software.eessi.io/versions/2023.06/software/linux/x86_64/amd/zen2/.lmod/lmodrc.lua
  Found Lmod SitePackage.lua file at /cvmfs/software.eessi.io/versions/2023.06/software/linux/x86_64/amd/zen2/.lmod/SitePackage.lua
  Using /cvmfs/software.eessi.io/versions/2023.06/software/linux/x86_64/amd/zen2/modules/all as the directory to be added to MODULEPATH.
  Using /cvmfs/software.eessi.io/host_injections/2023.06/software/linux/x86_64/amd/zen2/modules/all as the site extension directory to be added to MODULEPATH.
  Initializing Lmod...
  Prepending /cvmfs/software.eessi.io/versions/2023.06/software/linux/x86_64/amd/zen2/modules/all to $MODULEPATH...
  Prepending site path /cvmfs/software.eessi.io/host_injections/2023.06/software/linux/x86_64/amd/zen2/modules/all to $MODULEPATH...
  Environment set up to use EESSI (2023.06), have fun!
  {EESSI 2023.06} [xxxxx@ui-01 ~]$

The last line is the shell prompt where you can run your bash commands.

To check the available software modules, simply run command

.. code-block:: bash

  module avail

To find a specific software module, run command

.. code-block:: bash

  module spider python
  
You can directly load the modules that you need. For example, to load Python module

.. code-block:: bash

  module load Python/3.10.8-GCCcore-12.2.0


.. _eessi-job-script:

===============
Using EESSI software in a job script
===============

You can also use the EESSI software stack in a job script in Spider by inclduing the source command and loading the modules. Below is an example job script:

.. code-block:: bash

  #!/bin/bash
  #SBATCH -N 1
  #SBATCH -t 10:00
  #SBATCH -c 1
  #SBTACH -p normal
  
  # source the EESSI environment 
  source /cvmfs/software.eessi.io/versions/2023.06/init/bash

  # load the modules in EESSI
  module load matplotlib/3.7.0-gfbf-2022b
  module load Python/3.10.8-GCCcore-12.2.0

  # confim that EESSI repository is used
  echo "I am running on " $HOSTNAME
  var=$(which python)
  echo "I am using python in " $var

  # run the python work
  python /home/$USER/draw_a_plot.py

The draw_a_plot.py can be, for example:

.. code-block:: bash

  import numpy as np
  import matplotlib.pyplot as plt
  x = np.arange(0, 5, 0.1)
  y = np.sin(x)
  plt.plot(x, y)
  plt.savefig("output.jpg")

To view the result jpg and job output in your terminal, run commands

.. code-block:: bash

  display output.jpg
  cat slurm-job-id.out





.. Links:

.. _`EESSI website`: https://www.eessi.io/docs/
.. _`EESSI available software`: https://www.eessi.io/docs/available_software/overview/
