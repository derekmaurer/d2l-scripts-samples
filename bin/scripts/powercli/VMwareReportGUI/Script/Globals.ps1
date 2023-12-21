#========================================================================
# Created with: SAPIEN Technologies, Inc., PowerShell Studio 2012 v3.1.14
# Created on:   2/5/2013 6:36 AM
# Created by:   Zachary Loeber
# Organization: 
# Filename: Globals.ps1
# Description: These are used across both the gui and the called script
#              for storing and loading script state data.
#========================================================================

#Our base variables
$varEmailReport=$false
$varEmailSubject=""
$varEmailRecipient=""
$varEmailSender=""
$varSMTPServer=""
$varSaveReportsLocally=$false
$varReportName="report.html"
$varReportFolder="."
$varVIServer="localhost"
$varUseCurrentUser=$true
$varVIUser=""
$varVIPassword=""
$varScopeWholeFarm=$true
$varScopeDatacenter=""
$varScopeCluster=""
$varScopeHost=""
$varReportHostsDatastore=$true
$varReportHostsDatastoreThreshold="10"
$varReportVMSnapshots=$true
$varReportVMSnapshotsThreshold="2"
$varReportVMThinProvisioned=$true
$varReportSelective=$true
$varReportVCVMsCreated = $true
$varReportVCVMsDeleted = $true
$varReportVCErrors = $true
$varReportHostsNotResponding = $true
$varReportHostsInMaint = $true
$varReportVMTools = $true
$varReportCDConnected = $true
$varReportFloppyConnected = $true
$varReportVCVMsCreatedAge = 5
$varReportVCEventLogsAge = 1
$varReportVCErrorsAge = 1
$varReportVCEvntlogs = $true
$varReportVCServices = $true

#For each variable an xml attribute should exist
$ConfigTemplate = 
@"
<Configuration>
    <EmailReport>{0}</EmailReport>
    <EmailSubject>{1}</EmailSubject>
	<EmailRecipient>{2}</EmailRecipient>
	<EmailSender>{3}</EmailSender>
	<SMTPServer>{4}</SMTPServer>
	<SaveReportsLocally>{5}</SaveReportsLocally>
	<ReportName>{6}</ReportName>
	<ReportFolder>{7}</ReportFolder>
    <VIServer>{8}</VIServer>
    <UseCurrentUser>{9}</UseCurrentUser>
    <VIUser>{10}</VIUser>
    <VIPassword>{11}</VIPassword>
    <ScopeWholeFarm>{12}</ScopeWholeFarm>
    <ScopeDatacenter>{13}</ScopeDatacenter>
    <ScopeCluster>{14}</ScopeCluster>
    <ScopeHost>{15}</ScopeHost>
    <ReportDatastore>{16}</ReportDatastore>
    <ReportDatastoreThreshold>{17}</ReportDatastoreThreshold>
    <ReportSnapshots>{18}</ReportSnapshots>
    <ReportSnapshotsThreshold>{19}</ReportSnapshotsThreshold>
    <ReportThinProvisioned>{20}</ReportThinProvisioned>
    <ReportSelective>{21}</ReportSelective>
    <ReportVCVMsCreated>{22}</ReportVCVMsCreated>
    <ReportVCVMsDeleted>{23}</ReportVCVMsDeleted>
    <ReportVCErrors>{24}</ReportVCErrors>
    <ReportHostNotResponding>{25}</ReportHostNotResponding>
    <ReportHostsInMaint>{26}</ReportHostsInMaint>
    <ReportVMTools>{27}</ReportVMTools>
    <ReportCDConnected>{28}</ReportCDConnected>
    <ReportFloppyConnected>{29}</ReportFloppyConnected>
    <ReportVCEventAge>{30}</ReportVCEventAge>
    <ReportVCErrorsAge>{31}</ReportVCErrorsAge>
    <ReportVCEvntlogs>{32}</ReportVCEvntlogs>
    <ReportVCServices>{33}</ReportVCServices>
</Configuration>
"@

# VMware specific globals
#$VIConnection
$VIConnected = $false

#Provides the location of the script
function Get-ScriptDirectory
{ 
	if($hostinvocation -ne $null)
	{
		Split-Path $hostinvocation.MyCommand.path
	}
	else
	{
		Split-Path $script:MyInvocation.MyCommand.Path
	}
}

#Provides the location of the script
[string]$ScriptDirectory = Get-ScriptDirectory

#Config file location
$ConfigFile = $ScriptDirectory + "\Config.xml"

#This is the non-GUI version of the script.
$StarterScript = "\VMware-Report.ps1"

