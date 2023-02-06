#Stop IPMI Device
Param(
    $OOBIP,
    $OOBUserName,
    $OOBPassword
)

$cred = New-Object System.Management.Automation.PSCredential ($OOBUserName, (ConvertTo-SecureString $OOBPassword -AsPlainText -Force))
Get-PcsvDevice -TargetAddress $OOBIP -Credential $Cred -ManagementProtocol IPMI -SkipRevocationCheck -TimeoutSec 5 -Verbose -SkipCACheck -SkipCNCheck
Stop-PcsvDevice -TargetAddress $OOBIP -Credential $Cred -ManagementProtocol IPMI -SkipRevocationCheck -TimeoutSec 5 -Confirm:$false -SkipCACheck -SkipCNCheck -Verbose
Start-Sleep -Seconds 3