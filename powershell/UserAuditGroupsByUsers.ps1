param
(
    [parameter(Mandatory = $false)][String] $environment = "Dev-LMS",    
    [parameter(Mandatory = $false)][String] $domain = "rhu.int.d2l",
	[parameter(Mandatory = $false)][String] $smtp = "labsmtp.lab.int.d2l", 
	[parameter(Mandatory = $false)][String] $emailaddress = "cloudinfrastructureservices@d2l.com", 
	[parameter(Mandatory = $false)][String] $from = "labmutil001@d2l.com", 
	[parameter(Mandatory = $false)][String] $path = "D:\Scripts\PowerShell\UserAudit-GroupsByUsers\csv", 
	[parameter(Mandatory = $false)][String] $searchbase = "ou=Departments,dc=rhu,dc=int,dc=d2l",
	[parameter(Mandatory = $false)][String] $diff = $false
) 

$csvfile = "$(get-date -f yyyy-MM-dd)-$domain-$environment-groups_by_users.csv"
$difffile = "$(get-date -f yyyy-MM-dd)-$domain-$environment-changes.txt"

$users = get-aduser -server rhu.int.d2l -SearchBase $searchbase -Properties * -Filter {(ObjectClass -eq "user")}
$usersgroups = @() 

Write-host "Getting group membership for..." -ForegroundColor Green

$stopwatch = [system.diagnostics.stopwatch]::startNew()
foreach ($user in $users){

    $obj = "" | Select FirstName,SurnameName,UserName,EmailAddress,LastLogonDate,Enabled,Groups
    Write-Host $user.samaccountname -ForegroundColor DarkCyan
    $groups = Get-ADPrincipalGroupMembership -Identity $user.SamAccountName -server $domain -ResourceContextServer $domain 

    $obj.FirstName     = $user.GivenName
    $obj.SurnameName   = $user.Surname
    $obj.UserName      = $user.samaccountname
    $obj.EmailAddress  = $user.EmailAddress
    $obj.LastLogonDate = $user.LastLogonDate
    $obj.Enabled       = $user.Enabled 
    $obj.Groups        = ($groups.Name | sort) -join ","
    
    #$obj | ft -HideTableHeaders
    $usersgroups += $obj

    }
$Stopwatch.ElapsedTime
$usersgroups | Sort-Object -Property UserName | Export-Csv -Path "$path\$csvfile"

if ($diff -eq "true") {

    Write-Host "Checking for change since last run..." -ForegroundColor Yellow
    $files = Get-ChildItem -Path $path -Filter '*.csv' | sort LastWriteTime -Descending | Select-Object -First 2
    $filezero = $path+'\'+$files[0].Name
    $fileone = $path+'\'+$files[1].Name
    echo "git diff (Get-Content $fileone) (Get-Content $filezero)" | Out-File $path\$difffile

    $userdiff = git diff $fileone $filezero
    $userdiff = $userdiff -split "`n"
    $userdiff | Select-String -Pattern "^-|^\+" | Out-File -Append $path\$difffile

    Write-Host "Sending mail to $emailaddress" -ForegroundColor Yellow
    $attachments = @("$path\$difffile")
    $textEncoding = [System.Text.Encoding]::UTF8 

    $subject="$environment $domain Changes" 
    $body = " 
    <body style='font-family:Lato,sans-serif'>
    <p>Greetings,
    <p>Attached is the list of change from running 'User Audit Groups By Users' for $domain in $environment<br><br>
    This is the default output from the Compare-Object PowerShell function, and can be read as follows:
    <ul>
        <li>Lines with the SideIndicator of <= are in the previous run.</li>
        <li>Lines with the side indicator of => are in the current run.</li>
        <li>If there are two similar lines, but something has changed, there will be one line with <= and a similar line with => which show that this line has changed from this to that.</li>
    </ul>
    <p>Cheers,<br>
    Cloud infra Services - Platform<br><br>
    <sub>
    Hostname: $env:computername<br>
    Script:   $PSCommandPath <br>
    </sub>
    </body>"

    Send-MailMessage -smtpServer $smtp -from $from -to $emailaddress -subject $subject -body $body -Attachments $attachments -bodyasHTML -Encoding $textEncoding   

} else {

    Write-Host "Sending mail to $emailaddress" -ForegroundColor Yellow
    $attachments = @("$path\$csvfile")
    $textEncoding = [System.Text.Encoding]::UTF8 

    $subject="$environment $domain Groups By Users" 
    $body = " 
    <body style='font-family:Lato,sans-serif'>
    <p>Greetings,
    <p style='text-indent: 40px'>Attached is the quarterly 'User Audit Groups By Users' for $domain in $environment
    <p>Cheers,<br>
    Cloud infra Services - Platform<br><br>
    <sub>
    Hostname: $env:computername<br>
    Script:   $PSCommandPath <br>
    </sub>
    </body>"

    Send-MailMessage -smtpServer $smtp -from $from -to $emailaddress -subject $subject -body $body -Attachments $attachments -bodyasHTML -Encoding $textEncoding   
}



