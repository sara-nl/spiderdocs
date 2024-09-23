.. _CouchDB-REST-API:
*****************
Use CouchDB from the command line with REST API and cURL
*****************

In this page you will learn how to use Picas CouchDB from the command line using REST API calls with `curl`. Here include instructions to: 

     * get user info
     * get database info
     * get info of specific documents
     * get all documents in a database
     * get all design documents in a database
     * get all documents in a specific view
     * get document in a specific view in descending by key order
     * get the view/reduce output 
     * find a document based on a value and return the whole document
     * find a document based on a value and return the required fields

First of all, create and configure the `.netrc` file which contains login and initialization information used by the auto-login process. 
In your working environment, create a `.netrc` file for connecting to your database (in this example the database is myawesomedb).
  
.. code-block:: bash
  
   vim .netrc-picas-user-myawesomedb

Next, fill the `.netrc-picas-user-myawesomedb` with following information:

.. code-block:: bash
  
   machine picas.surfsara.nl
   login Picas-login-name
   password Picas-pass-word

Save and exit the file. Now we are ready for running some commands. 

  
.. _get-user-info:

Get user info
===============================
After configuring the `.netrc` file, get the Picas username from the `.netrc` file by running:
  
.. code-block:: bash
  
   username=$(awk '/picas.surfsara.nl/{getline; print $2}' .netrc-picas-user-myawesomedb)

You can check if you get the username right by running:
  
.. code-block:: bash
  
   echo $username

Next, run the following command:
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/_users/org.couchdb.user:$username

You can use `jq` to transform the JSON data to a more readable format:
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/_users/org.couchdb.user:$username | jq .
  



.. _get-database-info:

Get database info
===============================
To get the database information, run the following command. Note that you need to specify at the end of the command which database you are interested in. 
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb


You can use `jq` to transform the JSON data to a more readable format:
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb | jq .



.. _get-specific-document-info:

Get info of specific documents
===============================
To get the information of specific documents, run the following command. Note that you need to specify at the end of this command which document/token you are interested in:
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/token_0


Run the `doc_info` to see the output. You can use `jq` to transform the JSON data to a more readable format:
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/token_0 | jq .




.. _get-all-document:

Get all documents in a database
===============================
To get the information of all documents in a database, run the following command command. Adjust the web address to your database name.
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/_all_docs/

You can use `jq` to transform the JSON data to a more readable format:
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/_all_docs/ | jq .



.. _get-design-document:

Get all design documents in a database
===============================
If you only want to check the design documents in a database, adjust the previous command slightly:
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/_design_docs


You can use `jq` to transform the JSON data to a more readable format:
  
.. code-block:: bash

   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/_design_docs | jq .




.. _get-docs-specific-view:

Get all documents in a specific view
===============================
To get documents only in a specific view, run the following command:
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/_design/Monitor/_view/todo

Note that you can adjust the view name in the web address of the command.

You can use `jq` to transform the JSON data to a more readable format:
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/_design/Monitor/_view/todo | jq .




.. _get-docs-descending:

Get document in a specific view in descending by key order
===============================
To get documents only in a specific view and list in descending by key order, run the following command:
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/_design/Monitor/_view/todo?descending=true"

Note that you can adjust the view name in the web address of the command.




.. _get-reduce-output:

Get the view/reduce output
===============================
To get the view with reduced output, run the following command:
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/_design/Monitor/_view/overview_total?group=true

Note that you can adjust the view name in the web address of the command.


.. _find_return_doc:

Find a document based on a value and return the whole document
===============================

To find a document based on a value and return the whole document, CouchDB API provides find documents function using a declarative JSON querying syntax, see `CouchDB find expressions`_.
For example to find documents which have 0 exit_code, run the following command:
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X  POST --header "Content-Type:application/json" --data '{"selector": {"exit_code": {"$eq": 0}}}' https://picas.surfsara.nl:6984/myawesomedb/_find



.. _find_return_fields:

Find a document based on a value and return the required fields
===============================

Do you want to limit which fields are returned for a document? To Find a document based on a value and return the required fields, you can add fields in the data body, see `CouchDB filtering fields`_.
For example to find documents which have 0 exit_code and return only a few fields, run the following command:
  
.. code-block:: bash
  
   curl --silent --netrc-file .netrc-picas-user-myawesomedb -X  POST --header "Content-Type:application/json" --data '{"selector": {"exit_code": {"$eq": 0}}, "fields": ["_id", "lock", "done", "input", "exit_code"]}' https://picas.surfsara.nl:6984/myawesomedb/_find


.. Links:

.. _`CouchDB find expressions`: https://docs.couchdb.org/en/stable/api/database/find.html#find-expressions
.. _`CouchDB filtering fields`: https://docs.couchdb.org/en/stable/api/database/find.html#filtering-fields
