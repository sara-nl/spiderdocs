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

Next, create the get-user-info command:
  
.. code-block:: bash
  
   user_info_cmd="curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/_users/org.couchdb.user:$username"

You can create an alias for the command to use it easily, by running the command: 

.. code-block:: bash
  
   alias user_info='echo -e "\n$user_info_cmd\n" && $user_info_cmd'

Run the `user_info` to see the output. You can use `jq` to transform the JSON data to a more readable format:
  
.. code-block:: bash
  
   user_info
   user_info | jq .
  



.. _get-database-info:

Get database info
===============================
To get the database information, similarly create the get-database-info command. Note that you need to specify at the end of the command which database you are interested in. 
  
.. code-block:: bash
  
   db_info_cmd="curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb"

You can create an alias for the command to use it easily, by running the command: 

.. code-block:: bash
  
   alias db_info='echo -e "\n$db_info_cmd\n" && $db_info_cmd'

Run the `db_info` to see the output. You can use `jq` to transform the JSON data to a more readable format:
  
.. code-block:: bash
  
   db_info
   db_info | jq .



.. _get-specific-document-info:

Get info of specific documents
===============================
To get the information of specific documents, create the get-document-info command. Note that you need to specify at the end of this command which document/token you are interested in:
  
.. code-block:: bash
  
   doc_info_cmd="curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/token_0"

You can create an alias for the command to use it easily, by running the command: 

.. code-block:: bash
  
   alias doc_info='echo -e "\n$doc_info_cmd\n" && $doc_info_cmd'

Run the `doc_info` to see the output. You can use `jq` to transform the JSON data to a more readable format:
  
.. code-block:: bash
  
   doc_info
   doc_info | jq .




.. _get-all-document:

Get all documents in a database
===============================
To get the information of all documents in a database, create the get-all-document command. Adjust the web address to your database name.
  
.. code-block:: bash
  
   all_docs_db_cmd="curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/_all_docs/"

You can create an alias for the command to use it easily, by running the command: 

.. code-block:: bash
  
   alias all_docs_db='echo -e "\n$all_docs_db_cmd\n" && $all_docs_db_cmd'

Run the `all_docs_db` to see the output. You can use `jq` to transform the JSON data to a more readable format:
  
.. code-block:: bash
  
   all_docs_db
   all_docs_db | jq .



.. _get-design-document:

Get all design documents in a database
===============================
If you only want to check the design documents in a database, adjust the previous command slightly:
  
.. code-block:: bash
  
   all_design_docs_db_cmd="curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/_design_docs"

You can create an alias for the command to use it easily, by running the command: 

.. code-block:: bash
  
   alias all_design_docs_db='echo -e "\n$all_design_docs_db_cmd\n" && $all_design_docs_db_cmd'

Run the `all_design_docs_db` to see the output. You can use `jq` to transform the JSON data to a more readable format:
  
.. code-block:: bash
  
   all_design_docs_db
   all_design_docs_db | jq .




.. _get-docs-specific-view:

Get all documents in a specific view
===============================
To get documents only in a specific view, create the command by running:
  
.. code-block:: bash
  
   view_docs_cmd="curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/_design/Monitor/_view/todo"

Note that you can adjust the view name in the web address of the command.

Next, you can create an alias for the command to use it easily, by running the command: 

.. code-block:: bash
  
   alias view_docs='echo -e "\n$view_docs_cmd\n" && $view_docs_cmd'

Run the `view_docs` to see the output. You can use `jq` to transform the JSON data to a more readable format:
  
.. code-block:: bash
  
   view_docs
   view_docs | jq .




.. _get-docs-descending:

Get document in a specific view in descending by key order
===============================
To get documents only in a specific view and list in descending by key order, create the command by running:
  
.. code-block:: bash
  
   view_docs_desc_cmd="curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/_design/Monitor/_view/todo?descending=true"

Note that you can adjust the view name in the web address of the command.

Next, you can create an alias for the command to use it easily, by running the command: 

.. code-block:: bash
  
   alias view_docs_desc='echo -e "\n$view_docs_desc_cmd\n" && $view_docs_desc_cmd'

Run the `view_docs_desc` to see the output. 
  
.. code-block:: bash
  
   view_docs_desc



.. _get-reduce-output:

Get the view/reduce output
===============================
To get the view with reduced output, create the command by running:
  
.. code-block:: bash
  
   view_reduce_cmd="curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb/_design/Monitor/_view/overview_total?group=true"

Note that you can adjust the view name in the web address of the command.

Next, you can create an alias for the command to use it easily, by running the command: 

.. code-block:: bash
  
   alias view_reduce='echo -e "\n$view_reduce_cmd\n" && $view_reduce_cmd'

Run the `view_reduce` to see the output. 
  
.. code-block:: bash
  
   view_reduce
