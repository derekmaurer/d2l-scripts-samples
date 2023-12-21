
$fullreport=@()

$computers = ((Get-ADComputer -Verbose -Filter *) | where Name -like "*US04M*").Name.trim()
write-host Matched ($computers | measure).count

write-host -NoNewline Running

foreach ($target in $computers) {

 if (Test-Path "\\${target}\c$\Program Files (x86)\Google\Chrome\Application\chrome.exe") {
    
    write-host -NoNewline "." -ForegroundColor Green

    $versioninfo = Get-ChildItem "\\${target}\c$\Program Files (x86)\Google\Chrome\Application\chrome.exe" | select -ExpandProperty VersionInfo
   
    $report = New-Object psobject -Property @{
        ServerName = $target
        HasChrome = "True"
        FileName = $versioninfo.FileName 
        ProductVersion = $versioninfo.ProductVersion
        FileVersion = $versioninfo.FileVersion 
        }
    
    } else {

    write-host -NoNewline "." -ForegroundColor Yellow
    
    $report = New-Object psobject -Property @{
        ServerName = $target
        HasChrome = "False"
        FileName = ""
        ProductVersion = ""
        FileVersion = ""
        }

    }

$fullreport += $report | Select ServerName, HasChrome, ProductVersion, FileVersion, FileName 

}

write-host Done! -ForegroundColor Green

$fullreport | ft