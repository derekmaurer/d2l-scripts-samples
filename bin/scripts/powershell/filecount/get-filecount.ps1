$folders =  Get-ChildItem -Recurse d:\test\*\* | ?{ $_.PSIsContainer } | Select-Object FullName

return $folders | ForEach-Object {Write-Host $_.FullName '`n' (robocopy $_.FullName d:\null1234567890 /e /l) }  
