' Written By: Anne Murray
' LastModified: 3:02 PM 10/29/2008

dim filesys, filename, fDate, DateDf, objFSO, folder
dim UserName, Password 
dim count


strDirectory = "\\phat\F$\sqlmaintdumps\database"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set folder = objFSO.GetFolder(strDirectory)

count = 0 

'Loop through each file in the directory specified above
For each file in folder.files

	'get the filename
	filename = file.name
	count = count + 1

	'get the last modified date of the file
	fDate = file.DateLastModified

	'use the datediff function to determine how many days old the file is
	DateDf = DateDiff("h", fDate, Now) 
	
	'If the file is older than 24 hours
	
		
	If DateDf > 24 Then	
			
		Wscript.echo "old file -  " & filename & " Date: "  & fDate

	Else 
		Wscript.echo "current file - " & filename & " Date: "  & fDate	  		   

	End If

	'reset the filename variable 
	Set filename = Nothing	

Next 

'clean up
set objFSO = nothing
set folder = nothing
set file = nothing

Wscript.echo "Total Files: " & count