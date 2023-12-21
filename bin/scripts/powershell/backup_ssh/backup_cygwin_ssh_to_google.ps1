Start-Transcript -path "C:\bin\scripts\powershell\backup_ssh\output.txt" -append

$date = Get-Date -Format Filedate
$backuppath = "C:\Users\dmaurer\Google Drive\pwd\ssh"
$source = "C:\cygwin\home\dmaurer\.ssh"
$destination = $backuppath+"\"+$date+"-ssh-backup.zip"

Compress-Archive -Path $source -DestinationPath $destination -Verbose

#Copy-Item -Path \\d2lshare\IT_Files\KeePass\Database.kdbx C:\Users\dmaurer\Dropbox\pwd\d2l\$date-Keepass.kdbx
#Copy-Item -Path \\d2lshare\IT_Files\KeePass\Database.kdbx $backuppath\$date-Keepass.kdbx

Stop-Transcript
