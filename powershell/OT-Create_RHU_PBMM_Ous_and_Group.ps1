# rhu OUs and groups

$rhudomain = "DC=rhu,DC=int,DC=d2l"
$server = "rhu.int.d2l"
$pbmmgroups = "PBMM_FS_RO","PBMM_FS_RW","PBMM_LMS_Local_Admin","PBMM_postfix_Admins","PBMM_Solr_Admins","PBMM_sftp_Admins","PBMM_Users"

New-ADOrganizationalUnit -Name PBMM -Path $rhudomain -Verbose -Server $server
New-ADOrganizationalUnit -Name "Service Accounts" -Path "ou=PBMM,$rhudomain" -Verbose -Server $server

foreach ($group in $pbmmgroups) {
    New-ADGroup -Name $group -Path "ou=PBMM,$rhudomain" -Verbose -GroupScope Universal
    }




