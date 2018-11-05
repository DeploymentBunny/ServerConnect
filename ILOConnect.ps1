$DLL = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
Add-Type -MemberDefinition $DLL -name NativeMethods -namespace Win32
$Process = (Get-Process PowerShell | Where-Object MainWindowTitle -like '*Ilo Connect*').MainWindowHandle
# Minimize window
[Win32.NativeMethods]::ShowWindowAsync($Process, 2)

#Get Env:
$RootFolder = $MyInvocation.MyCommand.Path | Split-Path -Parent

#Get Data
[XML]$XMLData = Get-Content -Path $RootFolder\Serverlist.xml

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI{ 

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '700,350'
$Form.text                       = "Form"
$Form.TopMost                    = $false

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Connect"
$Button1.width                   = 150
$Button1.height                  = 75
$Button1.location                = New-Object System.Drawing.Point(530,160)
$Button1.Font                    = 'Microsoft Sans Serif,10'

$Button2                         = New-Object system.Windows.Forms.Button
$Button2.text                    = "Close"
$Button2.width                   = 150
$Button2.height                  = 75
$Button2.location                = New-Object System.Drawing.Point(530,250)
$Button2.Font                    = 'Microsoft Sans Serif,10'

$ListBox1                        = New-Object system.Windows.Forms.ListBox
$ListBox1.text                   = "listBox"
$ListBox1.width                  = 450
$ListBox1.height                 = 303
$ListBox1.location               = New-Object System.Drawing.Point(19,24)
$listBox1.font                   = 'Microsoft Sans Serif,10'

$PictureBox1 = New-Object system.Windows.Forms.PictureBox
$PictureBox1.width = 150
$PictureBox1.height  = 130
$PictureBox1.location  = New-Object System.Drawing.Point(530,15)
$PictureBox1.imageLocation  = "$RootFolder\image.png"
$PictureBox1.SizeMode  = [System.Windows.Forms.PictureBoxSizeMode]::zoom

$Form.controls.AddRange(@($Button1,$Button2,$ListBox1,$PictureBox1))

#region gui events {
$Button1.Add_Click({ Connect })
$Button2.Add_Click({ Close })
#endregion events }

#endregion GUI }


#Write your logic code here
Function Close{
    $Form.Close()
}

#Write your logic code here
Function Connect{
    $Selection1 = $ListBox1.SelectedItem
    $Server = $XMLdata.Settings.Servers.Server | Where-Object Name -EQ $Selection1
    & 'C:\Program Files (x86)\Hewlett-Packard\HP iLO Integrated Remote Console\HPLOCONS.exe' -addr $Server.FQDN -name $Server.UserName -password $Server.Password
}
    
foreach($item in $($XMLdata.Settings.Servers).server.name){
    [void] $ListBox1.Items.Add($item)
}

[void]$Form.ShowDialog()
