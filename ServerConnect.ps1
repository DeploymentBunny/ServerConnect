#Get Env:
$RootFolder = $MyInvocation.MyCommand.Path | Split-Path -Parent
#$RootFolder = "c:\serverconnect"

#Get Data
#Get Data
[XML]$XMLSettings = Get-Content -Path $RootFolder\Settings.xml
[XML]$XMLData = Get-Content -Path $RootFolder\Serverlist.xml

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI{ 

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '700,505'
$Form.text                       = "Server Connect version 2"
$Form.TopMost                    = $false

$LabelLeft1                      = New-Object system.Windows.Forms.Label
$LabelLeft1.text                 = "Windows Operations"
$LabelLeft1.AutoSize             = $true
$LabelLeft1.width                = 150
$LabelLeft1.height               = 40
$LabelLeft1.location             = New-Object System.Drawing.Point(150,25)
$LabelLeft1.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$ConnectRDP1                     = New-Object system.Windows.Forms.Button
$ConnectRDP1.text                = "RDP"
$ConnectRDP1.width               = 150
$ConnectRDP1.height              = 23
$ConnectRDP1.location            = New-Object System.Drawing.Point(150,60)
$ConnectRDP1.Font                = 'Microsoft Sans Serif,10'

$ConnectRDP2                     = New-Object system.Windows.Forms.Button
$ConnectRDP2.text                = "RDP (RestrictedAdm)"
$ConnectRDP2.width               = 150
$ConnectRDP2.height              = 23
$ConnectRDP2.location            = New-Object System.Drawing.Point(150,90)
$ConnectRDP2.Font                = 'Microsoft Sans Serif,10'

$WindowsRestart                  = New-Object system.Windows.Forms.Button
$WindowsRestart.text             = "Restart/Reboot"
$WindowsRestart.width            = 150
$WindowsRestart.height           = 23
$WindowsRestart.location         = New-Object System.Drawing.Point(150,120)
$WindowsRestart.Font             = 'Microsoft Sans Serif,10'

$WindowsShutdown                 = New-Object system.Windows.Forms.Button
$WindowsShutdown.text            = "Shutdown"
$WindowsShutdown.width           = 150
$WindowsShutdown.height          = 23
$WindowsShutdown.location        = New-Object System.Drawing.Point(150,150)
$WindowsShutdown.Font            = 'Microsoft Sans Serif,10'

$WindowsPing                     = New-Object system.Windows.Forms.Button
$WindowsPing.text                = "Ping"
$WindowsPing.width               = 150
$WindowsPing.height              = 23
$WindowsPing.location            = New-Object System.Drawing.Point(150,180)
$WindowsPing.Font                = 'Microsoft Sans Serif,10'

$WindowsPortScan                 = New-Object system.Windows.Forms.Button
$WindowsPortScan.text            = "PortScan"
$WindowsPortScan.width           = 150
$WindowsPortScan.height          = 23
$WindowsPortScan.location        = New-Object System.Drawing.Point(150,210)
$WindowsPortScan.Font            = 'Microsoft Sans Serif,10'

$LabelMid1                       = New-Object system.Windows.Forms.Label
$LabelMid1.text                  = "Out of band operations"
$LabelMid1.AutoSize              = $true
$LabelMid1.width                 = 150
$LabelMid1.height                = 40
$LabelMid1.location              = New-Object System.Drawing.Point(350,25)
$LabelMid1.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$OOBConnectConsole               = New-Object system.Windows.Forms.Button
$OOBConnectConsole.text          = "Connect OOB KVM"
$OOBConnectConsole.width         = 150
$OOBConnectConsole.height        = 23
$OOBConnectConsole.location      = New-Object System.Drawing.Point(350,60)
$OOBConnectConsole.Font          = 'Microsoft Sans Serif,10'

$ConnectOOBWEB                   = New-Object system.Windows.Forms.Button
$ConnectOOBWEB.text              = "Connect OOB WEB"
$ConnectOOBWEB.width             = 150
$ConnectOOBWEB.height            = 23
$ConnectOOBWEB.location          = New-Object System.Drawing.Point(350,90)
$ConnectOOBWEB.Font              = 'Microsoft Sans Serif,10'

$PowerOffUsingOOB                = New-Object system.Windows.Forms.Button
$PowerOffUsingOOB.text           = "Power off using OOB"
$PowerOffUsingOOB.width          = 150
$PowerOffUsingOOB.height         = 23
$PowerOffUsingOOB.location       = New-Object System.Drawing.Point(350,120)
$PowerOffUsingOOB.Font           = 'Microsoft Sans Serif,10'

$PowerOnUsingOOB                 = New-Object system.Windows.Forms.Button
$PowerOnUsingOOB.text            = "Power on using OOB"
$PowerOnUsingOOB.width           = 150
$PowerOnUsingOOB.height          = 23
$PowerOnUsingOOB.location        = New-Object System.Drawing.Point(350,150)
$PowerOnUsingOOB.Font            = 'Microsoft Sans Serif,10'

$ColdBootUsingOOB                = New-Object system.Windows.Forms.Button
$ColdBootUsingOOB.text           = "Cold boot using OOB"
$ColdBootUsingOOB.width          = 150
$ColdBootUsingOOB.height         = 23
$ColdBootUsingOOB.location       = New-Object System.Drawing.Point(350,180)
$ColdBootUsingOOB.Font           = 'Microsoft Sans Serif,10'

$PingOOB                         = New-Object system.Windows.Forms.Button
$PingOOB.text                    = "Ping"
$PingOOB.width                   = 150
$PingOOB.height                  = 23
$PingOOB.location                = New-Object System.Drawing.Point(350,210)
$PingOOB.Font                    = 'Microsoft Sans Serif,10'

$GetOOBInfo                      = New-Object system.Windows.Forms.Button
$GetOOBInfo.text                 = "Get OOB Info"
$GetOOBInfo.width                = 150
$GetOOBInfo.height               = 23
$GetOOBInfo.location             = New-Object System.Drawing.Point(350,240)
$GetOOBInfo.Font                 = 'Microsoft Sans Serif,10'

$ButtonClose                     = New-Object system.Windows.Forms.Button
$ButtonClose.text                = "Close ServerConnect"
$ButtonClose.width               = 150
$ButtonClose.height              = 40
$ButtonClose.location            = New-Object System.Drawing.Point(530,450)
$ButtonClose.Font                = 'Microsoft Sans Serif,10'

$ListBox1                        = New-Object system.Windows.Forms.ListBox
$ListBox1.text                   = "listBox"
$ListBox1.width                  = 120
$ListBox1.height                 = 470
$ListBox1.location               = New-Object System.Drawing.Point(19,24)
$listBox1.font                   = 'Microsoft Sans Serif,10'

$LabelMid2                       = New-Object system.Windows.Forms.Label
$LabelMid2.text                  = "PowerShell Operations"
$LabelMid2.AutoSize              = $true
$LabelMid2.width                 = 150
$LabelMid2.height                = 40
$LabelMid2.location              = New-Object System.Drawing.Point(150,250)
$LabelMid2.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$ConnectRemotePOSH               = New-Object system.Windows.Forms.Button
$ConnectRemotePOSH.text          = "Remote POSH CLI"
$ConnectRemotePOSH.width         = 150
$ConnectRemotePOSH.height        = 23
$ConnectRemotePOSH.location      = New-Object System.Drawing.Point(150,285)
$ConnectRemotePOSH.Font          = 'Microsoft Sans Serif,10'

$PictureBox1 = New-Object system.Windows.Forms.PictureBox
$PictureBox1.width = 150
$PictureBox1.height  = 130
$PictureBox1.location  = New-Object System.Drawing.Point(530,15)
$PictureBox1.imageLocation  = "$RootFolder\image.png"
$PictureBox1.SizeMode  = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$Form.controls.AddRange(@($ConnectRDP1,$ConnectRDP2,$WindowsRestart,$WindowsShutdown,$WindowsPing,$WindowsPortScan,$OOBConnectConsole,$ConnectOOBWEB,$PowerOnUsingOOB,$PowerOffUsingOOB,$ColdBootUsingOOB,$PingOOB,$GetOOBInfo,$ButtonClose,$ListBox1,$PictureBox1,$LabelLeft1,$LabelMid1,$LabelMid2,$ConnectRemotePOSH))

#region gui events {
$ConnectRDP1.Add_Click({ Start-TsxConnectRDP1})
$ConnectRDP2.Add_Click({ Start-TsxConnectRDP2})
$WindowsRestart.Add_Click({ Start-TsxWindowsRestart})
$WindowsShutdown.Add_Click({ Start-TsxShutdown})
$WindowsPing.Add_Click({ Start-TsxPing})
$WindowsPortScan.Add_Click({ Start-TsxPortScan})
$ConnectRemotePOSH.Add_Click({ Start-TsxConnectRemotePOSH})
$OOBConnectConsole.Add_Click({ Start-TSxOOBConnectConsole })
$ConnectOOBWEB.Add_Click({ Start-TSXConnectOOBWEB })
$PowerOffUsingOOB.Add_Click({ Start-TSxPowerOffUsingOOB })
$PowerOnUsingOOB.Add_Click({ Start-TSxPowerOnUsingOOB })
$ColdBootUsingOOB.Add_Click({ Start-TSxColdBootUsingOOB })
$PingOOB.Add_Click({ Start-TSxPingOOB })
$GetOOBInfo.Add_Click({ Start-TSxGetOOBInfo })
$ButtonClose.Add_Click({ Close })
#endregion events }

#endregion GUI }


#Write your logic code here
Function Close{
    $Form.Close()
}

#Connect using RDP
Function Start-TsxConnectRDP1{
    $Selection1 = $ListBox1.SelectedItem
    $Server = $XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1
    Start mstsc.exe -ArgumentList "/v:$($Server.Name)"
}

#Connect using RDP
Function Start-TsxConnectRDP2{
    $Selection1 = $ListBox1.SelectedItem
    $Server = $XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1
    Start mstsc.exe -ArgumentList "/v:$($Server.Name) /RestrictedAdmin"
}

#Restart Windows
Function Start-TsxWindowsRestart{
    $Selection1 = $ListBox1.SelectedItem
    $Server = $XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1
    Start PowerShell -ArgumentList "Restart-Computer -ComputerName $($Server.Name) -Force -Verbose"
}

#Shutdown Windows
Function Start-TsxShutdown{
    $Selection1 = $ListBox1.SelectedItem
    $Server = $XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1
    Start PowerShell -ArgumentList "Stop-Computer -ComputerName $($Server.Name) -Force -Verbose"
}

#Ping Windows
Function Start-TsxPing{
    $Selection1 = $ListBox1.SelectedItem
    $Server = $XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1
    Start PowerShell -ArgumentList "Ping $($Server.Name)"
}

# PortScan Windows
Function Start-TsxPortScan{
    $Selection1 = $ListBox1.SelectedItem
    $Server = $XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1
    Start PowerShell -ArgumentList "$RootFolder\Test-TSXPorts.ps1 -Computername $($Server.Name)"
}

Function Start-TsxConnectRemotePOSH{
    $Selection1 = $ListBox1.SelectedItem
    $Server = $XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1
    #Start PowerShell -ArgumentList "Enter-PSSession -Computername $($Server.Name)"
    Start-Process PowerShell -ArgumentList "-noexit", "Enter-PSSession -Computername $($Server.Name)"
}


#Connect OOB KVM
Function Start-TSxOOBConnectConsole{
    $Selection1 = $ListBox1.SelectedItem
    $Server = ($XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1)
    & $($XMLSettings.Settings.ILOConnectPath) -addr $Server.oob.FQDN -name $Server.oob.UserName -password $Server.oob.Password
}

#Connect OOB web
Function Start-TSXConnectOOBWEB{
    $Selection1 = $ListBox1.SelectedItem
    $Server = ($XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1)
    start http://$($Server.oob.FQDN)
}

#Power off OOB
Function Start-TSxPowerOffUsingOOB{
    $Selection1 = $ListBox1.SelectedItem
    $Server = ($XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1)
    Start PowerShell -ArgumentList "$RootFolder\Stop-TSxIPMIDevice.ps1 -OOBIP $($Server.OOB.FQDN) -OOBUsername $($Server.OOB.Username) -OOBPassword $($Server.OOB.Password)"
}

#Power on OOB
Function Start-TSxPowerOnUsingOOB{
    $Selection1 = $ListBox1.SelectedItem
    $Server = ($XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1)
    Start-Process PowerShell -ArgumentList "$RootFolder\Start-TSxIPMIDevice.ps1 -OOBIP $($Server.OOB.FQDN) -OOBUsername $($Server.OOB.Username) -OOBPassword $($Server.OOB.Password)"
}

#Cold restart OOB
Function Start-TSxColdBootUsingOOB{
    $Selection1 = $ListBox1.SelectedItem
    $Server = ($XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1)
    Start PowerShell -ArgumentList "$RootFolder\Stop-TSxIPMIDevice.ps1 -OOBIP $($Server.OOB.FQDN) -OOBUsername $($Server.OOB.Username) -OOBPassword $($Server.OOB.Password)"
    Start-Sleep -Seconds 5
    Start PowerShell -ArgumentList "$RootFolder\Start-TSxIPMIDevice.ps1 -OOBIP $($Server.OOB.FQDN) -OOBUsername $($Server.OOB.Username) -OOBPassword $($Server.OOB.Password)"
}

#Ping OOB
Function Start-TSxPingOOB{
    $Selection1 = $ListBox1.SelectedItem
    $Server = ($XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1)
    Start PowerShell -ArgumentList "Ping $($Server.oob.FQDN)"
}

# Get OOB Data
Function Start-TSxGetOOBInfo{
    $Selection1 = $ListBox1.SelectedItem
    $Server = ($XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1)
    Start PowerShell -ArgumentList "$RootFolder\Get-TSxIPMIDevice.ps1 -OOBIP $($Server.OOB.FQDN) -OOBUsername $($Server.OOB.Username) -OOBPassword $($Server.OOB.Password)"
}

foreach($item in $($XMLdata.Settings.Servers).server.name){
    [void] $ListBox1.Items.Add($item)
}

[void]$Form.ShowDialog()

#