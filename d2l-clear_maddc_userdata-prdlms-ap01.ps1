Import-Module AWSPowerShell

$ec2region  = "ap-southeast-2"

function Get-ADInstances {

    param (
        $ec2region
    )
    
    $InstanceNamesByID = @()
    
    Set-DefaultAWSRegion      -Region $ec2region
    $instances = (Get-EC2Instance -Filter @{Name="tag:Name";Values="*maddc*"}).Instances

    foreach ($instance in $instances) {
        $instanceId = $instance.InstanceId
        $tagName = ($instance.Tags | Where-Object { $_.Key -eq "Name" }).Value

        $obj = New-Object -TypeName PSObject
        $obj | Add-Member -MemberType NoteProperty -Name InstanceID -Value $instanceId 
        $obj | Add-Member -MemberType NoteProperty -Name tagName    -Value $tagName   
        
        $InstanceNamesByID += $obj
    }
    
    return $InstanceNamesByID
}

function Reset-UserData {

    param (
        $ec2region,
        $InstanceId
    )

    Set-DefaultAWSRegion      -Region $ec2region

    $userdata = (Get-EC2InstanceAttribute -InstanceId $InstanceId -Attribute UserData).UserData

    if ( ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($userdata))).length -lt 1){
        #write-host "$InstanceId does not contain UserData!"
        return "nodata"
    } else {
        Write-Host "continuing..."
        
        Stop-EC2Instance          -InstanceId $InstanceId 
        $data = Get-EC2Instance $instanceId
        $currentState = $data.Instances[0].State.Name;
        
        write-host "waiting for $InstanceId to stop" -NoNewline
        
        while ($currentState -ne "stopped") {
            write-host "." -NoNewline    
            Start-Sleep -Seconds 10
            $data = Get-EC2Instance $instanceId
            $currentState = $data.Instances[0].State.Name;
        }
        Write-Host "$InstanceId stopped"

        Edit-EC2InstanceAttribute -InstanceId $InstanceId -UserData "" 
        Start-EC2Instance         -InstanceId $InstanceId 

        $data = Get-EC2Instance $instanceId
        $currentState = $data.Instances[0].State.Name;

        while ($currentState -ne "running") {
            write-host "waiting for $InstanceId to start..."
            Start-Sleep -Seconds 5
            $data = Get-EC2Instance $instanceId
            $currentState = $data.Instances[0].State.Name;
        }
        Write-Host "$InstanceId running"
        return "cleared"
    }
}


$clearcount = 0
Set-DefaultAWSRegion      -Region $ec2region

$instances = Get-ADInstances -ec2region $ec2region | Sort-Object -Property tagName
write-host "$($instances.count) instances found."

foreach ($instance in $instances){
    $tagName = $instance.tagName
    $instanceid = $instance.instanceid

    write-host "$tagName : " -NoNewline
    $status = Reset-UserData -ec2region $ec2region -instanceid $instance.InstanceID

    if ($status -eq "cleared") {
        write-host "$instanceid restarted to clear userdata; waiting 540 second between instances."
        Start-Sleep -Seconds 540 # wait 9 minutes between DCs
        $clearcount += 1
    } else {
        write-host "$instanceid had no userdata to clear."
    }
}

write-host "Cleared userdata from $clearcount of $($instances.count) instances."