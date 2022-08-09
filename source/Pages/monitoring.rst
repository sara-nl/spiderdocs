.. _monitoring-spider:
*****************
Monitoring Spider
*****************

There are two types of monitoring dashboards for :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`, a public section visible for everyone and a section visible only to authenticated Spider users.
Both are shortly described below. First some general properties and settings are covered. 

At the top of each of these dashboards is a time selection drop down to change the time range of the graph on the x-axis, along with a refresh button and timer.
Below are the actual properties of Spider being shown, which is either a single number of some property, for example current RAM usage, or a time-dependent graph of a property, for example CPU usage over time. If a panel has a legend, a single legend entry can be selected by clicking on it, and deselected by pressing it again.

Public
======

The public dashboard can be found `here <https://jobsview.grid.surfsara.nl/grafana/d/i289WluZz/spider?orgId=1>`_ and shows 4 views of running jobs, pending jobs, core usage and queue times for different projects.

User dashboards
===============

The shielded dashboards show information at three different levels, and can be found `here <https://monitor.spider.surfsara.nl/grafana/dashboards>`_.
There dashboards for authenticated users are 

 - Spider SLURM 
 - Spider Cluster overview
 - Spider Node exporter

 and are described below.

============
Spider SLURM
============

TODO: add after dashboards are updated by admins

This board shows SLURM job submissions and queue status for users.

=======================
Spider Cluster Overview
=======================

The cluster overview shows the general status of the nodes in Spider and for each of the machines it can be seen what the load and network traffic is over time.

====================
Spider Node exporter
====================

On this dashboard you can select at the top each machine in Spider under "host" and get a general overview at the top of the page, and below in different folds you can get very detailed information on the selected host.
This information ranges from CPU and memory usage to storage IO and disk usage to network traffic stats. There is a lot of information on this page for the interested user.



- Slurm dashboard -> replace this dashboard for normal users by the 'Spider user dashboard' and change the name of that one to 'SPIDER SLURM dashboard' to be more consistent with the names for the other SPIDER dashboards.
