<%@ Language=VBScript %>
<% Option Explicit %>
<%	' dmaurer@opentext.com 2:00 AM 4/15/2004
 Dim InfoNT
 Set InfoNT = CreateObject("WinNTSystemInfo")
 response.write "<h1>" + lcase(InfoNT.ComputerName)	' display server name 
%>
<p>
<%= Request.ServerVariables("LOCAL_ADDR") %>		<! display local IP address /!>
