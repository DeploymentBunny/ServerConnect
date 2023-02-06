#Stop IPMI Device
Param(
    $OOBIP,
    $OOBUserName,
    $OOBPassword
)

$cred = New-Object System.Management.Automation.PSCredential ($OOBUserName, (ConvertTo-SecureString $OOBPassword -AsPlainText -Force))
Get-PcsvDevice -TargetAddress $OOBIP -Credential $Cred -ManagementProtocol IPMI -SkipRevocationCheck -TimeoutSec 5 -Verbose -SkipCACheck -SkipCNCheck
Start-PcsvDevice -TargetAddress $OOBIP -Credential $Cred -ManagementProtocol IPMI -SkipRevocationCheck -TimeoutSec 5 -Confirm:$false -Verbose -SkipCACheck -SkipCNCheck
Start-Sleep -Seconds 3