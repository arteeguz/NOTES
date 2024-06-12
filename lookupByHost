$csvPath = "$([Environment]::GetFolderPath('Desktop'))\devicesHOST.csv"
$devices = Import-Csv -Path $csvPath

$output = @()

foreach ($device in $devices) {
    $hostname = $device.Hostname
    if (Test-Connection -ComputerName $hostname -Count 1 -Quiet) {
        try {
            $hostname = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $hostname).Name
            $lastLoggedUser = (Get-WmiObject -Class Win32_NetworkLoginProfile -ComputerName $hostname | Sort-Object -Property LastLogon -Descending | Select-Object -First 1).Name
            $machineType = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $hostname).Model
            $windowsVersion = (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $hostname).Caption + " " +
                              (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $hostname).Version + " (Build " +
                              (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $hostname).BuildNumber + ")"
            
            $output += [PSCustomObject]@{
                Hostname       = $hostname
                LastLoggedUser = $lastLoggedUser
                MachineType    = $machineType
                WindowsVersion = $windowsVersion
            }
        } catch {
            Write-Host "Failed to retrieve information for device with Hostname $hostname. Error: $_"
        }
    } else {
        Write-Host "Device with Hostname $hostname is not reachable."
    }
}

$output | Format-Table -AutoSize
$output | Export-Csv -Path "$([Environment]::GetFolderPath('Desktop'))\output.csv" -NoTypeInformation
