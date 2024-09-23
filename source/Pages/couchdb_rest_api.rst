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
     * find a document based on a value and return the whole document
     * find a document based on a value and return the required fields
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
To get the database information, similarly create the get-database-info command:
  
.. code-block:: bash
  
   db_info_cmd="curl --silent --netrc-file .netrc-picas-user-myawesomedb -X GET https://picas.surfsara.nl:6984/myawesomedb"

You can create an alias for the command to use it easily, by running the command: 

.. code-block:: bash
  
   alias db_info='echo -e "\n$db_info_cmd\n" && $db_info_cmd'

Run the `db_info` to see the output. You can use `jq` to transform the JSON data to a more readable format:
  
.. code-block:: bash
  
   db_info
   db_info | jq .












.. _`Picas CouchDB web interface`: https://picas.surfsara.nl:6984/_utils/#login
