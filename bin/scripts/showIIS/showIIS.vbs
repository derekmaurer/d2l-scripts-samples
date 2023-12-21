'	dmaurer@opentext.com	2:27 PM 4/19/2004
'	dmaurer@opentext.com	3:40 PM 2/16/2006 

Function ProcessWebSite(ServiceType, SiteNumber)
	Set IISWebSite = getObject("IIS://" & wscript.Arguments(0) & "/" & ServiceType & "/" & SiteNumber)
	Set IISWebSiteRoot = getObject("IIS://" & wscript.Arguments(0) & "/" & ServiceType & "/" & SiteNumber & "/root")
		ProcessWebSite = IISWebSite.ServerComment & Space(40-len(IISWebSite.Servercomment)) & _
			" " & IISWebsiteRoot.Path
	Set IISWebSiteRoot = nothing
	Set IISWebSite = Nothing
end function

Function ShowSites(ServiceType, ClassName, Title)
	WScript.Echo Title & " Sites"
	WScript.Echo ""
	Wscript.echo Title & " Site     " & title & " Site Description                     Path"
	Wscript.echo "============================================================================="
	Set IISOBJ = getObject("IIS://" & wscript.Arguments(0) & "/" & ServiceType)
	for each Web in IISOBJ
		if (Web.Class = ClassName) then
			wscript.echo Ucase(ServiceType) & "/" & Web.Name & _
				Space(12-(len(Ucase(ServiceType))+1+len(Web.Name))) & " " & _
				ProcessWebSite(ServiceType, Web.name)
		end if
	next
	Set IISOBj=Nothing
	WScript.Echo ""
End function

Call ShowSites("w3svc", "IIsWebServer", "Web")
Call ShowSites("msftpsvc", "IIsFtpServer", "FTP")
