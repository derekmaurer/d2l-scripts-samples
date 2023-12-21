# regional OUs and groups

$regionaldomains = "acc1","aas1","aas2","aue1","aew1"

foreach ($rdomain in $regionaldomains) {
    $domain = "dc=$rdomain" + ",dc=int,dc=d2l"

    New-ADOrganizationalUnit -Name Servers_PBMM -Path $domain -Verbose -server "$rdomain.int.d2l" 

    New-ADOrganizationalUnit -Name Linux -Path "ou=Servers_PBMM,$domain"  -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name Prod -Path "ou=Linux,ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"

    New-ADOrganizationalUnit -Name LMS -Path "ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name Utility -Path "ou=LMS,ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name Prod -Path "ou=Utility,ou=LMS,ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name Test -Path "ou=Utility,ou=LMS,ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name Web -Path "ou=LMS,ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name Prod -Path "ou=Web,ou=LMS,ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name Test -Path "ou=Web,ou=LMS,ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"

    New-ADOrganizationalUnit -Name Management -Path "ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name RDP -Path "ou=Management,ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"

    New-ADOrganizationalUnit -Name NAS -Path "ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"

    New-ADOrganizationalUnit -Name SQL -Path "ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name Prod -Path "ou=SQL,ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name Test -Path "ou=SQL,ou=Servers_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"

    New-ADOrganizationalUnit -Name "Service Accounts_PBMM" -Path "$domain" -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name Infrastructure -Path "ou=Service Accounts_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name LDAP -Path "ou=Service Accounts_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name Monitoring -Path "ou=Service Accounts_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"
    New-ADOrganizationalUnit -Name SQL -Path "ou=Service Accounts_PBMM,$domain" -Verbose -server "$rdomain.int.d2l"
    }