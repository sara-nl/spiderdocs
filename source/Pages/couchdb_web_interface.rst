.. _CouchDB-Web:
*****************
Using Picas CouchDB from the web interface
*****************

In this page you will learn how to use Picas CouchDB from the web interface to carry out following tasks:

     * create a token
     * update a token
     * query a simple view
     * query an advanced view with reduce functions

First of all, login to the `Picas CouchDB web interface`_ with your Picas username and password.

.. _create-a-token:

Create a token
===============================
After logging in, choose your Picas database by clicking on the database name:

.. image:: /Images/picas_create_a_view_1.png
   :align: center

Next. click on the '+' button next to 'All Documents' and add a new doc:

.. image:: /Images/picas_create_a_view_2.png
   :align: center

For creating a new token, a few key-value pair needs to be defined. You can use the following template

.. code-block:: bash

   {
    "_id": "token_xx",
    "type": "token",
    "lock": 0,
    "done": 0,
    "hostname": "",
    "scrub_count": 0,
    "input": "",
    "exit_code": ""
   }

Adjust the `_id` and if necessary `input`:

.. image:: /Images/picas_create_a_view_3.png
   :align: center

Click on create document and you will find the newly created token in the Views todo:

.. image:: /Images/picas_create_a_view_4.png
   :align: center


.. _update-a-token:

Update a token
===============================


.. _Query a simple view:

Query a simple view
===============================


.. _Query-an-advanced-view:

Query an advanced view with reduce functions
===============================




.. _`Picas CouchDB web interface`: https://picas.surfsara.nl:6984/_utils/#login
