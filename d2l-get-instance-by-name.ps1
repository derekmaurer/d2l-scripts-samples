Import-Module AWSPowerShell

function Get-ADInstances {

    param (
        $ec2region
    )

    Set-DefaultAWSRegion      -Region $ec2region

    $instances = (Get-EC2Instance -Filter @{Name="tag:Name";Values="*maddc*"}).Instances
    $objinstances = New-Object -TypeName psobject

    foreach ($instance in $instances) {
        $instanceId = $instance.InstanceId
        $tagName = ($instance.Tags | Where-Object { $_.Key -eq "Name" }).Value

        $obj | Add-Member -MemberType NoteProperty -Name InstanceID -Value $instanceId
        $obj | Add-Member -MemberType NoteProperty -Name InstanceID -Value $instanceId
        
    }
    Write-Output "$tagName     $instanceId"
}