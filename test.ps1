$csvPath = "$([Environment]::GetFolderPath('Desktop'))\devices.csv"
$devices = Import-Csv -Path $csvPath

$output = @()

foreach ($device in $devices) {
    $ip = $device.IP
    $hostname = Test-Connection -ComputerName $ip -Count 1 -Quiet
    
    if ($hostname) {
        $lastLoggedUser = (Get-WmiObject -Class Win32_NetworkLoginProfile -ComputerName $ip | Sort-Object -Property LastLogon -Descending | Select-Object -First 1).Name
        $machineType = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ip).Model
        $windowsVersion = (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip).Caption + " " +
                          (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip).Version + " " +
                          (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip).BuildNumber
        
        $output += [PSCustomObject]@{
            IP             = $ip
            Hostname       = $hostname
            LastLoggedUser = $lastLoggedUser
            MachineType    = $machineType
            WindowsVersion = $windowsVersion
        }
    } else {
        Write-Host "Device with IP $ip is not reachable."
    }
}

$output | Format-Table -AutoSize
$output | Export-Csv -Path "$([Environment]::GetFolderPath('Desktop'))\output.csv" -NoTypeInformation
