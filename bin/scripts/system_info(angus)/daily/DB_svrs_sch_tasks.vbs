'*****************************************************************************
'*****************************************************************************
'Last Modified: 12:40 PM 10/21/2008
'Modified By: Anne Murray
'Purpose: The purpose of this script is to query all the servers in the AD 
'	  domain (as listed in a file) and report on all the scheduled tasks that
'	  exist. It does a second step of filtering that output to a more
'	  readable format. 
'*****************************************************************************
'*****************************************************************************

Dim objFSO, objFolder, objFile
Dim strDirectory, strFile
Dim CharPos, Line
Dim usr, pwd
Dim wmiLocator, objWMIService

const ForReading = 1
const ForWriting = 2
CharPos = 1


'The first part is to read the file containing the server names in AD
'And output the basic schtasks information for each server
'*****************************************************************************
'*****************************************************************************

'Create the filesystem object for the file containing the server names. 
srvFile ="C:\Bin\system_info\daily\db_servers.txt"
Set objFSOa = CreateObject("Scripting.FileSystemObject")
Set objFilea = objFSOa.OpenTextFile(srvFile, ForReading, TristateUseDefault)

'count the number of lines in the server names file. 
Do While NOT(objFilea.AtEndOFStream) 
	Lines = Lines + 1
	objFilea.ReadLine
loop 

'Create the object again to read through it a second time for the data
Set objFSOa = CreateObject("Scripting.FileSystemObject")
Set objFilea = objFSOa.OpenTextFile(srvFile, ForReading, TristateUseDefault)


'just makes sure we start with a clean file 
strDirectoryb = "C:\Bin\system_info\daily\output\"
strFileb = "SchTasks_DB.txt"
Set objFSOb = CreateObject("Scripting.FileSystemObject")

If objFSOb.FileExists(strDirectoryb & strFileb) Then
	objFSOb.Deletefile(strDirectoryb & strFileb) 		
End If


'Parse out each server name, then run the schtasks cmd
Do Until (objFilea.Line = Lines - 1) 
	theLine = objFilea.ReadLine

	Do While NOT(objFilea.AtEndOfLine)
		Char = objFilea.Read(CharPos)	
		If NOT (Char <> " " XOR Char <> "$") Then
			ServerName = ServerName + Char	
		End If	
	loop
	Set objShell = WScript.CreateObject("WScript.Shell")
	strRun = "%comspec% /c schtasks /query /s " & ServerName & " /FO CSV /NH /V >> C:\Bin\system_info\daily\output\SchTasks_DB.txt"
	objShell.Run strRun, 0, True
	'objShell.Run "get_schtasks.bat " & ServerName, 0, true
	ServerName = ""
Loop 


objFilea.close

'*****************************************************************************
'*****************************************************************************
'The second part is to read the schtasks information and parse out the 
' information we want, the server name, the task name, the status of the last run (0 - success)
' and the user who the task is run as. 
'*****************************************************************************
'*****************************************************************************
strDirectory = "C:\bin\system_info\daily\output\"
strFile = "SchTasks_DB.txt"
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(strDirectory & strFile, ForReading, True)

strText = objFile.ReadAll
objFile.Close
strNewText = Replace(strText, vbCr & vbCr & vbLf , "" )

Set objFile = objFSO.OpenTextFile(strDirectory & strFile, ForWriting, True)
objFile.WriteLine strNewText
objFile.Close


strDirectory2 = "C:\bin\system_info\daily\output\"
strFile2 = "SchTasks_report_DB.txt"
Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objFile2 = objFSO2.OpenTextFile(strDirectory2 & strFile2, ForWriting, True)



objFile2.writeline("ServerName , TaskName , LastRun , LastStatus")  
objFile2.writeline("===============================================") 
 

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(strDirectory & strFile, ForReading, True)


Do Until (objFile.AtEndOfStream) 
				
	Char = objFile.Read(CharPos)		
	If (Char = Chr(34)) Then		
		
		theLine = objFile.ReadLine

		dim splitstr
		dim delmiter
		delimter = Chr(34) & Chr(44) & Chr(34)
		splitstr=Split(theLine, delimter)
		
		objFile2.writeline(splitstr(0) & " , " & splitstr(1) & " , "  & splitstr(5) & " , "  & splitstr(6)) 

	Else 
		objFile.skipline

	End If			
	
Loop 


objFile.close
objFile2.Close


'email the results
'Set objShell = WScript.CreateObject("WScript.Shell")
'	strRun = "c:\bin\blat.exe " & strDirectory2 & strFile2 & " -s "  & chr(34) & "Scheduled Tasks on DB Servers"  & chr(34) & "  -to amurray@opentext.com"
'	objShell.Run strRun, 0, True

