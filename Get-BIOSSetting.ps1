Function Get-BIOSSetting{
    param(
        [parameter(Mandatory=$true, HelpMessage="Setting")]
        [ValidateNotNullOrEmpty()]
        [string]$Setting
    )

    $BIOS = Get-WmiObject -Class Lenovo_BiosSetting -Namespace root\wmi | Where-Object {$_.CurrentSetting.split(",",[StringSplitOptions]::RemoveEmptyEntries) -eq $setting} | Format-List CurrentSetting

    $a = $BIOS | Out-String

    $result = $a.Contains($setting + ",Disabled")
    Write-Output $result
}

$setting = "PXE IPV6 Network Stack"
$obj = Get-BIOSSetting -Setting $setting
Write-Output $obj