# Prompt the user to enter an IP address
$ip = Read-Host "Enter the IP address of the device"

# Initialize an empty array to store the results
$output = @()

# Check if the device is reachable by pinging it once
if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {
    try {
        # Retrieve device details
        $hostname = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ip).Name
        $lastLoggedUser = (Get-WmiObject -Class Win32_NetworkLoginProfile -ComputerName $ip | Sort-Object -Property LastLogon -Descending | Select-Object -First 1).Name
        $machineType = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ip).Model
        $windowsVersion = (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip).Caption + " " +
                          (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip).Version + " (Build " +
                          (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip).BuildNumber + ")"
        
        # Add the collected information to the output array
        $output += [PSCustomObject]@{
            IP             = $ip
            Hostname       = $hostname
            LastLoggedUser = $lastLoggedUser
            MachineType    = $machineType
            WindowsVersion = $windowsVersion
        }
    } catch {
        # Print an error message if there's an issue retrieving information
        Write-Host "Failed to retrieve information for device with IP $ip. Error: $_"
    }
} else {
    # Print a message if the device is not reachable
    Write-Host "Device with IP $ip is not reachable."
}

# Display the results in a formatted table in the PowerShell console
$output | Format-Table -AutoSize

# Export the results to a CSV file on the desktop
$output | Export-Csv -Path "$([Environment]::GetFolderPath('Desktop'))\output.csv" -NoTypeInformation
