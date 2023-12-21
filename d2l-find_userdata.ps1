
$d2lenv = "prdgsn"
$ec2region = "ca-central-1"
$searchtagName = "Team"
$searchtag = "CIS*"
$matchstring = "svc_addmember"
#$matchstring = "join"
$csvpath = "c:\temp\$d2lenv-$ec2region-UserDataSecretStatus.csv"

Set-DefaultAWSRegion -Region $ec2region

function Get-ADInstances {

    param (
        $ec2region,
        $searchtag
    )
    
    $InstanceNamesByID = @()
    
    Set-DefaultAWSRegion      -Region $ec2region
    $instances = (Get-EC2Instance -Filter @{Name = "tag:$($searchtagName)"; Values = $($searchtag) }).Instances

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

function FindIn-UserData {

    param (
        $ec2region,
        $InstanceId,
        $matchstring
    )

    Set-DefaultAWSRegion      -Region $ec2region

    $userdata = (Get-EC2InstanceAttribute -InstanceId $InstanceId -Attribute UserData).UserData

    if ( ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($userdata))) -match $matchstring ) {
        # write-host "$InstanceId : True"
        return "True"
    }
    else {
        # write-host "$InstanceId : False"
        return "False"
    }
}

$matchcount = 0

$instances = Get-ADInstances -ec2region $ec2region -searchtag $searchtag | Sort-Object -Property tagName
write-host "$($instances.InstanceId.count) instances found."

$InstanceUDStatus = @()

foreach ($instance in $instances) {
    $tagName = $instance.tagName
    $instanceid = $instance.instanceid

    write-host "$instanceid : $tagName : " -NoNewline
    try {
        $status = FindIn-UserData -ec2region $ec2region -instanceid $instance.InstanceID -matchstring $matchstring
    }
    catch {
        $status = "NA"
        write-host $status
    }
    write-host $status

    $obj = New-Object -TypeName PSObject
    $obj | Add-Member -MemberType NoteProperty -Name InstanceID -Value $instanceId 
    $obj | Add-Member -MemberType NoteProperty -Name tagName    -Value $tagName   
    $obj | Add-Member -MemberType NoteProperty -Name Secrets    -Value $status
        
    $InstanceUDStatus += $obj
    if ($status -eq "True") { $matchcount += 1 }
    
}

$InstanceUDStatus | export-csv -Path $csvpath

write-host "Found $matchcount instances with matching userdata out of $($instances.InstanceId.count) instances."