Function Get-SaveData
{
    [xml]$x=($ConfigTemplate) -f 
        $varEmailReport,`
        $varEmailSubject,`
        $varEmailRecipient,`
        $varEmailSender,`
        $varSMTPServer,`
        $varSaveReportsLocally,`
        $varReportName,`
        $varReportFolder,`
        $varVIServer,`
        $varUseCurrentUser,`
        $varVIUser,`
        $varVIPassword,`
        $varScopeWholeFarm,`
        $varScopeDatacenter,`
        $varScopeCluster,`
        $varScopeHost,`
        $varReportHostsDatastore,`
        $varReportHostsDatastoreThreshold,`
        $varReportVMSnapshots,`
        $varReportVMSnapshotsThreshold,`
        $varReportVMThinProvisioned,`
        $varReportSelective,`
        $varReportVCVMsCreated,`
        $varReportVCVMsDeleted,`
        $varReportVCErrors,`
        $varReportHostsNotResponding,`
        $varReportHostsInMaint,`
        $varReportVMTools,`
        $varReportCDConnected,`
        $varReportFloppyConnected,`
        $varReportVCEventLogsAge,`
        $varReportVCErrorsAge,`
        $varReportVCEvntlogs,`
        $varReportVCServices
    return $x
}

function Load-Config
{
	if (Test-Path $ConfigFile)
	{
		[xml]$configuration = get-content $($ConfigFile)
        $Script:varEmailReport = [System.Convert]::ToBoolean($configuration.Configuration.EmailReport)
        $Script:varEmailSubject = $configuration.Configuration.EmailSubject
        $Script:varEmailRecipient = $configuration.Configuration.EmailRecipient
        $Script:varEmailSender = $configuration.Configuration.EmailSender
        $Script:varSMTPServer = $configuration.Configuration.SMTPServer
        $Script:varSaveReportsLocally = [System.Convert]::ToBoolean($configuration.Configuration.SaveReportsLocally)
        $Script:varReportName = $configuration.Configuration.ReportName
        $Script:varReportFolder = $configuration.Configuration.ReportFolder
        $Script:varVIServer = $configuration.Configuration.VIServer
        $Script:varUseCurrentUser = [System.Convert]::ToBoolean($configuration.Configuration.UseCurrentUser)
        $Script:varVIUser = $configuration.Configuration.VIUser
        $Script:varVIPassword = $configuration.Configuration.VIPassword
       # $Script:varScopeWholeFarm = [System.Convert]::ToBoolean($configuration.Configuration.ScopeWholeFarm)
        $Script:varScopeDatacenter = $configuration.Configuration.ScopeDatacenter
        $Script:varScopeCluster = $configuration.Configuration.ScopeCluster
        $Script:varScopeHost = $configuration.Configuration.ScopeHost
        $Script:varReportHostsDatastore = [System.Convert]::ToBoolean($configuration.Configuration.ReportDatastore)
        $Script:varReportHostsDatastoreThreshold = $configuration.Configuration.ReportDatastoreThreshold
        $Script:varReportVMSnapshots = [System.Convert]::ToBoolean($configuration.Configuration.ReportSnapshots)
        $Script:varReportVMSnapshotsThreshold = $configuration.Configuration.ReportSnapshotsThreshold
        $Script:varReportVMThinProvisioned = [System.Convert]::ToBoolean($configuration.Configuration.ReportThinProvisioned)
        $Script:varReportSelective = [System.Convert]::ToBoolean($configuration.Configuration.ReportSelective)
        $Script:varReportVCVMsCreated = [System.Convert]::ToBoolean($configuration.Configuration.ReportVCVMsCreated)
        $Script:varReportVCVMsDeleted = [System.Convert]::ToBoolean($configuration.Configuration.ReportVCVMsDeleted)
        $Script:varReportVCErrors = [System.Convert]::ToBoolean($configuration.Configuration.ReportVCErrors)
        $Script:varReportHostsNotResponding = [System.Convert]::ToBoolean($configuration.Configuration.ReportHostNotResponding)
        $Script:varReportHostsInMaint = [System.Convert]::ToBoolean($configuration.Configuration.ReportHostsInMaint)
        $Script:varReportVMTools = [System.Convert]::ToBoolean($configuration.Configuration.ReportVMTools)
        $Script:varReportCDConnected = [System.Convert]::ToBoolean($configuration.Configuration.ReportCDConnected)
        $Script:varReportFloppyConnected = [System.Convert]::ToBoolean($configuration.Configuration.ReportFloppyConnected)
        $Script:varReportVCEventLogsAge = $configuration.Configuration.ReportVCEventAge
        $Script:varReportVCErrorsAge = $configuration.Configuration.ReportVCErrorsAge
        $Script:varReportVCEvntlogs = [System.Convert]::ToBoolean($configuration.Configuration.ReportVCEvntlogs)
        $Script:varReportVCServices = [System.Convert]::ToBoolean($configuration.Configuration.ReportVCServices)
        Return $true
	}
    else
    {
        Return $false
    }
}

# Save exceptions
function Save-Config
{
    $SanitizedConfig = $true
	if (($varEmailReport) -and`
        (($varEmailSubject -eq "") -or`
		 ($varEmailRecipient -eq "") -or`
         ($varEmailSender -eq "") -or`
         ($varSMTPServer -eq "")))
	{
		#[void][reflection.assembly]::Load("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
		[void][System.Windows.Forms.MessageBox]::Show("You selected to send an email but didn't fill in the right stuff to make it happen buddy.","Sorry, try again.")
        $SanitizedConfig = $false
	}
	elseif (($varSaveReportsLocally) -and`
			(($varReportName -eq "") -or`
			 ($varReportFolder -eq "")))
	{
		#[void][reflection.assembly]::Load("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
		[void][System.Windows.Forms.MessageBox]::Show("You selected to not save locally (so are assumed to be attempting to email the reports) but didn't fill in email configuration information.","Sorry, not going to do it.")
        $SanitizedConfig = $false
	}
   	elseif ((!$varScopeWholeFarm) -and`
			($varScopeDatacenter -eq ""))
    {
   		#[void][reflection.assembly]::Load("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
		[void][System.Windows.Forms.MessageBox]::Show("You selected to not report on the whole farm and then made no other selections. `n`n Not Saved.","Sorry, that will not work..")
        $SanitizedConfig = $false
	}
 
    if ($SanitizedConfig)
	{
		# save the data
		[xml]$x=Get-SaveData
        $x.save($ConfigFile)
        Return $true
	}
    else
    {
        Return $false
	}
}