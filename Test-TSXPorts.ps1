Param(
    $Computername
)
Function Test-TSXOpenTCPPort {
<#
 # Proudly borrwed stuff from https://github.com/InfosecMatter/Minimalistic-offensive-security-tools/blob/master/port-scan-tcp.ps1, thank you
#>

    param(
        $Computername,
        $Ports
    )

    if (!$ports) {
        return
    }

    $result = foreach($p in [array]$ports) {

        $Object = New-Object PSCustomObject
        $Object | Add-Member -MemberType NoteProperty -Name "ComputerName" -Value $ComputerName
        $Object | Add-Member -MemberType NoteProperty -Name "Protocol" -Value "TCP"
        $Object | Add-Member -MemberType NoteProperty -Name "Port" -Value $p

        $t = New-Object system.Net.Sockets.TcpClient
        $c = $t.ConnectAsync($ComputerName,$p)
        for($i=0; $i -lt 10; $i++) {
                if ($c.isCompleted) {
                    break;
                }
            Start-Sleep -Milliseconds 100
        }

        $t.Close();
        $r = "Filtered"
        if ($c.isFaulted -and $c.Exception -match "actively refused") {
            $r = "Closed"
        } elseif ($c.Status -eq "RanToCompletion") {
            $r = "Open"
        }

        $Object | Add-Member -MemberType NoteProperty -Name "Status" -Value $r
        $Object
    }
    Return $result
}

Test-TSXOpenTCPPort -Computername $Computername -Ports 80,443,445,3389,5985 | Format-Table -AutoSize

Pause