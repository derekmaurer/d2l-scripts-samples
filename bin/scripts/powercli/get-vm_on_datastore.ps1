$VmInfo = ForEach ($Datacenter in (Get-Datacenter | Sort-Object -Property Name)) {
  ForEach ($Cluster in ($Datacenter | Get-Cluster | Sort-Object -Property Name)) { 
    ForEach ($VM in ($Cluster | Get-VM | Sort-Object -Property Name)) {
      ForEach ($HardDisk in ($VM | Get-HardDisk | Sort-Object -Property Name)) {
        "" | Select-Object -Property @{N="VM";E={$VM.Name}},
          @{N="Datacenter";E={$Datacenter.name}},
          @{N="Cluster";E={$Cluster.Name}},
          @{N="Hard Disk";E={$HardDisk.Name}},
          @{N="Datastore";E={$HardDisk.FileName.Split("]")[0].TrimStart("[")}},
          @{N="VMDKpath";E={$HardDisk.FileName}}
      }
    }
  }
}   
$VmInfo | Export-Csv -NoTypeInformation -UseCulture -Path "C:\bin\scripts\powercli\results\$(get-date -f yyyy-MM-dd)_Vm_on_Datastore_Info.csv" 
