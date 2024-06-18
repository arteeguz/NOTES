# Function to prompt the user for input and return the choice MAIN 
function Get-UserChoice {
    Write-Host "Please select an option:"
    Write-Host "1. Input single IP (example):"
    Write-Host "2. Use devices.csv from desktop:"
    Write-Host "3. Input segment (example):"
    $choice = Read-Host "Enter your choice (1, 2, or 3)"
    return $choice
}

# Function to process a single IP
function Process-SingleIP {
    $ip = Read-Host "Enter the IP address"
    return @([PSCustomObject]@{IP = $ip})
}

# Function to process a segment of IPs
function Process-Segment {
    $segment = Read-Host "Enter the IP segment (e.g., 192.168.1)"
    $ips = 1..254 | ForEach-Object { "$segment.$_" }
    return $ips | ForEach-Object { [PSCustomObject]@{IP = $_} }
}

# Setup variables for the script
#############################
$outputPath = "$([Environment]::GetFolderPath('Desktop'))\output.csv"

# Main script starts here
$choice = Get-UserChoice

switch ($choice) {
    1 {
        $devices = Process-SingleIP
    }
    2 {
        $csvPath = "$([Environment]::GetFolderPath('Desktop'))\devices.csv"
        $devices = Import-Csv -Path $csvPath
    }
    3 {
        $devices = Process-Segment
    }
    default {
        Write-Host "Invalid choice. Exiting script."
        exit
    }
}

# Function to check if a file exists and load existing data if it does
function Load-ExistingData {
    if (Test-Path -Path $outputPath) {
        return Import-Csv -Path $outputPath
    } else {
        return @()
    }
}

# Load existing data
$outputDataList = [System.Collections.ArrayList]@()
$existingData = Load-ExistingData
foreach ($item in $existingData) {
    $outputDataList.Add($item) | Out-Null
}

# Main processing block for each device
foreach ($device in $devices) {
    $ip = $device.IP
    $date = Get-Date -Format "M/dd/yyyy"
    $time = Get-Date -Format "HH:mm"
    $status = "Not Reachable"

    # Check connectivity to the IP
    if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {
        try {
            # Retrieve system information
            $hostname = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ip).Name
            $lastLoggedUser = (Get-WmiObject -Class Win32_NetworkLoginProfile -ComputerName $ip | Sort-Object -Property LastLogon -Descending | Select-Object -First 1).Name
            $machineType = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ip).Model
            $windowsVersion = (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip).Caption + " " +
                              (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip).Version + " (Build " +
                              (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip).BuildNumber + ") 22h2"

            $status = "Complete"

            # Output to custom object
            $outputData = [PSCustomObject]@{
                IP             = $ip
                Hostname       = $hostname
                LastLoggedUser = $lastLoggedUser
                MachineType    = $machineType
                WindowsVersion = $windowsVersion
                Date           = $date
                Time           = $time
                Status         = $status
            }

            # Add to output data list
            $outputDataList.Add($outputData) | Out-Null

        } catch {
            $status = "Failed to retrieve information. Error: $_"
        }
    }

    # Log if not reachable
    if ($status -eq "Not Reachable") {
        $outputData = [PSCustomObject]@{
            IP             = $ip
            Hostname       = "N/A"
            LastLoggedUser = "N/A"
            MachineType    = "N/A"
            WindowsVersion = "N/A"
            Date           = $date
            Time           = $time
            Status         = $status
        }
        # Add to output data list
        $outputDataList.Add($outputData) | Out-Null
    }

    # Output status to console
    Write-Output "$ip $status"
}

# Export all data to CSV
$outputDataList | Export-Csv -Path $outputPath -NoTypeInformation

# No final output to console to avoid duplication
