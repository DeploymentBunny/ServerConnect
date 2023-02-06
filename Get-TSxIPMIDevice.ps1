#Stop IPMI Device
Param(
    $OOBIP,
    $OOBUserName,
    $OOBPassword
)

$cred = New-Object System.Management.Automation.PSCredential ($OOBUserName, (ConvertTo-SecureString $OOBPassword -AsPlainText -Force))
Get-PcsvDevice -TargetAddress $OOBIP -Credential $Cred -ManagementProtocol IPMI -SkipRevocationCheck -TimeoutSec 5 -Verbose -SkipCACheck -SkipCNCheck | Select-Object Status,CurrentBIOSVersionString,CurrentManagementFirmwareMajorVersion,CurrentManagementFirmwareMinorVersion,Manufacturer,Model,PartNumber,SerialNumber,StructuredBootString,IPv4Address,IPv4DefaultGateway,IPv4SubnetMask,MacAddress,SMBIOSGuid,TargetAddress
Pause




