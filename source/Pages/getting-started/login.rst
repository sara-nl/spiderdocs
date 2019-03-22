.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _login:

.. contents::
    :depth: 2


.. _ssh-login:

************************
Login to Spider
************************

.. _login-prerequisites:

=============
Prerequisites
=============

* An SSH public key uploaded on the SURFsara portal (see :ref:`upload-key`)

If you already completed this step once, you are ready to login!

.. _login-to-ui:

===============
Login to the UI
===============

* Login to Spider via a terminal with the following command:

.. code-block:: console

   $ssh [USERNAME]@[Spider HOSTNAME]

* For example:

.. code-block:: console

      $ssh homer@spider.surfsara.nl
      #[homer@htp-ui ~]$  # this is the first prompt upon login

Congrats! You've just logged in to Spider.


.. note:: In case that you have multiple keys in your ``.ssh/`` folder, you would need to specify the key that matches the .pub file you :ref:`uploaded on the SURFsara portal <upload-key>`, i.e. ``ssh -i ~/.ssh/surfsarakey homer@spider.surfsara.nl``


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`
