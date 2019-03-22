.. warning:: Please note that Spider is a fresh service - still in Beta phase - and the documentation here is heavily under construction. If you need any help in these pages, please contact :ref:`our helpdesk <helpdesk>`.

.. _access:

.. contents::
    :depth: 2

*************
Access method
*************

Access to the cluster is provided via SSH (Secure Shell) Public key
authentication only. For the highest security of your data and the platform, we
don't not allow username/password authentication.

To use this method you will need first to configure your SSH public key on a
portal provided by SURFsara. Then you can connect and authenticate to the
Spider with your SSH keys without supplying your username or password at
each visit.

.. Add a reference to pages that explain SSH key encryption


.. _access-prerequisites:

=============
Prerequisites
=============

* A SURFsara user account
* An SSH key-pair on your laptop (or other machine you connect from)

As a member of a Spider project you shall have received a SURFsara user account.
This account is required to access the SURFsara portal in the step below. If you
still don't have a user account, please request an account first as described in
:ref:`how to grant access <grant-access>` and then return to this page.

If you already have an ssh key-pair please proceed to the next section to
upload it. Else you have to generate a key-pair by using the following command:

.. code-block:: console

   $laptop$ ssh-keygen # This will create a key-pair in $HOME/.ssh directory


.. _upload-key:

===============
Upload your key
===============

Follow these steps to upload your key to our SURFsara portal. Note that this is
*one time* task:

* **Step1**: Login to the `SURFsara portal`_ with your SURFsara user account
* **Step2**: Click on the tab "Public ssh keys" on the left pane
* **Step3**: Add your public key by copying the contents of your file ``id_rsa.pub`` as shown below:

  .. image:: /Images/cua-portal-addssh.png
	   :align: center

.. Replace with a picture with key pasted and annotated.

From now on you can login to Spider with your SSH keys from your laptop
(or other computer where your SSH key was generated/transferred).
See next, :ref:`how to login <login>`.


.. seealso:: Still need help? Contact :ref:`our helpdesk <helpdesk>`


.. Links:

.. _`SURFsara portal`: https://portal.surfsara.nl/
