# LDAP (Lightweight Directory Access Protocol)

**What is LDAP?**
- LDAP stands for **Lightweight Directory Access Protocol**.
- It’s a way to access and manage a directory of information about users, groups, computers, and other resources in a network.

**What is it used for?**
- **User Authentication:** Checking user credentials to allow access to systems and applications.
- **Centralized Directory Services:** Keeping all user and resource information in one place.
- **Single Sign-On (SSO):** Letting users log in once to access multiple services.
- **Email Systems:** Managing contact lists and email distribution lists.

**How does it work?**
- **Hierarchy:** Information is stored in a tree-like structure.
- **Standardized:** Works with many different systems and applications.

**Basic Operations:**
1. **Bind:** Log in to the LDAP server.
2. **Search:** Look for specific information.
3. **Compare:** Check if an entry has a specific attribute.
4. **Add:** Add a new entry.
5. **Delete:** Remove an entry.
6. **Modify:** Change an entry.
7. **Unbind:** Log out from the LDAP server.

**Example Use:**
- **Active Directory (AD):** Microsoft’s service for managing users and computers uses LDAP.
- **OpenLDAP:** An open-source LDAP service.

**Simple Query Example:**
- **Search for a user:**
  ```shell
  ldapsearch -x -LLL -H ldap://ldap.example.com -b "dc=example,dc=com" "(uid=jdoe)"
