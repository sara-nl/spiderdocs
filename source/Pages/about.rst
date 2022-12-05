.. _about:

*****
About
*****

.. Tip:: We welcome you to our new platform! In this page you will learn:

     * what :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` is all about
     * whether it is suitable for your research project
     * what are the collaboration options
     * how to obtain access and work within a :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` project


.. _spider-at-a-glance:

==================
Spider at a glance
==================

:abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` is a versatile high-throughput data-processing
platform aimed at processing large structured data sets. It runs on top of our
in-house elastic Cloud. This allows for processing on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` to scale from many
terabytes to even petabytes. Utilizing many hundreds of cores simultaneously
:abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` can process these datasets in exceedingly short timespans. Superb network
throughput ensures connectivity to external data storage systems.

Apart from scaling and capacity, :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` is aimed at interoperability with
other platforms. This interoperability allows for a high degree of integration
and customization into the user domain. :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` is further enhanced by specific
features supporting collaboration, data (re)distribution, private resources or
even private :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` instances.

Have a glance here of the main features offered by :abbr:`Spider (Symbiotic Platform(s)
for Interoperable Data Extraction and Redistribution)`:

.. image:: /Images/Spider_features.png
   :align: center

.. _platform-components:

===================
Platform components
===================

:abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`
is a feature-rich platform under continuous development. We keep adding new features to
the platform in order to meet the needs of researcher projects working with massive datasets.

:abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`
is built on powerful infrastructure and designed with the following components:

* Batch processing cluster (based on Slurm) for generic data processing applications
* Batch partitions to enable Single-core, Multi-core, Whole-node, High-memory and Long-running jobs
* Large CephFs data staging area (POSIX-compliant filesystem) scales to PBs without loss of performance or stability
* Large and fast scratch area’s (NVMe SSDs) on the worker nodes
* Fast network uplink (1200 Gbit/s) allowing for scalable parallel data transfers from other SURFsara based storage systems (e.g. dCache, SWIFT), or from external storage systems
* Role-based project spaces tailored for data-centric projects
* Scientific catalogs for cross-project collaboration
* Web access over HTTPS for public data distribution and sharing with external collaborators
* Singularity containers for software portability
* CVMFS/Softdrive support for software distribution
* Jupyter Notebooks
* Interactive jobs and direct visualization from within jobs
* Specific tooling for data-processing workflows
* Workflow management support
* Diverse authentication methods
* Private resources for special purposes (reservations, private nodes, private clusters)


.. _best-suited-cases:

=================
Best suited cases
=================

The best-suited cases for :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` are scientific projects with a requirement to process
relatively large data sets. For example research projects suitable for :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` that deal with massive datasets are commonly in:
Genomics, Proteomics, Earth observation, Astronomical observation, Climate modeling,
Engineering or Physics experiments.

You would be eligible for :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` if your project reflects some of the following needs:

* Processing of large amount of data of many terabytes to petabytes in short time spans
* Processing of large amount of independent simulations and workflows
* Interactive processing with user-friendly interfaces for efficient data handling
* Industry standard interfaces and other interoperability features
* Co-working with your collaborators on the same project-based workspace
* Accessing external storage facilities with fast connectivity

Also :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` is a viable alternative for current and potential
`Grid`_ users who are looking to use a more customizable system. It is a low-threshold platform,
as opposed to highly complex Grid platforms that take many months of specialist development
before they can start. Being built upon the exact same physical data-processing
infrastructure and sharing the same scalable network connectivity as the
Grid-based processing environments, :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` offers the same data-parallel processing
capabilities as the most powerful Grid platforms.

Note though that while it's great for data-intensive applications,
:abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` is *not* really aimed at:

* HPC applications where operations per second are critical
* Processing of simulations that require multi-node execution
* Applications that cannot be ported onto Linux-based system


.. _collaboration:

=============
Collaboration
=============

:abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` is designed for Big Science which requires
collaboration. :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` supports several ways to collaborate, either
within your project, across projects, or to external sources.

.. _project-space:

Project space
=============

Project spaces on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` are shared workspaces given to team members that enable collaboration through sharing data, software and workflows. Within your project space there are four folders:

* Data: Housing source data from data managers
* Share: For sharing between project members
* Public: For sharing publicly through webviews
* Software: Scripts, libraries and tools


:abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` enables collaboration for your project with granular access control to your project space through project roles, enabling collaboration for any team structure:

* *data manager* role: designated data dissemination manager; responsible for the management of project-owned data
* *software manager* role: designated software manager; responsible to install and maintain the project-owned software
* *normal user* role: scientific users who focus on their data analysis

.. _scientific-catalog:

Scientific catalog
==================

Collaboration is also possible across different :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` projects. These are cases where different user groups work
on projects with different scope and goals but need to (partly) share read-only data
(such as observations or biobank data). :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` offers a place for multiple project teams to
collaborate by sharing data sets or tools. This workspace is called *scientific catalog* and it is *not* offered by default to a project.

The scientific catalog data can be either *open* to everyone on the platform or *private* to
selected :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` project groups.

The scientific catalog has only one (but important) role:

* *scientific catalog manager*: designated data dissemination :abbr:`SC (scientific catalog)` manager; responsible for populating the catalog and deciding which :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)` project groups have read access to that catalog.


.. _  interoperability-hotspot:

Interoperability hotspot
========================

In contrast to many of the processing platforms already available,
typically offering an all-inclusive solution within the boundaries of the their
environment, :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` is exactly the opposite. It aims to be a connecting
platform in a world that has already a lot to offer in terms of storage systems,
data distribution and collaboration frameworks, software management and portability
systems, and pilot job and task management frameworks. The :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` platform can hook
them all together as an interoperability hotspot to support a variety of data
processing and data collaboration use cases.

For all external services supported, even services owned by the users themselves,
:abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` offers optimized configurations
and practical guidelines how to connect to these services together
into a practical processing environment tailored specifically to each project.


.. _project-lifecycle:

=================
Project lifecycle
=================

If you decided that :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` sounds suitable for your research project, then you
can apply to obtain access and start your project or join an existing one.

Starting a project
==================

For information about the granting routes on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` please see our `Proposals Page`_.

Before applying for a new project on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` we suggest you to contact :ref:`our helpdesk <helpdesk>` to discuss your project.

Extending a project
===================

You can apply for a time or resource capacity extension for an existing project on :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data
Extraction and Redistribution)` by requesting extra resources. Please see our `Proposals Page`_ or contact :ref:`our helpdesk <helpdesk>`.

Joining an existing project
===========================

If you are interested to join an existing project please contact our :ref:`our helpdesk <helpdesk>`.
Upon your request we will verify with the project PI whether we can give you access
to the project and what your project role would be.

Ending a project
================

Once your project ends, all the relevant data and accounts will be removed according to
the Usage Agreement terms and conditions.



.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`

.. _`Grid`: http://doc.grid.surfsara.nl
.. _`Proposals Page`: https://www.surf.nl/onderzoek-ict/toegang-tot-rekendiensten-aanvragen
