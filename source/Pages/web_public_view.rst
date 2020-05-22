.. _web-public-view:

***************
Web public view
***************

.. Tip:: Web public views are meant for open data distribution. In this page you will learn:

     * how to distribute public data through a web view
     * about risks when publishing data


:abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`
allows for public data sharing in a fast and easy way, which is often a huge problem
in other platforms. In a web-based front-end, the so called *web public view*,
you can give direct access to external collaborators in selected directories
containing designated data products.

But how does this work?

Let's say that you have run some analysis on :abbr:`Spider (Symbiotic Platform(s)
for Interoperable Data Extraction and Redistribution)`
and you want to redistribute some scientific products or intermediate results to
collaborators that are not members of your :abbr:`Spider (Symbiotic Platform(s)
for Interoperable Data Extraction and Redistribution)` project, thus they don't have
access to your :ref:`project space <project-space-fs>`. Here is what you need to do:

* Login to  :abbr:`Spider (Symbiotic Platform(s) for Interoperable Data Extraction and Redistribution)`, select the files that you want to publish and copy them to your project space ``/project/[PROJECTNAME]/Public`` directory, e.g.:

.. code-block:: bash

   #the user [USERNAME: surfadvisors-homer] belongs to the project [PROJECTNAME: surfadvisors] and wants to publish the file 'hello-world.sh'
   ssh surfadvisors-homer@spider.surfsara.nl
   cp $HOME/hello-world.sh /project/surfadvisors/Public/
   ls -l /project/surfadvisors/Public/hello-world.sh
   #-rwxrwxrwx  1  surfadvisors-homer  surfadvisors-homer  192 Jul  1 08:53 hello-world.sh

* That's it! Any data located in your ``/project/[PROJECTNAME]/Public`` directory is exposed to the web under the domain: ``https://public.spider.surfsara.nl/project/[PROJECTNAME]/``. This means that the example file can be downloaded by anyone from link below:

https://public.spider.surfsara.nl/project/surfadvisors/hello-world.sh

.. WARNING::
   Be careful with the data you place under your project space ``/project/[PROJECTNAME]/Public`` directory. This data is automatically exposed to the web and anyone that knows the URL can download it!
.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`
