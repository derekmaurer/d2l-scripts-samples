#----------------------------------------------
#region Import Assemblies
#----------------------------------------------
[void][Reflection.Assembly]::Load("System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
[void][Reflection.Assembly]::Load("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
[void][Reflection.Assembly]::Load("System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
[void][Reflection.Assembly]::Load("mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
[void][Reflection.Assembly]::Load("System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
[void][Reflection.Assembly]::Load("System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
[void][Reflection.Assembly]::Load("System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
#endregion Import Assemblies

#Define a Param block to use custom parameters in the project
#Param ($CustomParameter)

function Main {
	Param ([String]$Commandline)
	
	if((Call-MainForm_pff) -eq "OK")
	{
		
	}
	
	$global:ExitCode = 0 #Set the exit code for the Packager
}

#endregion Source: Startup.pfs

#region Source: MainForm.pff
function Call-MainForm_pff
{

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load("System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
	[void][reflection.assembly]::Load("mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$MainForm = New-Object 'System.Windows.Forms.Form'
	$buttonCancel = New-Object 'System.Windows.Forms.Button'
	$buttonSave = New-Object 'System.Windows.Forms.Button'
	$buttonRun = New-Object 'System.Windows.Forms.Button'
	$tabcontrol1 = New-Object 'System.Windows.Forms.TabControl'
	$tabpage1 = New-Object 'System.Windows.Forms.TabPage'
	$grpConnectionInfo = New-Object 'System.Windows.Forms.GroupBox'
	$lblConnectHost = New-Object 'System.Windows.Forms.Label'
	$lblConnectCluster = New-Object 'System.Windows.Forms.Label'
	$lblConnectDatacenter = New-Object 'System.Windows.Forms.Label'
	$lblConnectServer = New-Object 'System.Windows.Forms.Label'
	$lblConnectLogon = New-Object 'System.Windows.Forms.Label'
	$label3 = New-Object 'System.Windows.Forms.Label'
	$label4 = New-Object 'System.Windows.Forms.Label'
	$label2 = New-Object 'System.Windows.Forms.Label'
	$label1 = New-Object 'System.Windows.Forms.Label'
	$labelLogon = New-Object 'System.Windows.Forms.Label'
	$grpCredentials = New-Object 'System.Windows.Forms.GroupBox'
	$txtvCenterServer = New-Object 'System.Windows.Forms.TextBox'
	$labelServer = New-Object 'System.Windows.Forms.Label'
	$buttonConnect = New-Object 'System.Windows.Forms.Button'
	$chkCurrentUser = New-Object 'System.Windows.Forms.CheckBox'
	$labelCurrentUser = New-Object 'System.Windows.Forms.Label'
	$txtUser = New-Object 'System.Windows.Forms.TextBox'
	$txtPassword = New-Object 'System.Windows.Forms.MaskedTextBox'
	$labelUser = New-Object 'System.Windows.Forms.Label'
	$labelPassword = New-Object 'System.Windows.Forms.Label'
	$grpVMwareSettings = New-Object 'System.Windows.Forms.GroupBox'
	$comboHost = New-Object 'System.Windows.Forms.ComboBox'
	$labelHost = New-Object 'System.Windows.Forms.Label'
	$comboCluster = New-Object 'System.Windows.Forms.ComboBox'
	$comboDatacenter = New-Object 'System.Windows.Forms.ComboBox'
	$chkWholeFarm = New-Object 'System.Windows.Forms.CheckBox'
	$labelCluster = New-Object 'System.Windows.Forms.Label'
	$labelWholeFarm = New-Object 'System.Windows.Forms.Label'
	$labelDatacenter = New-Object 'System.Windows.Forms.Label'
	$tabpage6 = New-Object 'System.Windows.Forms.TabPage'
	$grpVC = New-Object 'System.Windows.Forms.GroupBox'
	$chkRptVCServices = New-Object 'System.Windows.Forms.CheckBox'
	$labelVCServiceStatus = New-Object 'System.Windows.Forms.Label'
	$dialRptVCEventlogsAge = New-Object 'System.Windows.Forms.NumericUpDown'
	$labelWindowsEventLogError = New-Object 'System.Windows.Forms.Label'
	$chkRptVCEvtLogs = New-Object 'System.Windows.Forms.CheckBox'
	$labelEventLogErrWarn = New-Object 'System.Windows.Forms.Label'
	$dialRptVCErrorsAge = New-Object 'System.Windows.Forms.NumericUpDown'
	$labelVCErrorEventsTheshol = New-Object 'System.Windows.Forms.Label'
	$chkRptVCErrors = New-Object 'System.Windows.Forms.CheckBox'
	$labelVCEventErrors = New-Object 'System.Windows.Forms.Label'
	$chkRptVCVMsDeleted = New-Object 'System.Windows.Forms.CheckBox'
	$labelVMsDeleted = New-Object 'System.Windows.Forms.Label'
	$chkRptVCVMsCreated = New-Object 'System.Windows.Forms.CheckBox'
	$labelVMsCreatedCloned = New-Object 'System.Windows.Forms.Label'
	$grpHosts = New-Object 'System.Windows.Forms.GroupBox'
	$chkRptHostsInMaint = New-Object 'System.Windows.Forms.CheckBox'
	$labelInMaintinance = New-Object 'System.Windows.Forms.Label'
	$chkRptHostsNotResponding = New-Object 'System.Windows.Forms.CheckBox'
	$dialRptHostsDatastorePercent = New-Object 'System.Windows.Forms.NumericUpDown'
	$labelNotResponding = New-Object 'System.Windows.Forms.Label'
	$chkRptHostsDatastore = New-Object 'System.Windows.Forms.CheckBox'
	$labelFreeThreshold = New-Object 'System.Windows.Forms.Label'
	$labelDatastoreUtilization = New-Object 'System.Windows.Forms.Label'
	$grpReportGeneral = New-Object 'System.Windows.Forms.GroupBox'
	$chkRptSelective = New-Object 'System.Windows.Forms.CheckBox'
	$labelGenerateReportOnlyWh = New-Object 'System.Windows.Forms.Label'
	$groupbox3 = New-Object 'System.Windows.Forms.GroupBox'
	$chkRptVMFloppyConnected = New-Object 'System.Windows.Forms.CheckBox'
	$labelFloppyConnected = New-Object 'System.Windows.Forms.Label'
	$chkRptVMCDConnected = New-Object 'System.Windows.Forms.CheckBox'
	$labelCDConnected = New-Object 'System.Windows.Forms.Label'
	$chkRptVMTools = New-Object 'System.Windows.Forms.CheckBox'
	$labelNoVMwareTools = New-Object 'System.Windows.Forms.Label'
	$chkRptVMThinProvisioned = New-Object 'System.Windows.Forms.CheckBox'
	$labelThinProvisioned = New-Object 'System.Windows.Forms.Label'
	$dialRptVMSnapThresh = New-Object 'System.Windows.Forms.NumericUpDown'
	$chkRptVMSnapshots = New-Object 'System.Windows.Forms.CheckBox'
	$labelSnapshotThreshold = New-Object 'System.Windows.Forms.Label'
	$labelSnapshots = New-Object 'System.Windows.Forms.Label'
	$tabpage2 = New-Object 'System.Windows.Forms.TabPage'
	$grpSchedule = New-Object 'System.Windows.Forms.GroupBox'
	$grpReportFormat = New-Object 'System.Windows.Forms.GroupBox'
	$labelReportStyle = New-Object 'System.Windows.Forms.Label'
	$comboReportStyle = New-Object 'System.Windows.Forms.ComboBox'
	$groupbox1 = New-Object 'System.Windows.Forms.GroupBox'
	$txtEmailSubject = New-Object 'System.Windows.Forms.TextBox'
	$labelSubject = New-Object 'System.Windows.Forms.Label'
	$labelEmailReport = New-Object 'System.Windows.Forms.Label'
	$chkEmailReport = New-Object 'System.Windows.Forms.CheckBox'
	$labelReportName = New-Object 'System.Windows.Forms.Label'
	$labelSaveReport = New-Object 'System.Windows.Forms.Label'
	$txtReportName = New-Object 'System.Windows.Forms.TextBox'
	$labelReportFolder = New-Object 'System.Windows.Forms.Label'
	$chkSaveLocally = New-Object 'System.Windows.Forms.CheckBox'
	$txtReportFolder = New-Object 'System.Windows.Forms.TextBox'
	$txtSMTPServer = New-Object 'System.Windows.Forms.TextBox'
	$buttonBrowseFolder = New-Object 'System.Windows.Forms.Button'
	$labelSMTPRelayServer = New-Object 'System.Windows.Forms.Label'
	$labelEmailSender = New-Object 'System.Windows.Forms.Label'
	$labelEmailRecipient = New-Object 'System.Windows.Forms.Label'
	$txtEmailRecipient = New-Object 'System.Windows.Forms.TextBox'
	$txtEmailSender = New-Object 'System.Windows.Forms.TextBox'
	$tabpage5 = New-Object 'System.Windows.Forms.TabPage'
	$richtextbox1 = New-Object 'System.Windows.Forms.RichTextBox'
	$timerFadeIn = New-Object 'System.Windows.Forms.Timer'
	$openfiledialog1 = New-Object 'System.Windows.Forms.OpenFileDialog'
	$folderbrowserdialog1 = New-Object 'System.Windows.Forms.FolderBrowserDialog'
	$tooltipAll = New-Object 'System.Windows.Forms.ToolTip'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	Function Set-SaveData
	{
	    $Script:varEmailReport = $chkEmailReport.Checked
	    $Script:varEmailSubject = $txtEmailSubject.Text
	    $Script:varEmailRecipient = $txtEmailRecipient.Text
	    $Script:varEmailSender = $txtEmailSender.Text
	    $Script:varSMTPServer = $txtSMTPServer.Text
	    $Script:varSaveReportsLocally = $chkSaveLocally.Checked
	    $Script:varReportName = $txtReportName.Text
	    $Script:varReportFolder = $txtReportFolder.Text
	    $Script:varVIServer = $txtvCenterServer.Text
	    $Script:varUseCurrentUser = $chkCurrentUser.Checked
	    $Script:varVIUser = $txtUser.Text
	    $Script:varVIPassword = $txtPassword.Text
	    $Script:varScopeWholeFarm = $chkWholeFarm.Checked
	    $Script:varScopeDatacenter = $comboDatacenter.Text
	    $Script:varScopeCluster = $comboCluster.Text
	    $Script:varScopeHost = $comboHost.Text
	    $Script:varReportHostsDatastore = $chkRptHostsDatastore.Checked
	    $Script:varReportHostsDatastoreThreshold = $dialRptHostsDatastorePercent.Text
	    $Script:varReportVMSnapshots = $chkRptVMSnapshots.Checked
	    $Script:varReportVMSnapshotsThreshold = $dialRptVMSnapThresh.Text
	    $Script:varReportVMThinProvisioned = $chkRptVMThinProvisioned.Checked
	    $Script:varReportSelective = $chkRptSelective.Checked
	    $Script:varReportVCErrors = $chkRptVCErrors.Checked
	    $Script:varReportHostsNotResponding = $chkRptHostsNotResponding.Checked
	    $Script:varReportHostsInMaint = $chkRptHostsInMaint.Checked
	    $Script:varReportVMTools = $chkRptVMTools.Checked
	    $Script:varReportCDConnected = $chkRptVMCDConnected.Checked
	    $Script:varReportFloppyConnected = $chkRptVMFloppyConnected.Checked
	    $Script:varReportVCErrorsAge = $dialRptVCErrorsAge.Text
	    $Script:varReportVCEventLogsAge = $dialRptVCEventlogsAge.Text
	    $Script:varReportVCEvntlogs = $chkRptVCEvtLogs.Checked
	    $Script:varReportVCServices = $chkRptVCServices.Checked
	    $Script:varReportVCVMsCreated = $chkRptVCVMsCreated.Checked
	    $Script:varReportVCVMsDeleted = $chkRptVCVMsDeleted.Checked
	}
	
	function Load-FormConfig
	{
	    $chkEmailReport.Checked = $varEmailReport
	    $txtEmailSubject.Text = $varEmailSubject
	    $txtEmailRecipient.Text = $varEmailRecipient
	    $txtEmailSender.Text = $varEmailSender
	    $txtSMTPServer.Text = $varSMTPServer
	    $chkSaveLocally.Checked = $varSaveReportsLocally
	    $txtReportName.Text = $varReportName
	    $txtReportFolder.Text = $varReportFolder
	    $txtvCenterServer.Text = $varVIServer
	    $chkCurrentUser.Checked = $varUseCurrentUser
	    $txtUser.Text = $varVIUser
	    $txtPassword.Text = $varVIPassword
	    $chkWholeFarm.Checked = $varScopeWholeFarm
	    $comboDatacenter.Text = $varScopeDatacenter
	    $comboCluster.Text = $varScopeCluster
	    $comboHost.Text = $varScopeHost
	    $chkRptHostsDatastore.Checked = $varReportHostsDatastore
	    $dialRptHostsDatastorePercent.Text = $varReportHostsDatastoreThreshold
	    $chkRptVMSnapshots.Checked = $varReportVMSnapshots
	    $dialRptVMSnapThresh.Text = $varReportVMSnapshotsThreshold
	    $chkRptVMThinProvisioned.Checked = $varReportVMThinProvisioned
	    $chkRptSelective.Checked = $varReportSelective
	    $chkRptVCVMsCreated.Checked = $varReportVCVMsCreated
	    $chkRptVCVMsDeleted.Checked = $varReportVCVMsDeleted
	    $chkRptVCErrors.Checked = $varReportVCErrors
	    $chkRptHostsNotResponding.Checked = $varReportHostsNotResponding
	    $chkRptHostsInMaint.Checked = $varReportHostsInMaint
	    $chkRptVMTools.Checked = $varReportVMTools
	    $chkRptVMCDConnected.Checked = $varReportCDConnected
	    $chkRptVMFloppyConnected.Checked = $varReportFloppyConnected
	    $chkRptVCEvtLogs.Checked = $varReportVCEvntlogs
	    $dialRptVCErrorsAge.Text = $varReportVCErrorsAge
	    $dialRptVCEventlogsAge.Text = $varReportVCEventLogsAge
	}
	
	function Set-ConnectionInfoLabel
	{
	    $lblConnectServer.Text = $varVIServer
	    if ($varScopeWholeFarm)
	    {
	        $lblConnectDatacenter.Text = "Whole Farm"
	        $lblConnectCluster.Text = "Whole Farm"
	        $lblConnectHost.Text = "Whole Farm"
		}
	    else
	    {
	        $lblConnectDatacenter.Text = $varScopeDatacenter
	        $lblConnectCluster.Text = $varScopeCluster
	        $lblConnectHost.Text = $varScopeHost
		}
	    if ($varUseCurrentUser)
	    {
	        $lblConnectLogon.Text = "<Current User>"
		}
	    else
	    {
	        $lblConnectLogon.Text = "$varVIUser - <Password>"
		}
	}
	
	# Account for all of our form control depenencies.
	function Set-FormControlsState
	{
	    # Snapshot checkbox
	    if ($chkRptVMSnapshots.Checked)
		{
	        $dialRptVMSnapThresh.Enabled = $true
		}
		else
		{
	        $dialRptVMSnapThresh.Enabled = $false
		}
	    
	    # Datastore checkbox
	    if ($chkRptHostsDatastore.Checked)
		{
	        $dialRptHostsDatastorePercent.Enabled = $true
		}
		else
		{
	        $dialRptHostsDatastorePercent.Enabled = $false
		}
	    
	    #Saved Locally Checkbox
	    if ($chkSaveLocally.Checked)
		{
			$buttonBrowseFolder.Enabled = $true
	        $txtReportFolder.Enabled = $true
			$txtReportName.Enabled = $true
		}
		else
		{
			$buttonBrowseFolder.Enabled = $false
	        $txtReportFolder.Enabled = $false
			$txtReportName.Enabled = $false
		}
	    
	    # Email Checkbox
		if ($chkEmailReport.Checked)
		{
	        $txtEmailSubject.Enabled = $true
	        $txtEmailRecipient.Enabled = $true
	        $txtEmailSender.Enabled = $true
	        $txtSMTPServer.Enabled = $true
		}
		else
		{
	        $txtEmailSubject.Enabled = $false        
	        $txtEmailRecipient.Enabled = $false
	        $txtEmailSender.Enabled = $false
	        $txtSMTPServer.Enabled = $false
		}
	    if ($VIConnected)
	    {
	        $comboDatacenter.Enabled = $true
	        $grpVMwareSettings.Enabled = $true
		}
	    else
	    {
	        $comboDatacenter.Enabled = $false
	        $grpVMwareSettings.Enabled = $false
		}
	    # Whole Farm Checkbox
	    if ($chkWholeFarm.Checked)
		{
	        $comboDatacenter.Enabled = $true
	        $comboCluster.Enabled = $false
	        $comboHost.Enabled = $false
	        $grpVC.Enabled = $true
	     }
		else
		{
	        if ($VIConnected)
	        {
	
			}
	        $grpVC.Enabled = $false
		}
	    
	    # VM Deletions requires VC Error reporting
	    if ($chkRptVCErrors.Checked)
	    {
	        $chkRptVCVMsDeleted.Enabled = $true
	        $chkRptVCVMsCreated.Enabled = $true
	        
		}
	    else
	    {
	        $chkRptVCVMsDeleted.Enabled = $false
	        $chkRptVCVMsCreated.Enabled = $false
		}
	}
	
	function PopulateVIDatacenters
	{
	    $x=0    
	    Load-ComboBox $comboCluster ''
	    Load-ComboBox $comboHost ''
	    foreach ($Datacenter in (Get-Datacenter))
	    {
	        $x++
	        if ($x++ -eq 1)
	        {
	            Load-ComboBox $comboDatacenter $Datacenter.Name
			}
	        else
	        {
	            Load-ComboBox $comboDatacenter $Datacenter.Name -Append
			}
		}
	}
	
	function PopulateVIClusters
	{
	    # Only try to populate if a datacenter has been selected
	    If ($comboDatacenter.Text -ne '')
	    {
	        Load-ComboBox $comboHost ''
	        Load-ComboBox $comboCluster ''
	        foreach ($Cluster in ((Get-Datacenter $comboDatacenter.Text) | Get-Cluster))
	        {
	            Load-ComboBox $comboCluster $Cluster.Name -Append
			}    	
		}
	}
	
	function PopulateVIHosts
	{ 
	    # Only try to populate if a cluster has been selected
	    If ($comboCluster.Text -ne "")
	    {
	        Load-ComboBox $comboHost ''
	        foreach ($VMH in ((Get-Cluster $comboCluster.Text) | Get-VMHost))
	        {
	            Load-ComboBox $comboHost $VMH.Name -Append
	    	}
		}
	}
	
	$OnLoadFormEvent={
	#TODO: Initialize Form Controls here
	}
	
	$form1_FadeInLoad={
		#Start the Timer to Fade In
		$timerFadeIn.Start()
		$MainForm.Opacity = 0
		if (Load-Config)
	    {
	        Load-FormConfig
	        Set-FormControlsState
	        Set-ConnectionInfoLabel
		}
	    #	$txtScheduledTask.Text = @"
	    #In an administrative EMC console run the following:
	    # cd `$exscripts
	    # .\ManageScheduledTask.ps1 -Install –ServerName <Your Server> -PsScriptPath "$($ScriptDirectory)$($StarterScript)" –TaskName "Troubleshoot Exchange 2010 Mailbox Servers"
	    #"@
	}
	
	$timerFadeIn_Tick={
		#Can you see me now?
		if($MainForm.Opacity -lt 1)
		{
			$MainForm.Opacity += 0.1
			
			if($MainForm.Opacity -ge 1)
			{
				#Stop the timer once we are 100% visible
				$timerFadeIn.Stop()
			}
		}
	}
	
	$buttonBrowse_Click={
	
		if($openfiledialog1.ShowDialog() -eq 'OK')
		{
			$txtReportFolder.Text = $openfiledialog1.FileName
		}
	}
	
	#region Control Helper Functions
	function Load-ComboBox 
	{
	<#
		.SYNOPSIS
			This functions helps you load items into a ComboBox.
	
		.DESCRIPTION
			Use this function to dynamically load items into the ComboBox control.
	
		.PARAMETER  ComboBox
			The ComboBox control you want to add items to.
	
		.PARAMETER  Items
			The object or objects you wish to load into the ComboBox's Items collection.
	
		.PARAMETER  DisplayMember
			Indicates the property to display for the items in this control.
		
		.PARAMETER  Append
			Adds the item(s) to the ComboBox without clearing the Items collection.
		
		.EXAMPLE
			Load-ComboBox $combobox1 "Red", "White", "Blue"
		
		.EXAMPLE
			Load-ComboBox $combobox1 "Red" -Append
			Load-ComboBox $combobox1 "White" -Append
			Load-ComboBox $combobox1 "Blue" -Append
		
		.EXAMPLE
			Load-ComboBox $combobox1 (Get-Process) "ProcessName"
	#>
		Param (
			[ValidateNotNull()]
			[Parameter(Mandatory=$true)]
			[System.Windows.Forms.ComboBox]$ComboBox,
			[ValidateNotNull()]
			[Parameter(Mandatory=$true)]
			$Items,
		    [Parameter(Mandatory=$false)]
			[string]$DisplayMember,
			[switch]$Append
		)
		
		if(-not $Append)
		{
			$ComboBox.Items.Clear()	
		}
		
		if($Items -is [Object[]])
		{
			$ComboBox.Items.AddRange($Items)
		}
		elseif ($Items -is [Array])
		{
			$ComboBox.BeginUpdate()
			foreach($obj in $Items)
			{
				$ComboBox.Items.Add($obj)	
			}
			$ComboBox.EndUpdate()
		}
		else
		{
			$ComboBox.Items.Add($Items)	
		}
	
		$ComboBox.DisplayMember = $DisplayMember	
	}
	
	function Load-ListBox 
	{
	<#
		.SYNOPSIS
			This functions helps you load items into a ListBox or CheckedListBox.
	
		.DESCRIPTION
			Use this function to dynamically load items into the ListBox control.
	
		.PARAMETER  ListBox
			The ListBox control you want to add items to.
	
		.PARAMETER  Items
			The object or objects you wish to load into the ListBox's Items collection.
	
		.PARAMETER  DisplayMember
			Indicates the property to display for the items in this control.
		
		.PARAMETER  Append
			Adds the item(s) to the ListBox without clearing the Items collection.
		
		.EXAMPLE
			Load-ListBox $ListBox1 "Red", "White", "Blue"
		
		.EXAMPLE
			Load-ListBox $listBox1 "Red" -Append
			Load-ListBox $listBox1 "White" -Append
			Load-ListBox $listBox1 "Blue" -Append
		
		.EXAMPLE
			Load-ListBox $listBox1 (Get-Process) "ProcessName"
	#>
		Param (
			[ValidateNotNull()]
			[Parameter(Mandatory=$true)]
			[System.Windows.Forms.ListBox]$listBox,
			[ValidateNotNull()]
			[Parameter(Mandatory=$true)]
			$Items,
		    [Parameter(Mandatory=$false)]
			[string]$DisplayMember,
			[switch]$Append
		)
		
		if(-not $Append)
		{
			$listBox.Items.Clear()	
		}
		
		if($Items -is [System.Windows.Forms.ListBox+ObjectCollection])
		{
			$listBox.Items.AddRange($Items)
		}
		elseif ($Items -is [Array])
		{
			$listBox.BeginUpdate()
			foreach($obj in $Items)
			{
				$listBox.Items.Add($obj)
			}
			$listBox.EndUpdate()
		}
		else
		{
			$listBox.Items.Add($Items)	
		}
	
		$listBox.DisplayMember = $DisplayMember	
	}
	#endregion
	
	$buttonSave_Click={
	    Set-SaveData
	    if (Save-Config)
	    {
	        Set-ConnectionInfoLabel
	        #[void][reflection.assembly]::Load("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
			[void][System.Windows.Forms.MessageBox]::Show("Configuration saved.","All went well!")
		}
	}
	
	$buttonRun_Click={
		Set-SaveData
	    if (Save-Config)
	    {
	    	# Run the script
	    	$script = $ScriptDirectory + $StarterScript
	    	&$script
		}
	}
	
	$buttonBrowse_Click2={
	
		if($openfiledialog1.ShowDialog() -eq 'OK')
		{
			$txtReportFolder.Text = $openfiledialog1.FileName
		}
	}
	
	$chkSaveLocally_CheckedChanged={
		if ($chkSaveLocally.Checked)
		{
			$buttonBrowseFolder.Enabled = $true
	        $txtReportFolder.Enabled = $true
			$txtReportName.Enabled = $true
		}
		else
		{
			$buttonBrowseFolder.Enabled = $false
	        $txtReportFolder.Enabled = $false
			$txtReportName.Enabled = $false
		}
	}
	
	$buttonBrowseFolder_Click={
		if($folderbrowserdialog1.ShowDialog() -eq 'OK')
		{
			$txtReportFolder.Text = $folderbrowserdialog1.SelectedPath
		}
	}
	$chkEmailReport_CheckedChanged={
		if ($chkEmailReport.Checked)
		{
	        $txtEmailSubject.Enabled = $true
	        $txtEmailRecipient.Enabled = $true
	        $txtEmailSender.Enabled = $true
	        $txtSMTPServer.Enabled = $true
		}
		else
		{
	        $txtEmailSubject.Enabled = $false        
	        $txtEmailRecipient.Enabled = $false
	        $txtEmailSender.Enabled = $false
	        $txtSMTPServer.Enabled = $false
		}
	}
	
	$chkWholeFarm_CheckedChanged={
	    if ($chkWholeFarm.Checked)
		{
	        $comboDatacenter.Enabled = $false
	        $comboCluster.Enabled = $false
	        $comboHost.Enabled = $false
	        $grpVC.Enabled = $true
	     }
		else
		{
	        if ($VIConnected)
	        {
	            PopulateVIDatacenters
	            $comboDatacenter.Enabled = $true
			}
	        $grpVC.Enabled = $false
		}
	}
	
	$chkCurrentUser_CheckedChanged={
	    if ($chkCurrentUser.Checked)
		{
	        $txtUser.Enabled = $false
	        $txtPassword.Enabled = $false
		}
		else
		{
	        $txtUser.Enabled = $true
	        $txtPassword.Enabled = $true
		}
	}
	
	$buttonConnect_Click={
	    $Snapins=@(’VMware.VimAutomation.Core’)
	    $RequiredSnapinsLoaded=$True 
	    if ($Snapins.Count -ge 1) 
	    {
	    	Foreach ($Snapin in $Snapins)
	    	{
	    		Add-PSSnapin $Snapin –ErrorAction SilentlyContinue 
	    		if ((Get-PSSnapin $Snapin) –eq $NULL) 
	    		{
	    			$RequiredSnapinsLoaded=$false
	    		} 
	     	}
	    }
	    if ($RequiredSnapinsLoaded) 
	    { 
	    	# Connect to the server
	        if ($chkCurrentUser.Checked)
	        {
	        	$VIConnection = Connect-VIServer $varVIServer -ErrorAction:SilentlyContinue
	        }
	        else
	        {
	        	$VIConnection = Connect-VIServer $txtvCenterServer.Text `
	             -User $txtUser.Text -Password $txtPassword.text -ErrorAction:SilentlyContinue
	        }
	        If ($VIConnection.IsConnected) 
	        {
	            $VIConnected = $true
	            $grpVMwareSettings.Enabled = $true
	    	}
	        else
	        {
	            $VIConnected = $false
	            $grpVMwareSettings.Enabled = $false
	    	}
	    }
	}
	
	$chkRptDatastore_CheckedChanged={
	    if ($chkRptHostsDatastore.Checked)
		{
	        $dialRptHostsDatastorePercent.Enabled = $true
		}
		else
		{
	        $dialRptHostsDatastorePercent.Enabled = $false
		}
	}
	
	$chkRptVMSnapshots_CheckedChanged={
	    if ($chkRptVMSnapshots.Checked)
		{
	        $dialRptVMSnapThresh.Enabled = $true
		}
		else
		{
	        $dialRptVMSnapThresh.Enabled = $false
		}
	}
	
	$comboCluster_SelectedIndexChanged={
		if ($comboCluster.Text -ne '')
	    {
	        $comboHost.Enabled = $true
	        PopulateVIHosts
		}
	    else
	    {
	        $comboHost.Enabled = $true
	        Load-ComboBox $comboHost ''
		}
	}
	
	$comboDatacenter_SelectedIndexChanged={
	    $comboCluster.Enabled = $true
	    PopulateVIClusters
	}
	$chkRptVCErrors_CheckedChanged={
		if ($chkRptVCErrors.Checked)
	    {
	        $chkRptVCVMsDeleted.Enabled = $true
	        $chkRptVCVMsCreated.Enabled = $true
		}
	    else
	    {
	        $chkRptVCVMsDeleted.Enabled = $false
	        $chkRptVCVMsCreated.Enabled = $false
		}
	}
		# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$MainForm.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
		$script:MainForm_txtvCenterServer = $txtvCenterServer.Text
		$script:MainForm_chkCurrentUser = $chkCurrentUser.Checked
		$script:MainForm_txtUser = $txtUser.Text
		$script:MainForm_comboHost = $comboHost.Text
		$script:MainForm_comboCluster = $comboCluster.Text
		$script:MainForm_comboDatacenter = $comboDatacenter.Text
		$script:MainForm_chkWholeFarm = $chkWholeFarm.Checked
		$script:MainForm_chkRptVCServices = $chkRptVCServices.Checked
		$script:MainForm_dialRptVCEventlogsAge = $dialRptVCEventlogsAge.Value
		$script:MainForm_chkRptVCEvtLogs = $chkRptVCEvtLogs.Checked
		$script:MainForm_dialRptVCErrorsAge = $dialRptVCErrorsAge.Value
		$script:MainForm_chkRptVCErrors = $chkRptVCErrors.Checked
		$script:MainForm_chkRptVCVMsDeleted = $chkRptVCVMsDeleted.Checked
		$script:MainForm_chkRptVCVMsCreated = $chkRptVCVMsCreated.Checked
		$script:MainForm_chkRptHostsInMaint = $chkRptHostsInMaint.Checked
		$script:MainForm_chkRptHostsNotResponding = $chkRptHostsNotResponding.Checked
		$script:MainForm_dialRptHostsDatastorePercent = $dialRptHostsDatastorePercent.Value
		$script:MainForm_chkRptHostsDatastore = $chkRptHostsDatastore.Checked
		$script:MainForm_chkRptSelective = $chkRptSelective.Checked
		$script:MainForm_chkRptVMFloppyConnected = $chkRptVMFloppyConnected.Checked
		$script:MainForm_chkRptVMCDConnected = $chkRptVMCDConnected.Checked
		$script:MainForm_chkRptVMTools = $chkRptVMTools.Checked
		$script:MainForm_chkRptVMThinProvisioned = $chkRptVMThinProvisioned.Checked
		$script:MainForm_dialRptVMSnapThresh = $dialRptVMSnapThresh.Value
		$script:MainForm_chkRptVMSnapshots = $chkRptVMSnapshots.Checked
		$script:MainForm_comboReportStyle = $comboReportStyle.Text
		$script:MainForm_txtEmailSubject = $txtEmailSubject.Text
		$script:MainForm_chkEmailReport = $chkEmailReport.Checked
		$script:MainForm_txtReportName = $txtReportName.Text
		$script:MainForm_chkSaveLocally = $chkSaveLocally.Checked
		$script:MainForm_txtReportFolder = $txtReportFolder.Text
		$script:MainForm_txtSMTPServer = $txtSMTPServer.Text
		$script:MainForm_txtEmailRecipient = $txtEmailRecipient.Text
		$script:MainForm_txtEmailSender = $txtEmailSender.Text
		$script:MainForm_richtextbox1 = $richtextbox1.Text
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonSave.remove_Click($buttonSave_Click)
			$buttonRun.remove_Click($buttonRun_Click)
			$buttonConnect.remove_Click($buttonConnect_Click)
			$chkCurrentUser.remove_CheckedChanged($chkCurrentUser_CheckedChanged)
			$comboCluster.remove_SelectedIndexChanged($comboCluster_SelectedIndexChanged)
			$comboDatacenter.remove_SelectedIndexChanged($comboDatacenter_SelectedIndexChanged)
			$chkWholeFarm.remove_CheckedChanged($chkWholeFarm_CheckedChanged)
			$chkRptVCErrors.remove_CheckedChanged($chkRptVCErrors_CheckedChanged)
			$chkRptVMSnapshots.remove_CheckedChanged($chkRptVMSnapshots_CheckedChanged)
			$chkEmailReport.remove_CheckedChanged($chkEmailReport_CheckedChanged)
			$chkSaveLocally.remove_CheckedChanged($chkSaveLocally_CheckedChanged)
			$buttonBrowseFolder.remove_Click($buttonBrowseFolder_Click)
			$MainForm.remove_Load($form1_FadeInLoad)
			$timerFadeIn.remove_Tick($timerFadeIn_Tick)
			$MainForm.remove_Load($Form_StateCorrection_Load)
			$MainForm.remove_Closing($Form_StoreValues_Closing)
			$MainForm.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch [Exception]
		{ }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	#
	# MainForm
	#
	$MainForm.Controls.Add($buttonCancel)
	$MainForm.Controls.Add($buttonSave)
	$MainForm.Controls.Add($buttonRun)
	$MainForm.Controls.Add($tabcontrol1)
	$MainForm.ClientSize = '445, 463'
	$MainForm.Name = "MainForm"
	$MainForm.StartPosition = 'CenterScreen'
	$MainForm.Text = "VMwareReport-GUI"
	$MainForm.add_Load($form1_FadeInLoad)
	#
	# buttonCancel
	#
	$buttonCancel.DialogResult = 'Cancel'
	$buttonCancel.Location = '363, 436'
	$buttonCancel.Name = "buttonCancel"
	$buttonCancel.Size = '75, 23'
	$buttonCancel.TabIndex = 202
	$buttonCancel.Text = "Cancel"
	$buttonCancel.UseVisualStyleBackColor = $True
	#
	# buttonSave
	#
	$buttonSave.Location = '282, 436'
	$buttonSave.Name = "buttonSave"
	$buttonSave.Size = '75, 23'
	$buttonSave.TabIndex = 201
	$buttonSave.Text = "Save"
	$buttonSave.UseVisualStyleBackColor = $True
	$buttonSave.add_Click($buttonSave_Click)
	#
	# buttonRun
	#
	$buttonRun.Location = '201, 436'
	$buttonRun.Name = "buttonRun"
	$buttonRun.Size = '75, 23'
	$buttonRun.TabIndex = 200
	$buttonRun.Text = "Run!"
	$tooltipAll.SetToolTip($buttonRun, "Saves configuration and runs the script.")
	$buttonRun.UseVisualStyleBackColor = $True
	$buttonRun.add_Click($buttonRun_Click)
	#
	# tabcontrol1
	#
	$tabcontrol1.Controls.Add($tabpage1)
	$tabcontrol1.Controls.Add($tabpage6)
	$tabcontrol1.Controls.Add($tabpage2)
	$tabcontrol1.Controls.Add($tabpage5)
	$tabcontrol1.Location = '5, 4'
	$tabcontrol1.Name = "tabcontrol1"
	$tabcontrol1.SelectedIndex = 0
	$tabcontrol1.Size = '436, 430'
	$tabcontrol1.TabIndex = 40
	#
	# tabpage1
	#
	$tabpage1.Controls.Add($grpConnectionInfo)
	$tabpage1.Controls.Add($grpCredentials)
	$tabpage1.Controls.Add($grpVMwareSettings)
	$tabpage1.BackColor = 'ControlLight'
	$tabpage1.Location = '4, 22'
	$tabpage1.Name = "tabpage1"
	$tabpage1.Padding = '3, 3, 3, 3'
	$tabpage1.Size = '428, 404'
	$tabpage1.TabIndex = 0
	$tabpage1.Text = "Script Settings"
	#
	# grpConnectionInfo
	#
	$grpConnectionInfo.Controls.Add($lblConnectHost)
	$grpConnectionInfo.Controls.Add($lblConnectCluster)
	$grpConnectionInfo.Controls.Add($lblConnectDatacenter)
	$grpConnectionInfo.Controls.Add($lblConnectServer)
	$grpConnectionInfo.Controls.Add($lblConnectLogon)
	$grpConnectionInfo.Controls.Add($label3)
	$grpConnectionInfo.Controls.Add($label4)
	$grpConnectionInfo.Controls.Add($label2)
	$grpConnectionInfo.Controls.Add($label1)
	$grpConnectionInfo.Controls.Add($labelLogon)
	$grpConnectionInfo.Location = '7, 240'
	$grpConnectionInfo.Name = "grpConnectionInfo"
	$grpConnectionInfo.Size = '407, 158'
	$grpConnectionInfo.TabIndex = 3
	$grpConnectionInfo.TabStop = $False
	$grpConnectionInfo.Text = "Saved Connection Info (Last Valid Save)"
	#
	# lblConnectHost
	#
	$lblConnectHost.BorderStyle = 'FixedSingle'
	$lblConnectHost.Font = "Microsoft Sans Serif, 8.25pt, style=Italic"
	$lblConnectHost.Location = '92, 105'
	$lblConnectHost.Name = "lblConnectHost"
	$lblConnectHost.Size = '307, 20'
	$lblConnectHost.TabIndex = 99
	$lblConnectHost.Text = "NA"
	$lblConnectHost.TextAlign = 'MiddleLeft'
	#
	# lblConnectCluster
	#
	$lblConnectCluster.BorderStyle = 'FixedSingle'
	$lblConnectCluster.Font = "Microsoft Sans Serif, 8.25pt, style=Italic"
	$lblConnectCluster.Location = '92, 85'
	$lblConnectCluster.Name = "lblConnectCluster"
	$lblConnectCluster.Size = '307, 20'
	$lblConnectCluster.TabIndex = 98
	$lblConnectCluster.Text = "NA"
	$lblConnectCluster.TextAlign = 'MiddleLeft'
	#
	# lblConnectDatacenter
	#
	$lblConnectDatacenter.BorderStyle = 'FixedSingle'
	$lblConnectDatacenter.Font = "Microsoft Sans Serif, 8.25pt, style=Italic"
	$lblConnectDatacenter.Location = '92, 64'
	$lblConnectDatacenter.Name = "lblConnectDatacenter"
	$lblConnectDatacenter.Size = '307, 21'
	$lblConnectDatacenter.TabIndex = 97
	$lblConnectDatacenter.Text = "NA"
	$lblConnectDatacenter.TextAlign = 'MiddleLeft'
	#
	# lblConnectServer
	#
	$lblConnectServer.BorderStyle = 'FixedSingle'
	$lblConnectServer.Font = "Microsoft Sans Serif, 8.25pt, style=Italic"
	$lblConnectServer.Location = '92, 23'
	$lblConnectServer.Name = "lblConnectServer"
	$lblConnectServer.Size = '307, 20'
	$lblConnectServer.TabIndex = 96
	$lblConnectServer.Text = "NA"
	$lblConnectServer.TextAlign = 'MiddleLeft'
	#
	# lblConnectLogon
	#
	$lblConnectLogon.BorderStyle = 'FixedSingle'
	$lblConnectLogon.Font = "Microsoft Sans Serif, 8.25pt, style=Italic"
	$lblConnectLogon.Location = '92, 43'
	$lblConnectLogon.Name = "lblConnectLogon"
	$lblConnectLogon.Size = '307, 21'
	$lblConnectLogon.TabIndex = 95
	$lblConnectLogon.Text = "NA"
	$lblConnectLogon.TextAlign = 'MiddleLeft'
	#
	# label3
	#
	$label3.BorderStyle = 'FixedSingle'
	$label3.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$label3.Location = '6, 105'
	$label3.Name = "label3"
	$label3.Size = '80, 20'
	$label3.TabIndex = 94
	$label3.Text = "Host:"
	$label3.TextAlign = 'MiddleRight'
	#
	# label4
	#
	$label4.BorderStyle = 'FixedSingle'
	$label4.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$label4.Location = '6, 85'
	$label4.Name = "label4"
	$label4.Size = '80, 20'
	$label4.TabIndex = 93
	$label4.Text = "Cluster:"
	$label4.TextAlign = 'MiddleRight'
	#
	# label2
	#
	$label2.BorderStyle = 'FixedSingle'
	$label2.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$label2.Location = '6, 64'
	$label2.Name = "label2"
	$label2.Size = '80, 21'
	$label2.TabIndex = 92
	$label2.Text = "Datacenter:"
	$label2.TextAlign = 'MiddleRight'
	#
	# label1
	#
	$label1.BorderStyle = 'FixedSingle'
	$label1.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$label1.Location = '6, 23'
	$label1.Name = "label1"
	$label1.Size = '80, 20'
	$label1.TabIndex = 91
	$label1.Text = "Server:"
	$label1.TextAlign = 'MiddleRight'
	#
	# labelLogon
	#
	$labelLogon.BorderStyle = 'FixedSingle'
	$labelLogon.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelLogon.Location = '6, 43'
	$labelLogon.Name = "labelLogon"
	$labelLogon.Size = '80, 21'
	$labelLogon.TabIndex = 89
	$labelLogon.Text = "Logon:"
	$labelLogon.TextAlign = 'MiddleRight'
	#
	# grpCredentials
	#
	$grpCredentials.Controls.Add($txtvCenterServer)
	$grpCredentials.Controls.Add($labelServer)
	$grpCredentials.Controls.Add($buttonConnect)
	$grpCredentials.Controls.Add($chkCurrentUser)
	$grpCredentials.Controls.Add($labelCurrentUser)
	$grpCredentials.Controls.Add($txtUser)
	$grpCredentials.Controls.Add($txtPassword)
	$grpCredentials.Controls.Add($labelUser)
	$grpCredentials.Controls.Add($labelPassword)
	$grpCredentials.Location = '6, 6'
	$grpCredentials.Name = "grpCredentials"
	$grpCredentials.Size = '409, 110'
	$grpCredentials.TabIndex = 1
	$grpCredentials.TabStop = $False
	$grpCredentials.Text = "Credentials"
	#
	# txtvCenterServer
	#
	$txtvCenterServer.Location = '102, 15'
	$txtvCenterServer.Name = "txtvCenterServer"
	$txtvCenterServer.Size = '211, 20'
	$txtvCenterServer.TabIndex = 0
	$txtvCenterServer.Text = "localhost"
	#
	# labelServer
	#
	$labelServer.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelServer.Location = '35, 15'
	$labelServer.Name = "labelServer"
	$labelServer.Size = '51, 20'
	$labelServer.TabIndex = 88
	$labelServer.Text = "Server"
	$labelServer.TextAlign = 'MiddleRight'
	#
	# buttonConnect
	#
	$buttonConnect.Location = '327, 81'
	$buttonConnect.Name = "buttonConnect"
	$buttonConnect.Size = '73, 23'
	$buttonConnect.TabIndex = 4
	$buttonConnect.Text = "Connect!"
	$buttonConnect.UseVisualStyleBackColor = $True
	$buttonConnect.add_Click($buttonConnect_Click)
	#
	# chkCurrentUser
	#
	$chkCurrentUser.Checked = $True
	$chkCurrentUser.CheckState = 'Checked'
	$chkCurrentUser.Location = '102, 38'
	$chkCurrentUser.Name = "chkCurrentUser"
	$chkCurrentUser.Size = '16, 20'
	$chkCurrentUser.TabIndex = 1
	$chkCurrentUser.UseVisualStyleBackColor = $True
	$chkCurrentUser.add_CheckedChanged($chkCurrentUser_CheckedChanged)
	#
	# labelCurrentUser
	#
	$labelCurrentUser.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelCurrentUser.Location = '3, 38'
	$labelCurrentUser.Name = "labelCurrentUser"
	$labelCurrentUser.Size = '83, 20'
	$labelCurrentUser.TabIndex = 85
	$labelCurrentUser.Text = "Current User"
	$labelCurrentUser.TextAlign = 'MiddleRight'
	#
	# txtUser
	#
	$txtUser.Enabled = $False
	$txtUser.Location = '102, 58'
	$txtUser.Name = "txtUser"
	$txtUser.Size = '211, 20'
	$txtUser.TabIndex = 2
	#
	# txtPassword
	#
	$txtPassword.Enabled = $False
	$txtPassword.Location = '102, 84'
	$txtPassword.Name = "txtPassword"
	$txtPassword.Size = '212, 20'
	$txtPassword.TabIndex = 3
	#
	# labelUser
	#
	$labelUser.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelUser.Location = '24, 58'
	$labelUser.Name = "labelUser"
	$labelUser.Size = '63, 21'
	$labelUser.TabIndex = 80
	$labelUser.Text = "User"
	$labelUser.TextAlign = 'MiddleRight'
	#
	# labelPassword
	#
	$labelPassword.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelPassword.Location = '23, 86'
	$labelPassword.Name = "labelPassword"
	$labelPassword.Size = '63, 20'
	$labelPassword.TabIndex = 81
	$labelPassword.Text = "Password"
	$labelPassword.TextAlign = 'MiddleRight'
	#
	# grpVMwareSettings
	#
	$grpVMwareSettings.Controls.Add($comboHost)
	$grpVMwareSettings.Controls.Add($labelHost)
	$grpVMwareSettings.Controls.Add($comboCluster)
	$grpVMwareSettings.Controls.Add($comboDatacenter)
	$grpVMwareSettings.Controls.Add($chkWholeFarm)
	$grpVMwareSettings.Controls.Add($labelCluster)
	$grpVMwareSettings.Controls.Add($labelWholeFarm)
	$grpVMwareSettings.Controls.Add($labelDatacenter)
	$grpVMwareSettings.Enabled = $False
	$grpVMwareSettings.Location = '7, 122'
	$grpVMwareSettings.Name = "grpVMwareSettings"
	$grpVMwareSettings.Size = '408, 114'
	$grpVMwareSettings.TabIndex = 2
	$grpVMwareSettings.TabStop = $False
	$grpVMwareSettings.Text = "Scope"
	#
	# comboHost
	#
	$comboHost.DropDownStyle = 'DropDownList'
	$comboHost.Enabled = $False
	$comboHost.FormattingEnabled = $True
	$comboHost.Location = '101, 89'
	$comboHost.Name = "comboHost"
	$comboHost.Size = '298, 21'
	$comboHost.Sorted = $True
	$comboHost.TabIndex = 8
	#
	# labelHost
	#
	$labelHost.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelHost.Location = '13, 91'
	$labelHost.Name = "labelHost"
	$labelHost.Size = '72, 20'
	$labelHost.TabIndex = 88
	$labelHost.Text = "Host"
	$labelHost.TextAlign = 'MiddleRight'
	#
	# comboCluster
	#
	$comboCluster.DropDownStyle = 'DropDownList'
	$comboCluster.Enabled = $False
	$comboCluster.FormattingEnabled = $True
	$comboCluster.Location = '101, 62'
	$comboCluster.Name = "comboCluster"
	$comboCluster.Size = '298, 21'
	$comboCluster.TabIndex = 7
	$comboCluster.add_SelectedIndexChanged($comboCluster_SelectedIndexChanged)
	#
	# comboDatacenter
	#
	$comboDatacenter.DropDownStyle = 'DropDownList'
	$comboDatacenter.Enabled = $False
	$comboDatacenter.FormattingEnabled = $True
	$comboDatacenter.Location = '101, 35'
	$comboDatacenter.Name = "comboDatacenter"
	$comboDatacenter.Size = '298, 21'
	$comboDatacenter.TabIndex = 6
	$comboDatacenter.add_SelectedIndexChanged($comboDatacenter_SelectedIndexChanged)
	#
	# chkWholeFarm
	#
	$chkWholeFarm.Checked = $True
	$chkWholeFarm.CheckState = 'Checked'
	$chkWholeFarm.Location = '102, 12'
	$chkWholeFarm.Name = "chkWholeFarm"
	$chkWholeFarm.Size = '19, 24'
	$chkWholeFarm.TabIndex = 5
	$chkWholeFarm.UseVisualStyleBackColor = $True
	$chkWholeFarm.add_CheckedChanged($chkWholeFarm_CheckedChanged)
	#
	# labelCluster
	#
	$labelCluster.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelCluster.Location = '13, 64'
	$labelCluster.Name = "labelCluster"
	$labelCluster.Size = '72, 20'
	$labelCluster.TabIndex = 83
	$labelCluster.Text = "Cluster"
	$labelCluster.TextAlign = 'MiddleRight'
	#
	# labelWholeFarm
	#
	$labelWholeFarm.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelWholeFarm.Location = '10, 13'
	$labelWholeFarm.Name = "labelWholeFarm"
	$labelWholeFarm.Size = '76, 20'
	$labelWholeFarm.TabIndex = 82
	$labelWholeFarm.Text = "Whole Farm"
	$labelWholeFarm.TextAlign = 'MiddleRight'
	#
	# labelDatacenter
	#
	$labelDatacenter.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelDatacenter.Location = '13, 34'
	$labelDatacenter.Name = "labelDatacenter"
	$labelDatacenter.Size = '72, 20'
	$labelDatacenter.TabIndex = 81
	$labelDatacenter.Text = "Datacenter"
	$labelDatacenter.TextAlign = 'MiddleRight'
	#
	# tabpage6
	#
	$tabpage6.Controls.Add($grpVC)
	$tabpage6.Controls.Add($grpHosts)
	$tabpage6.Controls.Add($grpReportGeneral)
	$tabpage6.Controls.Add($groupbox3)
	$tabpage6.BackColor = 'ControlLight'
	$tabpage6.Location = '4, 22'
	$tabpage6.Name = "tabpage6"
	$tabpage6.Size = '428, 404'
	$tabpage6.TabIndex = 5
	$tabpage6.Text = "Report Options"
	#
	# grpVC
	#
	$grpVC.Controls.Add($chkRptVCServices)
	$grpVC.Controls.Add($labelVCServiceStatus)
	$grpVC.Controls.Add($dialRptVCEventlogsAge)
	$grpVC.Controls.Add($labelWindowsEventLogError)
	$grpVC.Controls.Add($chkRptVCEvtLogs)
	$grpVC.Controls.Add($labelEventLogErrWarn)
	$grpVC.Controls.Add($dialRptVCErrorsAge)
	$grpVC.Controls.Add($labelVCErrorEventsTheshol)
	$grpVC.Controls.Add($chkRptVCErrors)
	$grpVC.Controls.Add($labelVCEventErrors)
	$grpVC.Controls.Add($chkRptVCVMsDeleted)
	$grpVC.Controls.Add($labelVMsDeleted)
	$grpVC.Controls.Add($chkRptVCVMsCreated)
	$grpVC.Controls.Add($labelVMsCreatedCloned)
	$grpVC.Location = '3, 59'
	$grpVC.Name = "grpVC"
	$grpVC.Size = '413, 130'
	$grpVC.TabIndex = 1
	$grpVC.TabStop = $False
	$grpVC.Text = "Virtual Center"
	#
	# chkRptVCServices
	#
	$chkRptVCServices.Checked = $True
	$chkRptVCServices.CheckState = 'Checked'
	$chkRptVCServices.Location = '148, 97'
	$chkRptVCServices.Name = "chkRptVCServices"
	$chkRptVCServices.Size = '20, 24'
	$chkRptVCServices.TabIndex = 7
	$chkRptVCServices.UseVisualStyleBackColor = $True
	#
	# labelVCServiceStatus
	#
	$labelVCServiceStatus.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelVCServiceStatus.Location = '11, 97'
	$labelVCServiceStatus.Name = "labelVCServiceStatus"
	$labelVCServiceStatus.Size = '131, 23'
	$labelVCServiceStatus.TabIndex = 122
	$labelVCServiceStatus.Text = "VC Service Status"
	$labelVCServiceStatus.TextAlign = 'MiddleRight'
	#
	# dialRptVCEventlogsAge
	#
	$dialRptVCEventlogsAge.Location = '331, 80'
	$dialRptVCEventlogsAge.Name = "dialRptVCEventlogsAge"
	$dialRptVCEventlogsAge.Size = '37, 20'
	$dialRptVCEventlogsAge.TabIndex = 6
	$tooltipAll.SetToolTip($dialRptVCEventlogsAge, "Amount of days to report.")
	$dialRptVCEventlogsAge.Value = 3
	#
	# labelWindowsEventLogError
	#
	$labelWindowsEventLogError.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelWindowsEventLogError.Location = '168, 67'
	$labelWindowsEventLogError.Name = "labelWindowsEventLogError"
	$labelWindowsEventLogError.Size = '159, 40'
	$labelWindowsEventLogError.TabIndex = 120
	$labelWindowsEventLogError.Text = "Windows Event Log Error/Warning Threshold"
	$labelWindowsEventLogError.TextAlign = 'MiddleRight'
	#
	# chkRptVCEvtLogs
	#
	$chkRptVCEvtLogs.Checked = $True
	$chkRptVCEvtLogs.CheckState = 'Checked'
	$chkRptVCEvtLogs.Location = '148, 76'
	$chkRptVCEvtLogs.Name = "chkRptVCEvtLogs"
	$chkRptVCEvtLogs.Size = '20, 24'
	$chkRptVCEvtLogs.TabIndex = 5
	$chkRptVCEvtLogs.UseVisualStyleBackColor = $True
	#
	# labelEventLogErrWarn
	#
	$labelEventLogErrWarn.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelEventLogErrWarn.Location = '11, 76'
	$labelEventLogErrWarn.Name = "labelEventLogErrWarn"
	$labelEventLogErrWarn.Size = '131, 23'
	$labelEventLogErrWarn.TabIndex = 119
	$labelEventLogErrWarn.Text = "Event Log Err/Warn"
	$labelEventLogErrWarn.TextAlign = 'MiddleRight'
	#
	# dialRptVCErrorsAge
	#
	$dialRptVCErrorsAge.Location = '331, 20'
	$dialRptVCErrorsAge.Name = "dialRptVCErrorsAge"
	$dialRptVCErrorsAge.Size = '37, 20'
	$dialRptVCErrorsAge.TabIndex = 2
	$tooltipAll.SetToolTip($dialRptVCErrorsAge, "Amount of days to report for added/removed VMs or VC errors.")
	$dialRptVCErrorsAge.Value = 3
	#
	# labelVCErrorEventsTheshol
	#
	$labelVCErrorEventsTheshol.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelVCErrorEventsTheshol.Location = '166, 19'
	$labelVCErrorEventsTheshol.Name = "labelVCErrorEventsTheshol"
	$labelVCErrorEventsTheshol.Size = '159, 24'
	$labelVCErrorEventsTheshol.TabIndex = 112
	$labelVCErrorEventsTheshol.Text = "VC Error Events Theshold"
	$labelVCErrorEventsTheshol.TextAlign = 'MiddleRight'
	#
	# chkRptVCErrors
	#
	$chkRptVCErrors.Checked = $True
	$chkRptVCErrors.CheckState = 'Checked'
	$chkRptVCErrors.Location = '148, 19'
	$chkRptVCErrors.Name = "chkRptVCErrors"
	$chkRptVCErrors.Size = '20, 20'
	$chkRptVCErrors.TabIndex = 1
	$chkRptVCErrors.UseVisualStyleBackColor = $True
	$chkRptVCErrors.add_CheckedChanged($chkRptVCErrors_CheckedChanged)
	#
	# labelVCEventErrors
	#
	$labelVCEventErrors.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelVCEventErrors.Location = '11, 17'
	$labelVCEventErrors.Name = "labelVCEventErrors"
	$labelVCEventErrors.Size = '131, 23'
	$labelVCEventErrors.TabIndex = 108
	$labelVCEventErrors.Text = "VC Event Errors"
	$labelVCEventErrors.TextAlign = 'MiddleRight'
	#
	# chkRptVCVMsDeleted
	#
	$chkRptVCVMsDeleted.Checked = $True
	$chkRptVCVMsDeleted.CheckState = 'Checked'
	$chkRptVCVMsDeleted.Location = '148, 57'
	$chkRptVCVMsDeleted.Name = "chkRptVCVMsDeleted"
	$chkRptVCVMsDeleted.Size = '20, 24'
	$chkRptVCVMsDeleted.TabIndex = 4
	$chkRptVCVMsDeleted.UseVisualStyleBackColor = $True
	#
	# labelVMsDeleted
	#
	$labelVMsDeleted.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelVMsDeleted.Location = '11, 57'
	$labelVMsDeleted.Name = "labelVMsDeleted"
	$labelVMsDeleted.Size = '131, 23'
	$labelVMsDeleted.TabIndex = 106
	$labelVMsDeleted.Text = "VMs Deleted"
	$labelVMsDeleted.TextAlign = 'MiddleRight'
	#
	# chkRptVCVMsCreated
	#
	$chkRptVCVMsCreated.Checked = $True
	$chkRptVCVMsCreated.CheckState = 'Checked'
	$chkRptVCVMsCreated.Location = '148, 41'
	$chkRptVCVMsCreated.Name = "chkRptVCVMsCreated"
	$chkRptVCVMsCreated.Size = '20, 16'
	$chkRptVCVMsCreated.TabIndex = 3
	$chkRptVCVMsCreated.UseVisualStyleBackColor = $True
	#
	# labelVMsCreatedCloned
	#
	$labelVMsCreatedCloned.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelVMsCreatedCloned.Location = '11, 36'
	$labelVMsCreatedCloned.Name = "labelVMsCreatedCloned"
	$labelVMsCreatedCloned.Size = '131, 24'
	$labelVMsCreatedCloned.TabIndex = 104
	$labelVMsCreatedCloned.Text = "VMs Created/Cloned"
	$labelVMsCreatedCloned.TextAlign = 'MiddleRight'
	#
	# grpHosts
	#
	$grpHosts.Controls.Add($chkRptHostsInMaint)
	$grpHosts.Controls.Add($labelInMaintinance)
	$grpHosts.Controls.Add($chkRptHostsNotResponding)
	$grpHosts.Controls.Add($dialRptHostsDatastorePercent)
	$grpHosts.Controls.Add($labelNotResponding)
	$grpHosts.Controls.Add($chkRptHostsDatastore)
	$grpHosts.Controls.Add($labelFreeThreshold)
	$grpHosts.Controls.Add($labelDatastoreUtilization)
	$grpHosts.Location = '5, 195'
	$grpHosts.Name = "grpHosts"
	$grpHosts.Size = '414, 63'
	$grpHosts.TabIndex = 2
	$grpHosts.TabStop = $False
	$grpHosts.Text = "Hosts"
	#
	# chkRptHostsInMaint
	#
	$chkRptHostsInMaint.Checked = $True
	$chkRptHostsInMaint.CheckState = 'Checked'
	$chkRptHostsInMaint.Location = '333, 14'
	$chkRptHostsInMaint.Name = "chkRptHostsInMaint"
	$chkRptHostsInMaint.Size = '20, 24'
	$chkRptHostsInMaint.TabIndex = 5
	$chkRptHostsInMaint.UseVisualStyleBackColor = $True
	#
	# labelInMaintinance
	#
	$labelInMaintinance.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelInMaintinance.Location = '196, 15'
	$labelInMaintinance.Name = "labelInMaintinance"
	$labelInMaintinance.Size = '129, 20'
	$labelInMaintinance.TabIndex = 104
	$labelInMaintinance.Text = "In Maintinance"
	$labelInMaintinance.TextAlign = 'MiddleRight'
	#
	# chkRptHostsNotResponding
	#
	$chkRptHostsNotResponding.Checked = $True
	$chkRptHostsNotResponding.CheckState = 'Checked'
	$chkRptHostsNotResponding.Location = '150, 14'
	$chkRptHostsNotResponding.Name = "chkRptHostsNotResponding"
	$chkRptHostsNotResponding.Size = '18, 24'
	$chkRptHostsNotResponding.TabIndex = 4
	$chkRptHostsNotResponding.UseVisualStyleBackColor = $True
	#
	# dialRptHostsDatastorePercent
	#
	$dialRptHostsDatastorePercent.Location = '331, 37'
	$dialRptHostsDatastorePercent.Name = "dialRptHostsDatastorePercent"
	$dialRptHostsDatastorePercent.Size = '37, 20'
	$dialRptHostsDatastorePercent.TabIndex = 7
	$dialRptHostsDatastorePercent.Value = 10
	#
	# labelNotResponding
	#
	$labelNotResponding.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelNotResponding.Location = '13, 15'
	$labelNotResponding.Name = "labelNotResponding"
	$labelNotResponding.Size = '129, 20'
	$labelNotResponding.TabIndex = 102
	$labelNotResponding.Text = "Not Responding"
	$labelNotResponding.TextAlign = 'MiddleRight'
	#
	# chkRptHostsDatastore
	#
	$chkRptHostsDatastore.Checked = $True
	$chkRptHostsDatastore.CheckState = 'Checked'
	$chkRptHostsDatastore.Location = '150, 35'
	$chkRptHostsDatastore.Name = "chkRptHostsDatastore"
	$chkRptHostsDatastore.Size = '18, 24'
	$chkRptHostsDatastore.TabIndex = 6
	$chkRptHostsDatastore.UseVisualStyleBackColor = $True
	#
	# labelFreeThreshold
	#
	$labelFreeThreshold.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelFreeThreshold.Location = '215, 35'
	$labelFreeThreshold.Name = "labelFreeThreshold"
	$labelFreeThreshold.Size = '110, 20'
	$labelFreeThreshold.TabIndex = 94
	$labelFreeThreshold.Text = "% Free Threshold"
	$labelFreeThreshold.TextAlign = 'MiddleRight'
	#
	# labelDatastoreUtilization
	#
	$labelDatastoreUtilization.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelDatastoreUtilization.Location = '7, 35'
	$labelDatastoreUtilization.Name = "labelDatastoreUtilization"
	$labelDatastoreUtilization.Size = '135, 20'
	$labelDatastoreUtilization.TabIndex = 93
	$labelDatastoreUtilization.Text = "Datastore Utilization"
	$labelDatastoreUtilization.TextAlign = 'MiddleRight'
	#
	# grpReportGeneral
	#
	$grpReportGeneral.Controls.Add($chkRptSelective)
	$grpReportGeneral.Controls.Add($labelGenerateReportOnlyWh)
	$grpReportGeneral.Location = '3, 12'
	$grpReportGeneral.Name = "grpReportGeneral"
	$grpReportGeneral.Size = '416, 44'
	$grpReportGeneral.TabIndex = 0
	$grpReportGeneral.TabStop = $False
	$grpReportGeneral.Text = "General"
	#
	# chkRptSelective
	#
	$chkRptSelective.Checked = $True
	$chkRptSelective.CheckState = 'Checked'
	$chkRptSelective.Location = '331, 20'
	$chkRptSelective.Name = "chkRptSelective"
	$chkRptSelective.Size = '18, 18'
	$chkRptSelective.TabIndex = 0
	$tooltipAll.SetToolTip($chkRptSelective, "This only applies to datastore space and snapshot age. ")
	$chkRptSelective.UseVisualStyleBackColor = $True
	#
	# labelGenerateReportOnlyWh
	#
	$labelGenerateReportOnlyWh.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelGenerateReportOnlyWh.Location = '7, 16'
	$labelGenerateReportOnlyWh.Name = "labelGenerateReportOnlyWh"
	$labelGenerateReportOnlyWh.Size = '308, 20'
	$labelGenerateReportOnlyWh.TabIndex = 93
	$labelGenerateReportOnlyWh.Text = "Generate Report Only When Thresholds Surpassed"
	$labelGenerateReportOnlyWh.TextAlign = 'MiddleRight'
	#
	# groupbox3
	#
	$groupbox3.Controls.Add($chkRptVMFloppyConnected)
	$groupbox3.Controls.Add($labelFloppyConnected)
	$groupbox3.Controls.Add($chkRptVMCDConnected)
	$groupbox3.Controls.Add($labelCDConnected)
	$groupbox3.Controls.Add($chkRptVMTools)
	$groupbox3.Controls.Add($labelNoVMwareTools)
	$groupbox3.Controls.Add($chkRptVMThinProvisioned)
	$groupbox3.Controls.Add($labelThinProvisioned)
	$groupbox3.Controls.Add($dialRptVMSnapThresh)
	$groupbox3.Controls.Add($chkRptVMSnapshots)
	$groupbox3.Controls.Add($labelSnapshotThreshold)
	$groupbox3.Controls.Add($labelSnapshots)
	$groupbox3.Location = '3, 264'
	$groupbox3.Name = "groupbox3"
	$groupbox3.Size = '416, 78'
	$groupbox3.TabIndex = 3
	$groupbox3.TabStop = $False
	$groupbox3.Text = "Virtual Machines"
	#
	# chkRptVMFloppyConnected
	#
	$chkRptVMFloppyConnected.Checked = $True
	$chkRptVMFloppyConnected.CheckState = 'Checked'
	$chkRptVMFloppyConnected.Location = '330, 53'
	$chkRptVMFloppyConnected.Name = "chkRptVMFloppyConnected"
	$chkRptVMFloppyConnected.Size = '18, 20'
	$chkRptVMFloppyConnected.TabIndex = 6
	$chkRptVMFloppyConnected.UseVisualStyleBackColor = $True
	#
	# labelFloppyConnected
	#
	$labelFloppyConnected.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelFloppyConnected.Location = '189, 53'
	$labelFloppyConnected.Name = "labelFloppyConnected"
	$labelFloppyConnected.Size = '135, 20'
	$labelFloppyConnected.TabIndex = 100
	$labelFloppyConnected.Text = "Floppy Connected"
	$labelFloppyConnected.TextAlign = 'MiddleRight'
	#
	# chkRptVMCDConnected
	#
	$chkRptVMCDConnected.Checked = $True
	$chkRptVMCDConnected.CheckState = 'Checked'
	$chkRptVMCDConnected.Location = '330, 34'
	$chkRptVMCDConnected.Name = "chkRptVMCDConnected"
	$chkRptVMCDConnected.Size = '18, 20'
	$chkRptVMCDConnected.TabIndex = 4
	$chkRptVMCDConnected.UseVisualStyleBackColor = $True
	#
	# labelCDConnected
	#
	$labelCDConnected.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelCDConnected.Location = '189, 33'
	$labelCDConnected.Name = "labelCDConnected"
	$labelCDConnected.Size = '135, 20'
	$labelCDConnected.TabIndex = 98
	$labelCDConnected.Text = "CD Connected"
	$labelCDConnected.TextAlign = 'MiddleRight'
	#
	# chkRptVMTools
	#
	$chkRptVMTools.Checked = $True
	$chkRptVMTools.CheckState = 'Checked'
	$chkRptVMTools.Location = '149, 53'
	$chkRptVMTools.Name = "chkRptVMTools"
	$chkRptVMTools.Size = '18, 20'
	$chkRptVMTools.TabIndex = 5
	$chkRptVMTools.UseVisualStyleBackColor = $True
	#
	# labelNoVMwareTools
	#
	$labelNoVMwareTools.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelNoVMwareTools.Location = '6, 53'
	$labelNoVMwareTools.Name = "labelNoVMwareTools"
	$labelNoVMwareTools.Size = '135, 20'
	$labelNoVMwareTools.TabIndex = 96
	$labelNoVMwareTools.Text = "No VMware Tools"
	$labelNoVMwareTools.TextAlign = 'MiddleRight'
	#
	# chkRptVMThinProvisioned
	#
	$chkRptVMThinProvisioned.Checked = $True
	$chkRptVMThinProvisioned.CheckState = 'Checked'
	$chkRptVMThinProvisioned.Location = '149, 33'
	$chkRptVMThinProvisioned.Name = "chkRptVMThinProvisioned"
	$chkRptVMThinProvisioned.Size = '18, 24'
	$chkRptVMThinProvisioned.TabIndex = 3
	$chkRptVMThinProvisioned.UseVisualStyleBackColor = $True
	#
	# labelThinProvisioned
	#
	$labelThinProvisioned.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelThinProvisioned.Location = '6, 33'
	$labelThinProvisioned.Name = "labelThinProvisioned"
	$labelThinProvisioned.Size = '135, 20'
	$labelThinProvisioned.TabIndex = 94
	$labelThinProvisioned.Text = "Thin Provisioned"
	$labelThinProvisioned.TextAlign = 'MiddleRight'
	#
	# dialRptVMSnapThresh
	#
	$dialRptVMSnapThresh.Location = '330, 13'
	$dialRptVMSnapThresh.Maximum = 180
	$dialRptVMSnapThresh.Name = "dialRptVMSnapThresh"
	$dialRptVMSnapThresh.Size = '37, 20'
	$dialRptVMSnapThresh.TabIndex = 2
	$dialRptVMSnapThresh.Value = 2
	#
	# chkRptVMSnapshots
	#
	$chkRptVMSnapshots.Checked = $True
	$chkRptVMSnapshots.CheckState = 'Checked'
	$chkRptVMSnapshots.Location = '149, 13'
	$chkRptVMSnapshots.Name = "chkRptVMSnapshots"
	$chkRptVMSnapshots.Size = '18, 24'
	$chkRptVMSnapshots.TabIndex = 1
	$chkRptVMSnapshots.UseVisualStyleBackColor = $True
	$chkRptVMSnapshots.add_CheckedChanged($chkRptVMSnapshots_CheckedChanged)
	#
	# labelSnapshotThreshold
	#
	$labelSnapshotThreshold.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelSnapshotThreshold.Location = '197, 13'
	$labelSnapshotThreshold.Name = "labelSnapshotThreshold"
	$labelSnapshotThreshold.Size = '127, 20'
	$labelSnapshotThreshold.TabIndex = 89
	$labelSnapshotThreshold.Text = "Snapshot Threshold"
	$labelSnapshotThreshold.TextAlign = 'MiddleRight'
	#
	# labelSnapshots
	#
	$labelSnapshots.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelSnapshots.Location = '6, 13'
	$labelSnapshots.Name = "labelSnapshots"
	$labelSnapshots.Size = '135, 20'
	$labelSnapshots.TabIndex = 88
	$labelSnapshots.Text = "Snapshots"
	$labelSnapshots.TextAlign = 'MiddleRight'
	#
	# tabpage2
	#
	$tabpage2.Controls.Add($grpSchedule)
	$tabpage2.Controls.Add($grpReportFormat)
	$tabpage2.Controls.Add($groupbox1)
	$tabpage2.BackColor = 'ControlLight'
	$tabpage2.Location = '4, 22'
	$tabpage2.Name = "tabpage2"
	$tabpage2.Padding = '3, 3, 3, 3'
	$tabpage2.Size = '428, 404'
	$tabpage2.TabIndex = 1
	$tabpage2.Text = "Delivery Options"
	#
	# grpSchedule
	#
	$grpSchedule.Location = '10, 259'
	$grpSchedule.Name = "grpSchedule"
	$grpSchedule.Size = '411, 85'
	$grpSchedule.TabIndex = 76
	$grpSchedule.TabStop = $False
	$grpSchedule.Text = "Schedule"
	#
	# grpReportFormat
	#
	$grpReportFormat.Controls.Add($labelReportStyle)
	$grpReportFormat.Controls.Add($comboReportStyle)
	$grpReportFormat.Location = '8, 344'
	$grpReportFormat.Name = "grpReportFormat"
	$grpReportFormat.Size = '414, 54'
	$grpReportFormat.TabIndex = 75
	$grpReportFormat.TabStop = $False
	$grpReportFormat.Text = "Format"
	$grpReportFormat.Visible = $False
	#
	# labelReportStyle
	#
	$labelReportStyle.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelReportStyle.Location = '3, 19'
	$labelReportStyle.Name = "labelReportStyle"
	$labelReportStyle.Size = '123, 20'
	$labelReportStyle.TabIndex = 80
	$labelReportStyle.Text = "Report Style"
	$labelReportStyle.TextAlign = 'MiddleRight'
	#
	# comboReportStyle
	#
	$comboReportStyle.DropDownStyle = 'DropDownList'
	$comboReportStyle.FormattingEnabled = $True
	[void]$comboReportStyle.Items.Add("Default")
	$comboReportStyle.Location = '143, 19'
	$comboReportStyle.Name = "comboReportStyle"
	$comboReportStyle.Size = '258, 21'
	$comboReportStyle.TabIndex = 0
	#
	# groupbox1
	#
	$groupbox1.Controls.Add($txtEmailSubject)
	$groupbox1.Controls.Add($labelSubject)
	$groupbox1.Controls.Add($labelEmailReport)
	$groupbox1.Controls.Add($chkEmailReport)
	$groupbox1.Controls.Add($labelReportName)
	$groupbox1.Controls.Add($labelSaveReport)
	$groupbox1.Controls.Add($txtReportName)
	$groupbox1.Controls.Add($labelReportFolder)
	$groupbox1.Controls.Add($chkSaveLocally)
	$groupbox1.Controls.Add($txtReportFolder)
	$groupbox1.Controls.Add($txtSMTPServer)
	$groupbox1.Controls.Add($buttonBrowseFolder)
	$groupbox1.Controls.Add($labelSMTPRelayServer)
	$groupbox1.Controls.Add($labelEmailSender)
	$groupbox1.Controls.Add($labelEmailRecipient)
	$groupbox1.Controls.Add($txtEmailRecipient)
	$groupbox1.Controls.Add($txtEmailSender)
	$groupbox1.BackColor = 'ControlLight'
	$groupbox1.FlatStyle = 'System'
	$groupbox1.Location = '9, 6'
	$groupbox1.Name = "groupbox1"
	$groupbox1.RightToLeft = 'No'
	$groupbox1.Size = '413, 247'
	$groupbox1.TabIndex = 74
	$groupbox1.TabStop = $False
	$groupbox1.Text = "Delivery"
	#
	# txtEmailSubject
	#
	$txtEmailSubject.Enabled = $False
	$txtEmailSubject.Location = '142, 61'
	$txtEmailSubject.Name = "txtEmailSubject"
	$txtEmailSubject.Size = '259, 20'
	$txtEmailSubject.TabIndex = 86
	#
	# labelSubject
	#
	$labelSubject.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelSubject.Location = '2, 60'
	$labelSubject.Name = "labelSubject"
	$labelSubject.Size = '123, 20'
	$labelSubject.TabIndex = 87
	$labelSubject.Text = "Subject"
	$labelSubject.TextAlign = 'MiddleRight'
	#
	# labelEmailReport
	#
	$labelEmailReport.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelEmailReport.Location = '35, 35'
	$labelEmailReport.Name = "labelEmailReport"
	$labelEmailReport.Size = '89, 20'
	$labelEmailReport.TabIndex = 85
	$labelEmailReport.Text = "Email Report"
	$labelEmailReport.TextAlign = 'MiddleRight'
	#
	# chkEmailReport
	#
	$chkEmailReport.Location = '142, 38'
	$chkEmailReport.Name = "chkEmailReport"
	$chkEmailReport.Size = '14, 17'
	$chkEmailReport.TabIndex = 84
	$chkEmailReport.UseVisualStyleBackColor = $True
	$chkEmailReport.add_CheckedChanged($chkEmailReport_CheckedChanged)
	#
	# labelReportName
	#
	$labelReportName.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelReportName.Location = '35, 187'
	$labelReportName.Name = "labelReportName"
	$labelReportName.Size = '89, 20'
	$labelReportName.TabIndex = 75
	$labelReportName.Text = "Report Name"
	$labelReportName.TextAlign = 'MiddleRight'
	#
	# labelSaveReport
	#
	$labelSaveReport.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelSaveReport.Location = '-3, 161'
	$labelSaveReport.Name = "labelSaveReport"
	$labelSaveReport.Size = '128, 20'
	$labelSaveReport.TabIndex = 82
	$labelSaveReport.Text = "Save Report"
	$labelSaveReport.TextAlign = 'MiddleRight'
	#
	# txtReportName
	#
	$txtReportName.Enabled = $False
	$txtReportName.Location = '142, 187'
	$txtReportName.Name = "txtReportName"
	$txtReportName.Size = '259, 20'
	$txtReportName.TabIndex = 83
	$txtReportName.Text = "Report.html"
	#
	# labelReportFolder
	#
	$labelReportFolder.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelReportFolder.Location = '35, 211'
	$labelReportFolder.Name = "labelReportFolder"
	$labelReportFolder.Size = '89, 20'
	$labelReportFolder.TabIndex = 80
	$labelReportFolder.Text = "Report Folder"
	$labelReportFolder.TextAlign = 'MiddleRight'
	#
	# chkSaveLocally
	#
	$chkSaveLocally.Location = '142, 164'
	$chkSaveLocally.Name = "chkSaveLocally"
	$chkSaveLocally.Size = '14, 17'
	$chkSaveLocally.TabIndex = 81
	$chkSaveLocally.UseVisualStyleBackColor = $True
	$chkSaveLocally.add_CheckedChanged($chkSaveLocally_CheckedChanged)
	#
	# txtReportFolder
	#
	$txtReportFolder.AutoCompleteMode = 'SuggestAppend'
	$txtReportFolder.AutoCompleteSource = 'FileSystemDirectories'
	$txtReportFolder.Enabled = $False
	$txtReportFolder.Location = '142, 213'
	$txtReportFolder.Name = "txtReportFolder"
	$txtReportFolder.Size = '223, 20'
	$txtReportFolder.TabIndex = 72
	$txtReportFolder.Text = "."
	#
	# txtSMTPServer
	#
	$txtSMTPServer.Enabled = $False
	$txtSMTPServer.Location = '142, 86'
	$txtSMTPServer.Name = "txtSMTPServer"
	$txtSMTPServer.Size = '259, 20'
	$txtSMTPServer.TabIndex = 74
	#
	# buttonBrowseFolder
	#
	$buttonBrowseFolder.Location = '371, 211'
	$buttonBrowseFolder.Name = "buttonBrowseFolder"
	$buttonBrowseFolder.Size = '30, 23'
	$buttonBrowseFolder.TabIndex = 73
	$buttonBrowseFolder.Text = "..."
	$buttonBrowseFolder.UseVisualStyleBackColor = $True
	$buttonBrowseFolder.add_Click($buttonBrowseFolder_Click)
	#
	# labelSMTPRelayServer
	#
	$labelSMTPRelayServer.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelSMTPRelayServer.Location = '2, 85'
	$labelSMTPRelayServer.Name = "labelSMTPRelayServer"
	$labelSMTPRelayServer.Size = '123, 20'
	$labelSMTPRelayServer.TabIndex = 75
	$labelSMTPRelayServer.Text = "SMTP Relay Server"
	$labelSMTPRelayServer.TextAlign = 'MiddleRight'
	#
	# labelEmailSender
	#
	$labelEmailSender.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelEmailSender.Location = '35, 137'
	$labelEmailSender.Name = "labelEmailSender"
	$labelEmailSender.Size = '90, 20'
	$labelEmailSender.TabIndex = 78
	$labelEmailSender.Text = "Email Sender"
	$labelEmailSender.TextAlign = 'MiddleRight'
	#
	# labelEmailRecipient
	#
	$labelEmailRecipient.Font = "Microsoft Sans Serif, 8.25pt, style=Bold"
	$labelEmailRecipient.Location = '2, 111'
	$labelEmailRecipient.Name = "labelEmailRecipient"
	$labelEmailRecipient.Size = '123, 20'
	$labelEmailRecipient.TabIndex = 79
	$labelEmailRecipient.Text = "Email Recipient"
	$labelEmailRecipient.TextAlign = 'MiddleRight'
	#
	# txtEmailRecipient
	#
	$txtEmailRecipient.Enabled = $False
	$txtEmailRecipient.Location = '142, 112'
	$txtEmailRecipient.Name = "txtEmailRecipient"
	$txtEmailRecipient.Size = '259, 20'
	$txtEmailRecipient.TabIndex = 76
	#
	# txtEmailSender
	#
	$txtEmailSender.Enabled = $False
	$txtEmailSender.Location = '142, 138'
	$txtEmailSender.Name = "txtEmailSender"
	$txtEmailSender.Size = '259, 20'
	$txtEmailSender.TabIndex = 77
	#
	# tabpage5
	#
	$tabpage5.Controls.Add($richtextbox1)
	$tabpage5.BackColor = 'ControlLight'
	$tabpage5.Location = '4, 22'
	$tabpage5.Name = "tabpage5"
	$tabpage5.Size = '428, 404'
	$tabpage5.TabIndex = 4
	$tabpage5.Text = "About"
	#
	# richtextbox1
	#
	$richtextbox1.Location = '3, 4'
	$richtextbox1.Name = "richtextbox1"
	$richtextbox1.ScrollBars = 'Vertical'
	$richtextbox1.Size = '421, 397'
	$richtextbox1.TabIndex = 0
	$richtextbox1.Text = "Utility:
vSphere Report GUI

Version:
0.0.1

Introduction:
This GUI is meant to configure regular vmware report generation. You are able to select reporting scoped to the whole farm down to individual hosts.

There are several options for those interested in monitoring their environment. Some options include;

General Options:
- Generating reports if thresholds are surpassed

Virtual Center
- VC event errors (with threshold in # of days)
- VMs created/cloned/deleted
- VC windows server errors/warnings (with threshold in # of days)
- VC windows server service status

ESX/vSphere Hosts
- Hosts not responding
- Hosts in maintenance
- Host datastore utilization (with % free utilization threshold)

Virtual Machines
- VM snapshots (with threshold in # of days)
- VMs with thin provisioned disks
- VMs with no vmware tools
- VMs with connected CD drives
- VMs with connected floppy drives

Usage:
The GUI is used to perform an initial test connection to the server and to save options. Once connected to the server you can select more granular scoped reports based on the datacenter, cluster, and host if desired. Currently you need to report on the whole farm to get virtual center reporting options.

Once the configuration is saved another script, VMware-Report.ps1 can be used to schedule the job (it will automatically load the saved xml config file and run without any interface). 

Author: Zachary Loeber
Sites:
http://the-little-things.net
"
	#
	# timerFadeIn
	#
	$timerFadeIn.add_Tick($timerFadeIn_Tick)
	#
	# openfiledialog1
	#
	$openfiledialog1.DefaultExt = "txt"
	$openfiledialog1.Filter = "Text File (.txt)|*.txt|All Files|*.*"
	$openfiledialog1.ShowHelp = $True
	#
	# folderbrowserdialog1
	#
	#
	# tooltipAll
	#
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $MainForm.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$MainForm.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$MainForm.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$MainForm.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $MainForm.ShowDialog()

}
#endregion Source: MainForm.pff

#region Source: Globals.ps1
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
#endregion Source: Globals.ps1

#Start the application
Main ($CommandLine)
