.. _monitoring-spider:
*****************
Monitoring Spider
*****************

There are two types of monitoring dashboards for :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`, a `public section <https://jobsview.grid.surfsara.nl/grafana/d/i289WluZz/spider?orgId=1>`_ visible for everyone and a section visible only to `authenticated Spider users <https://monitor.spider.surfsara.nl/grafana/dashboards>`_.
Both are shortly described below. First some general properties and settings are covered. 

At the top of each of these dashboards is a time selection drop down to change the time range of the graph on the x-axis, along with a refresh button and refresh timer.
Below these buttons are the actual properties of Spider being shown, which is either a single number of a property, for example current RAM usage, or a time-dependent graph of a property, for example CPU usage over time. If a panel has a legend, a single legend entry can be selected by clicking on it, which filters out the rest. It can be deselected by pressing it again.

Public dashboard
================

The public dashboard can be found `here <https://jobsview.grid.surfsara.nl/grafana/d/i289WluZz/spider?orgId=1>`_ and shows 4 views of running jobs, pending jobs, core usage and queue times for different projects.

User dashboards
===============

The user dashboards show information at different levels, and can be found `here <https://monitor.spider.surfsara.nl/grafana/dashboards>`_.
The user dashboards include:

 - Spider SLURM 
 - Spider Cluster overview
 - Spider Node exporter

 and are described below.

============
Spider SLURM
============

This board shows at the top the general job submissions and pending jobs on SLURM, node status and CPU allocation. Next, the running and pending jobs are visible per project and per user. Finally, a section is shown containing per machine, the load, memory usage, disk usage and network IO traffic.

=======================
Spider Cluster Overview
=======================

The cluster overview shows the general status of the nodes in Spider and for each of the machines it can be seen what the load and network traffic is over time.

====================
Spider Node exporter
====================

On this very extensive dashboard you can select at the top each machine in Spider under "host" and get a general overview at the top of the page, and below in different folds you can see very detailed information on the selected host.
This information ranges from CPU and memory usage to storage IO and disk usage to network traffic statistics. There is a lot of information on this page for the interested user.
