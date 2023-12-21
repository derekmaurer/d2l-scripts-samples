Dim FolderName, FolderDate, FolderSize
Dim FolderName2, FolderDate2, FolderSize2
Dim count, count2, count3, count4 
Dim trnNames(), trnDates(), trnSize() 
Dim trnNames2(), trnDates2(), trnSize2() 
Dim OldestName, OldestSize, OldestDate
Dim OldestName2, OldestSize2, OldestDate2
Dim item, CompareNames, CompareNames2, CompareSizes
Dim SavedFolderName, SavedFolderSize

'constants for file reading/writing
const ForWriting = 2
const ForReading = 1

'variables to pass in are machine name and foldername 
strComputer = WScript.Arguments(0)
strDirectory = WScript.Arguments(1)

'Set Folder Directory 
Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFolder = objFSO.GetFolder("\\" & strComputer & "\D$\OPENTEXT\" & strDirectory & "\index\enterprise\data_flow")
Set colSubfolders = objFolder.Subfolders

logDir = "Index_Extractor_Checks\" 

'Create the regular expression trn to look for
Set RegularExpressionObject = New RegExp
With RegularExpressionObject
	.Pattern = ".trn"
	.IgnoreCase = True
	.Global = True
End With

'initialize arrays
ReDim Preserve trnNames(0)
ReDim Preserve trnDates(0)
ReDim Preserve trnSize(0)
count = 0 

'Check Folders once
For Each objSubfolder in colSubfolders
	FolderName = objSubfolder.Name 
	FolderDate = objSubfolder.DateLastModified
	FolderSize = objSubfolder.Size
	
	expressionmatch = RegularExpressionObject.Test(FolderName)

	If expressionmatch Then				
		ReDim Preserve trnNames(count)
		ReDim Preserve trnDates(count)		
		ReDim Preserve trnSize(count)
		trnNames(count) = FolderName
		trnDates(count) = FolderDate
		trnSize(count) = FolderSize
		count = count+1
	End If	
Next

If count <> 0 Then

	'In the trn folders found, get the oldest one
	OldestDate = trnDates(0)
	count2 = 0 
	for each item in trnDates
		If item < OldestDate Then
			OldestDate = item
			count2 = count2+1						
		End If
	Next

	'now we have the oldest .trn file 
	OldestName = trnNames(count2) 
	OldestSize = trnSize(count2) 

	'Do a second check right after, to save from checking for files

	'initialize second set of arrays
	ReDim Preserve trnNames2(0)
	ReDim Preserve trnDates2(0)
	ReDim Preserve trnSize2(0)
	count3 = 0

	For Each objSubfolder in colSubfolders
		FolderName2 = objSubfolder.Name 
		FolderDate2 = objSubfolder.DateLastModified
		FolderSize2 = objSubfolder.Size
	
		expressionmatch = RegularExpressionObject.Test(FolderName2)
	
		If expressionmatch Then				
			ReDim Preserve trnNames2(count3)
			ReDim Preserve trnDates2(count3)		
			ReDim Preserve trnSize2(count)
			trnNames2(count3) = FolderName2
			trnDates2(count3) = FolderDate2
			trnSize2(count3) = FolderSize2
			count3 = coun3t+1
		End If	
		Next

	If count3 <> 0 	Then

		'Get the oldest trn folder in the second array
		OldestDate2 = trnDates2(0)
		count4 = 0 
		for each item in trnDates2
			If item < OldestDate2 Then
				OldestDate2 = item
				count4 = count4+1						
			End If	
		Next

		'now we have the oldest .trn file in the second arrat 
		OldestName2 = trnNames2(count2) 
		OldestSize2 = trnSize2(count2) 
	
		'Compare the names of the oldest trn folder in both arrays
		CompareNames = StrComp(OldestName2,OldestName, 1)
		
		If CompareNames <> 0 Then
			'Name of the oldest trn file is different, things are processing
			call UpdateFile(strDirectory & "_status.txt", "good")
		Else 
			'Names are the same, we need to go to files to compare with last check
			'create the object to handle the file 
			Set filesys = CreateObject("Scripting.FileSystemObject")
			FileWithName = strDirectory & "_FolderName.txt"
		
			If filesys.FileExists(logDir & FileWithName) Then

				'We have stored a value in a file, we need to read it and compare
				 SavedFolderName = ReadFile(FileWithName)

				CompareNames2 = StrComp(OldestName2,SavedFolderName, 1)
	
				If CompareNames2 <> 0 Then
					'Name in file is different than name on disk, things are processing
					call UpdateFile(strDirectory & "_status.txt", "good")
				Else	
					'Name on disk is the same as name on file, need to compare size 			
					Set filesys = CreateObject("Scripting.FileSystemObject")
					FileWithSize = strDirectory & "_FolderSize.txt"
			
					If filesys.FileExists(logDir & FileWithSize) Then

						'We have a file on disk with the size
						SavedFileSize = ReadFile(FileWithSize)

						CompareSizes = StrComp(OldestSize2,SavedFileSize , 1)

						If CompareSizes <> 0  Then
							'Size on disk is different than size in file, things are processing
							statusStr = "good"
							call UpdateFile(strDirectory & "_status.txt", statusStr)
							call UpdateFile(strDirectory & "_FolderName.txt", OldestName2) 
							call UpdateFile(strDirectory & "_FolderSize.txt", OldestSize2)

						Else
							'Name and size on disk are same as in files, things are probably not processing
							statusStr = "error"
							call UpdateFile(strDirectory & "_status.txt", statusStr)
							call UpdateFile(strDirectory & "_FolderName.txt", OldestName2) 
							call UpdateFile(strDirectory & "_FolderSize.txt", OldestSize2) 
						End If				
					End If						
				End If 	
			Else
				'Files not created, no errors yet
				statusStr = "good"
				call UpdateFile(strDirectory & "_status.txt", statusStr)
				call UpdateFile(strDirectory & "_FolderName.txt", OldestName2) 
				call UpdateFile(strDirectory & "_FolderSize.txt", OldestSize2) 		  	
			End If

		End If		
	Else
		'second check returned a count of 0 
		statusStr = "good"
		call UpdateFile(strDirectory & "_status.txt", statusStr)
	End If
Else
	'check returned a count of 0 
	statusStr = "good"
	call UpdateFile(strDirectory & "_status.txt", statusStr)
	
End If
		
' cleanup
Set RegularExpressionObject = nothing

wscript.echo statusStr


' *********************************
function ReadFile(filename)

 Set objFSO = CreateObject("Scripting.FileSystemObject")
 Set objFile = objFSO.OpenTextFile(logDir & filename, ForReading, TristateUseDefault)
 ReadFile = objFile.ReadLine

end function


' *********************************
sub UpdateFile (filename, strData)

 Set objFSO = CreateObject("Scripting.FileSystemObject")
 Set objFile = objFSO.OpenTextFile(logDir & filename, ForWriting, True)
 objFile.WriteLine strData
 objFile.Close

end Sub