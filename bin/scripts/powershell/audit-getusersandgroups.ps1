$domain = "rhu.int.d2l"
$csvfile = "$(get-date -f yyyy-MM-dd)_groups_by_users.csv"

$users = get-aduser -server rhu.int.d2l  -Properties * -Filter {(ObjectClass -eq "user")}

$usersgroups = @() 

foreach ($user in $users){

    $obj = "" | Select FirstName,SurnameName,UserName,EmailAddress,Enabled,Groups
    $user | ft GivenName,Surname,SamAccountName,emailaddress,enabled
    $groups = Get-ADPrincipalGroupMembership -Identity $user.SamAccountName -server $domain -ResourceContextServer $domain

    $obj.FirstName    = $user.GivenName
    $obj.SurnameName  = $user.Surname
    $obj.UserName     = $user.samaccountname
    $obj.EmailAddress = $user.EmailAddress
    $obj.Enabled      = $user.Enabled 
    $obj.Groups       = $groups.Name -join ","
    
    $obj
    $usersgroups += $obj

    }

$usersgroups | Export-Csv -Path $csvfile

