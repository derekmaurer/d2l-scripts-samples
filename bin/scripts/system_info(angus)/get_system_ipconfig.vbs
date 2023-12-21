dim filesys, filetext, filename, ServerName
dim UserName, Password 
Const ForReading = 1

'run a script to get the server names from AD
'Set objShell = WScript.CreateObject("WScript.Shell")
'objShell.Run "get_server_names.bat", 0, true

filename="C:\bin\system_info\servers.txt"
filename2="C:\bin\system_info\servers_ipconfig.txt" 
Set filesys = CreateObject("Scripting.FileSystemObject")
Set filetext = filesys.OpenTextFile(filename, ForReading, TristateUseDefault)

CharPos = 1
Lines = 0 


Do While NOT(filetext.AtEndOFStream) 
	Lines = Lines + 1
	filetext.ReadLine
loop 

Set filesys = CreateObject("Scripting.FileSystemObject")
Set filetext = filesys.OpenTextFile(filename, ForReading, TristateUseDefault)

'filetext.skipline

Do Until (filetext.Line = Lines - 1) 
	theLine = filetext.ReadLine
	'Wscript.echo "The Line " & theline

	Do While NOT(filetext.AtEndOfLine)
		Char = filetext.Read(CharPos)	
		If NOT (Char <> " " XOR Char <> "$") Then
		ServerName = ServerName + Char			
	End If	
	loop
	Set objShell = WScript.CreateObject("WScript.Shell")
	objShell.Run "get_server_ipconfigt.bat " & ServerName, 0, true
	ServerName = ""
Loop 


filetext.close