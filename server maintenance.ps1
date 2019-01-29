$Credentials = Get-Credential -Message "Supply a valid Domain user account"

$oneView = Write-Host "Please enter the OneView you would like to search enclosures for"
Connect-HPOVMgmt -Hostname $oneView -Credential $Credentials

$vCenter = Read-Host "Please specify the vCenter these Hosts reside on."
Connect-VIServer -Server $vCenter -Credential $Credentials 

$enclosures = Read-Host "Supply the DataCenter,Row,Cabinet,Enclosure(example: DCBR9C2)`
 You can leave off or add Enclosure to narrow down search."
$servers = Get-HPOVServer | ? {$_.Name -like "*$enclosures*"} | select -ExpandProperty "ServerName" 
$hostArray = @()



foreach($server in $servers){
    $hostArray += $server.Split(".")[0] + ".federated.fds"
    
    
    
    }
$hostArray | Sort-Object



foreach($vmhost in $hostArray){
Get-VMHost -Name $vmhost | select -Property "Name","ConnectionState" | Sort-Object
}
#$Hosts = Get-VMHost | ? {$_.Name -like '*CBR9C2*'} | select -ExpandProperty "ServerName"