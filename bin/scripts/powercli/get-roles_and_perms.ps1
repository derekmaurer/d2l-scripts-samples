$viRolesList = Get-VIRole;
Foreach ( $role in $viRoleList ) {
     $roleName = $role.Name;
     $privilegeSet = $role | Get-VIPrivilege;

     Echo "New-VIRole -Name ""$roleName""" >> vRoles.txt;

     Foreach ( $privilege in $privilegeSet ) {
         $privilegeID = $privilege.ID;
         Echo "Set-VIRole -role ""$roleName"" -AddPrivilege `
         (Get-VIPrivilege -ID $privilegeID)" >> vRoles.txt;
     }
}