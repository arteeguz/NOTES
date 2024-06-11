$csvPath = "$([Environment]::GetFolderPath('Desktop'))\devices.csv"
$devices = Import-Csv -Path $csvPath

$output = @()

foreach ($device in $devices) {
    $ip = $device.IP
    if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {
        try {
            $hostname = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ip).Name
            $lastLoggedUser = (Get-WmiObject -Class Win32_NetworkLoginProfile -ComputerName $ip | Sort-Object -Property LastLogon -Descending | Select-Object -First 1).Name
            $machineType = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ip).Model
            $windowsVersion = (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip).Caption + " " +
                              (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip).Version + " (Build " +
                              (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip).BuildNumber + ")"
            
            $output += [PSCustomObject]@{
                IP             = $ip
                Hostname       = $hostname
                LastLoggedUser = $lastLoggedUser
                MachineType    = $machineType
                WindowsVersion = $windowsVersion
            }
        } catch {
            Write-Host "Failed to retrieve information for device with IP $ip. Error: $_"
        }
    } else {
        Write-Host "Device with IP $ip is not reachable."
    }
}

$output | Format-Table -AutoSize
$output | Export-Csv -Path "$([Environment]::GetFolderPath('Desktop'))\output.csv" -NoTypeInformation
