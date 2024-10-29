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

.. image:: /Images/picas_create_a_token_1.png
   :align: center

|

Next. click on the '+' button next to 'All Documents' and add a new doc:

.. image:: /Images/picas_create_a_token_2.png
   :align: center

|

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

.. image:: /Images/picas_create_a_token_3.png
   :align: center

|

Click on create document and you will find the newly created token in the todo view:

.. image:: /Images/picas_create_a_token_4.png
   :align: center

|

.. _update-a-token:

Update a token
===============================

You may want to update a token, for example moving a token from locked to todo. 

Token_7 is in the locked view:

.. image:: /Images/picas_update_a_token_1.png
   :align: center

|

Click on the token and adjust the value of key `"lock"` to 0:

.. image:: /Images/picas_update_a_token_2.png
   :align: center

|

Save the changes and you will find the token in the todo view:

.. image:: /Images/picas_update_a_token_3.png
   :align: center

|


.. _Query a simple view:

Query a simple view
===============================
There are some standard views already available, such as done, error, locked, overview_total, todo. 
You can find these views under `Monitor > Views`.

.. image:: /Images/picas_query_a_view_1.png
   :align: center

|

If you click on one view, you will see all the tokens which belong to this view:

.. image:: /Images/picas_query_a_view_2.png
   :align: center

|


.. _Query-an-advanced-view:

Query an advanced view with reduce functions
===============================

Additionaly, you can query the reduce function for a certain view.
Click on the view you want to query:

.. image:: /Images/picas_reduce_function_1.png
   :align: center

|

Next, click on `options` on the top right corner. Select `reduce` in the query options and run query:

.. image:: /Images/picas_reduce_function_2.png
   :align: center

|

Then you can see the overview of the tokens.


.. _`Picas CouchDB web interface`: https://picas.surfsara.nl:6984/_utils/#login
