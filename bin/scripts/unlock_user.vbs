Dim objuser, strScreen 

dim output
set output = wscript.stdout

strUsername = "dmaurer"
strComputer = "lugnut"
 
   
set objUser = GetObject("WinNT://" & strComputer & "/" & strUsername)  
if objUser.IsAccountLocked = True Then  
   objUser.IsAccountLocked = False  
   objUser.SetInfo  
   strScreen = "Account unlocked"  
Else  
   strScreen = "Account was not locked"  
end If 
 
output.writeline strScreen
