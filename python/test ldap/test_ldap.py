import ldap3

server = ldap3.Server('rhu.int.d2l', use_ssl=True)
conn = ldap3.Connection(server, 'rhu\dmaurercolo', '(kraK1n22*12#$56', auto_bind=True)
conn.bind()

print (conn)

conn.search(search_base='CN=Automation,OU=Automation,OU=Departments,DC=rhu.int.d2l',
            search_filter='(objectCategory=person)', search_scope=ldap3.SUBTREE,
            attributes = ['sAMAAccountName'], size_limit=0) 

print (conn)

import sys
from ldap3 import Server, Connection, ALL, NTLM, ALL_ATTRIBUTES, ALL_OPERATIONAL_ATTRIBUTES, AUTO_BIND_NO_TLS, SUBTREE
from ldap3.core.exceptions import LDAPCursorError

server_name = 'rhu.int.d2l'
domain_name = 'rhu'
user_name = 'dmaurercolo'
password = '(kraK1n22*12#$56'

format_string = '{:25} {:>6} {:19} {:19} {}'
print(format_string.format('User', 'Logins', 'Last Login', 'Expires', 'Description'))

server = Server(server_name, get_info=ALL, use_ssl=True)
conn = Connection(server, user='{}\\{}'.format(domain_name, user_name), password=password, authentication=NTLM, auto_bind=True)
print (conn)

conn.search('dc=rhu,dc=int,dc=d2l', '(objectclass=person)', attributes=[ALL_ATTRIBUTES, ALL_OPERATIONAL_ATTRIBUTES])
print (conn.entries)
