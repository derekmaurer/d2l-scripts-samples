$date = Get-Date -Format Filedate

$backuppath     = "C:\Users\dmaurer\Google Drive\pwd\d2l"
$backuppath2    = "C:\Users\dmaurer\Google Drive\pwd\mRemoteNG"
$backuppath3    = "C:\Users\dmaurer\OneDrive - D2L Corporation\pwd"
$backuppathssh  = "C:\Users\dmaurer\Google Drive\pwd\ssh"
$backuppathssh2 = "C:\Users\dmaurer\OneDrive - D2L Corporation\ssh"

#keepass no longer updated
#Copy-Item -Path \\d2lshare\IT_Files\KeePass\Database.kdbx C:\Users\dmaurer\Dropbox\pwd\d2l\$date-Keepass.kdbx
#Copy-Item -Path \\d2lshare\IT_Files\KeePass\Database.kdbx $backuppath\$date-Keepass.kdbx

Copy-Item -Path C:\Users\dmaurer\AppData\Roaming\mRemoteNG\confCons.xml $backuppath2\confCons-$date.xml
Copy-Item -Path C:\Users\dmaurer\AppData\Roaming\mRemoteNG\confCons.xml $backuppath3\mRemoteNG\confCons-$date.xml

c:
cd \cygwin\home\dmaurer

zip $date-ssh-backup.zip .ssh -r

Copy-Item -Path $date-ssh-backup.zip -Destination $backuppathssh2
Move-Item -Path $date-ssh-backup.zip -Destination $backuppathssh
