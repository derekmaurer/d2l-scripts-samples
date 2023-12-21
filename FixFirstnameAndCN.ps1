# Corrects all users in Departments OU that have CN set as SAMAccountName and Firstname as FullName

$users = (Get-ADUser -Server rhu.int.d2l -Filter * -SearchBase 'OU=Departments,DC=rhu,DC=int,DC=d2l') | Where-Object -Property DistinguishedName -Match 'colo' 

foreach ($user in $users){ 
    $givenname = $user.GivenName -replace $user.Surname,""
    $fullname = $givenname+" "+$user.surname
    $DistinguishedName = $user.DistinguishedName -replace $user.SamAccountName,$fullname

    Set-ADUser -Identity $user.SamAccountName -GivenName $givenname -DisplayName $fullname 
    Rename-ADObject -Identity $user.DistinguishedName -NewName $fullname 

    }
