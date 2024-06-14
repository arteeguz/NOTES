# Define paths and initialize variables
#############################
$csvPath = "$([Environment]::GetFolderPath('Desktop'))\devices.csv"
$outputFile = "$([Environment]::GetFolderPath('Desktop'))\output.csv"
$output = @()

# Function to log messages
#############################
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $outputFile -Value "$timestamp - $message"
}

# Function to get IPs in a range
#############################
function Get-IPsInRange {
    param (
        [string]$startIP,
        [string]$endIP
    )
    $start = [System.Net.IPAddress]::Parse($startIP)
    $end = [System.Net.IPAddress]::Parse($endIP)
    $ips = @($start)
    while ($ips[-1] -ne $end) {
        $nextIP = [System.Net.IPAddress]($ips[-1].GetAddressBytes() + 1)
        $ips += $nextIP
    }
    return $ips
}

# Function to get IPs in a segment
#############################
function Get-IPsInSegment {
    param (
        [string]$segment
    )
    $segment = [System.Net.IPAddress]::Parse($segment)
    $ips = @($segment)
    for ($i = 1; $i -lt 255; $i++) {
        $nextIP = [System.Net.IPAddress]($segment.GetAddressBytes() + $i)
        $ips += $nextIP
    }
    return $ips
}

# Prompt for IP input
#############################
$choice = Read-Host "Do you want to scan a single IP, an IP range, or an entire segment? (Enter 'single', 'range', or 'segment')"

switch ($choice) {
    'single' {
        $singleIP = Read-Host "Enter the IP address"
        $devices = @([PSCustomObject]@{IP = $singleIP})
    }
    'range' {
        $startIP = Read-Host "Enter the start IP address"
        $endIP = Read-Host "Enter the end IP address"
        $devices = Get-IPsInRange -startIP $startIP -endIP $endIP | ForEach-Object { [PSCustomObject]@{IP = $_.ToString()} }
    }
    'segment' {
        $segment = Read-Host "Enter the segment (e.g., 10.10.111.0)"
        $devices = Get-IPsInSegment -segment $segment | ForEach-Object { [PSCustomObject]@{IP = $_.ToString()} }
    }
    default {
        Write-Host "Invalid choice. Exiting script."
        exit
    }
}

# Main script to gather data from devices
#############################
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
            Log-Message "Success: Retrieved data for $ip"
        } catch {
            Log-Message "Error: Failed to retrieve information for $ip. Reason: $_"
        }
    } else {
        Log-Message "Warning: Device with IP $ip is not reachable."
    }
}

# Output the results and log the completion
#############################
$output | Format-Table -AutoSize
$output | Export-Csv -Path $outputFile -NoTypeInformation -Append
Log-Message "Script execution completed."

