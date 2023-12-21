$ec2region = "us-east-1"
$name = "*ps3sftp001*"
$wait = 600 # wait 10 minutes between instances
$dryrun = $true

function Get-Instances {

    param (
        $ec2region
    )
    
    $InstanceNamesByID = @()
    
    Set-DefaultAWSRegion -Region $ec2region
    $instances = (Get-EC2Instance -Filter @{Name = "tag:Name"; Values = $name }).Instances

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

    if ( ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($userdata))).length -lt 1) {
        #write-host "$InstanceId does not contain UserData!"
        return "nodata"
    }
    else {
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

$instances = Get-Instances -ec2region $ec2region | Sort-Object -Property tagName
write-host "$($instances.count) instances found."

foreach ($instance in $instances) {
    $tagName = $instance.tagName
    $instanceid = $instance.instanceid

    if ($dryrun -eq $false) {
        write-host "$tagName : " -NoNewline
        $status = Reset-UserData -ec2region $ec2region -instanceid $instance.InstanceID

        if ($status -eq "cleared") {
            write-host "$instanceid restarted to clear userdata; waiting 540 second between instances."
            Start-Sleep -Seconds $wait 
            $clearcount += 1
        }
        else {
            write-host "$instanceid had no userdata to clear."
        }
    }
    else {
        write-host "$tagName : " -NoNewline
        
        $userdata = (Get-EC2InstanceAttribute -InstanceId $InstanceId -Attribute UserData).UserData

        if ( ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($userdata))).length -lt 1) {
            write-host "$instanceid would be skipped because it has no userdata; skipping wait period of $wait seconds."
        }
        else {
            write-host "$instanceid would be restarted to clear userdata; skipping wait period of $wait seconds."
        }
        
    }
}

write-host "Cleared userdata from $clearcount of $($instances.count) instances."