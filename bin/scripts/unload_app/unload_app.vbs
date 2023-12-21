'	dmaurer@opentext.com	2:27 PM 4/19/2004	

set args = Wscript.arguments
ServerName = args(0)

Function ProcessWebSite(ServiceType, SiteNumber)
	Set IISWebSite = getObject("IIS://" & ServerName & "/" & ServiceType & "/" & SiteNumber)
	Set IISWebSiteRoot = getObject("IIS://" & ServerName & "/" & ServiceType & "/" & SiteNumber & "/root")
		ProcessWebSite = IISWebSite.ServerComment & Space(40-len(IISWebSite.Servercomment)) & _
			" " 
	Set IISWebSiteRoot = nothing
	Set IISWebSite = Nothing
end function

wscript.echo "For server \\" & ServerName & " ..."

Set DirObj = GetObject("IIS://" & ServerName & "/w3svc/1/Root")
Set IISOBJ = getObject("IIS://" & ServerName & "/w3svc")
	for each Web in IISOBJ
		if (Web.Class = "IIsWebServer") then
			wscript.echo "Unloading IIS Application cache for " & ProcessWebSite("w3svc", Web.name)
		Set DirObj = GetObject("IIS://" & ServerName & "/w3svc/" & Web.Name & "/Root")
		DirObj.AppUnload
		end if
	next
Set IISOBj=Nothing
WScript.Echo "Finished"

