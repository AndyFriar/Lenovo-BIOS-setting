Function Set-LenovoBIOSSetting{
    [CmdletBinding()]
    param(
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]$Setting,
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]$Value,
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]$Password
    )
    $SETBIOS = Get-WmiObject -Class Lenovo_SetBiosSetting -Namespace "root\wmi"
    #with a password
    if ($Password.Length -ge 1){
        $BIOS_PW ="$Password,ascii,us;"
        $SETBIOS.SetBIOSSetting("$Setting,$Value,$BIOS_PW")
        $saveBIOSSettings = Get-WmiObject -Class Lenovo_SaveBiosSettings -Namespace root\wmi
        $result = $($saveBIOSSettings.SaveBIOSSettings($BIOS_PW)).return
        write-output $result
    }
    # without a password
    else{
        $SETBIOS.SetBIOSSetting("$Setting,$Value")
        $saveBIOSSettings = Get-WmiObject -Class Lenovo_SaveBiosSettings -Namespace root\wmi
        $result = $($saveBIOSSettings.SaveBIOSSettings($BIOS_PW)).return
        write-output $result
    }
}

$obj = Set-LenovoBIOSSetting -Setting "PXE IPv6 Network Stack" -Value "Disabled" -Password "PASSWORD"
write-output $obj