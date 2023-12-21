
On Error Resume Next 

'Define Constants 
CONST CONST_CPU           = "0" 
CONST CONST_CPU_PERCENT = "1" 

'Define Array 
private arraycpu() 

'Define variables 
Dim cpu_count, i, lngarray 

'Fill variables with initial values 
cpu_count = 0 
i = 0 

Set args= wscript.arguments 
'If args.count <> 3 Then 
'Wscript.echo "Prints out CPU Load" 
'Wscript.echo "Usage: cscript win32_processor.vbs <Computername> <UserID> <Password> <index>" 
'Wscript.echo "   Or: cscript win32_processor.vbs <Computername> <UserID> <Password> <query> <cpu|percent>" 
'Wscript.echo "   Or: cscript win32_processor.vbs <Computername> <UserID> <Password> <get> <cpu|percent> <indexvalue>" & VBCrLf 
'Else 

strServer = args.item(0) 
strUserName = args.item(1) 
strPassword = args.item(2) 
strquery = args.item(3) 
strwhat = args.item(4) 
strvalue = args.item(5) 

Set objLocator = CreateObject( "WbemScripting.SWbemLocator" ) 

'Connect to the server 
Set objWMIService = objLocator.ConnectServer ( strServer, "root/cimv2", strUserName, strPassword ) 
objWMIService.Security_.impersonationlevel = 3 
Set OS_Set = objWMIService.ExecQuery( "Select * from Win32_Processor" ) 

'Count the number of instances 
for each Instance in OS_Set 
   cpu_count = cpu_count + 1 
next 
'wscript.echo "Count CPU = " & cpu_count 

'Remove 1 instance, first record of array is 0 
array_rec = cpu_count - 1 

'Redimension array to counted instances 
redim arraycpu(CONST_CPU_PERCENT,array_rec) 

'Fill the Array 
for each Instance in OS_Set 
   arraycpu(CONST_CPU, i) = RIGHT(Instance.DeviceID,1) 
   arraycpu(CONST_CPU_PERCENT, i) = Instance.LoadPercentage 
'   wscript.echo arraycpu(CONST_CPU, i) & ":" & arraycpu(CONST_CPU_PERCENT, i) 
   i = i + 1 
next 

lngarray = array_rec 
'Wscript.Echo "Array lenght = " & lngarray 

Select Case strquery 
   Case "index" 
      For i = 0 to lngarray 
         Wscript.Echo arraycpu(CONST_CPU, i) 
      Next 

   Case "query" 
      If strwhat = "cpu" Then 
         For i = 0 to lngarray 
            Wscript.Echo i & ":" & arraycpu(CONST_CPU, i) 
         Next 
      End If 
      If strwhat = "percent" Then 
         For i = 0 to lngarray 
            Wscript.Echo i & ":" & arraycpu(CONST_CPU_PERCENT, i) 
         Next 
      End If 


   Case "get" 
      If strwhat = "cpu" Then 
         Wscript.Echo i & ":" & arraycpu(CONST_CPU, strvalue) 
      End If 
      If strwhat = "percent" Then 
         Wscript.Echo i & ":" & arraycpu(CONST_CPU_PERCENT, strvalue) 
      End If 
    
End Select 
'End If 