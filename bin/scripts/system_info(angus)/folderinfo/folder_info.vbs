strComputer = "rico"
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")



Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFolder = objFSO.GetFolder("\\rico\D$\OPENTEXT\livedocs\index\enterprise\data_flow")
Set colSubfolders = objFolder.Subfolders


For Each objSubfolder in colSubfolders
    Wscript.Echo objSubfolder.Name, objSubfolder.Size
Next