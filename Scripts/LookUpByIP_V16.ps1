# Load necessary assemblies for Windows Forms to create GUI elements
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to create and show a form for user input
function Get-UserChoice {
    # Create a new form object
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'IP Processing Tool'
    $form.Size = New-Object System.Drawing.Size(300,200)
    $form.StartPosition = 'CenterScreen'

    # Create and configure a label on the form
    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(280,20)
    $label.Text = 'Please select an option:'
    $form.Controls.Add($label)

    # Create and configure the first button (Single IP input)
    $button1 = New-Object System.Windows.Forms.Button
    $button1.Location = New-Object System.Drawing.Point(10,50)
    $button1.Size = New-Object System.Drawing.Size(260,30)
    $button1.Text = '1. Input single IP'
    $button1.Add_Click({
        $form.Tag = '1'  # Tag to identify which button was clicked
        $form.Close()    # Close the form
    })
    $form.Controls.Add($button1)

    # Create and configure the second button (Load from CSV)
    $button2 = New-Object System.Windows.Forms.Button
    $button2.Location = New-Object System.Drawing.Point(10,90)
    $button2.Size = New-Object System.Drawing.Size(260,30)
    $button2.Text = '2. Select CSV file from computer'  # Changed the text to indicate file selection
    $button2.Add_Click({
        $form.Tag = '2'  # Tag to identify which button was clicked
        $form.Close()    # Close the form
    })
    $form.Controls.Add($button2)

    # Create and configure the third button (Input IP segment)
    $button3 = New-Object System.Windows.Forms.Button
    $button3.Location = New-Object System.Drawing.Point(10,130)
    $button3.Size = New-Object System.Drawing.Size(260,30)
    $button3.Text = '3. Input IP segment'
    $button3.Add_Click({
        $form.Tag = '3'  # Tag to identify which button was clicked
        $form.Close()    # Close the form
    })
    $form.Controls.Add($button3)

    # Show the form and wait for user action
    $form.Add_Shown({$form.Activate()})
    [void] $form.ShowDialog()

    return $form.Tag  # Return the tag indicating the user's choice
}

# Function to prompt the user for a single IP address
function Process-SingleIP {
    $ip = [Microsoft.VisualBasic.Interaction]::InputBox("Enter the IP address", "Input Single IP")
    return @([PSCustomObject]@{IP = $ip})  # Return the IP as a custom object
}

# Function to prompt the user for an IP segment and generate IPs within that segment
function Process-Segment {
    $segment = [Microsoft.VisualBasic.Interaction]::InputBox("Enter the IP segment (e.g., 192.168.1)", "Input Segment")
    $ips = 1..254 | ForEach-Object { "$segment.$_" }  # Generate IPs from 1 to 254 within the segment
    return $ips | ForEach-Object { [PSCustomObject]@{IP = $_} }  # Return each IP as a custom object
}

# Function to check if the output file exists and load existing data if it does
function Load-ExistingData {
    $outputPath = "$([Environment]::GetFolderPath('Desktop'))\output.csv"
    if (Test-Path -Path $outputPath) {
        return Import-Csv -Path $outputPath  # Load existing data from CSV
    } else {
        return @()  # Return an empty array if the file does not exist
    }
}

# Function to save output data to a CSV file on the desktop
function Save-OutputData {
    $outputPath = "$([Environment]::GetFolderPath('Desktop'))\output.csv"
    $global:outputDataList | Export-Csv -Path $outputPath -NoTypeInformation  # Export data to CSV
    [System.Windows.Forms.MessageBox]::Show("Data saved to $outputPath", "Information", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}

# Function to prompt the user to select a CSV file
function Select-CsvFile {
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null

    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog
    $FileBrowser.Filter = "CSV Files (*.csv)|*.csv"
    $FileBrowser.ShowDialog() | Out-Null

    if ($FileBrowser.FileName -ne "") {
        return $FileBrowser.FileName
    } else {
        return $null
    }
}

# Setup variables and load existing data
$global:outputDataList = [System.Collections.ArrayList]@(Load-ExistingData)  # Global variable to store output data
$choice = Get-UserChoice  # Get user's choice from the form
$devices = @()  # Initialize an empty array to store device information

# Processing based on user choice
switch ($choice) {
    '1' {
        $devices += Process-SingleIP  # Process single IP
    }
    '2' {
        $csvPath = Select-CsvFile  # Prompt the user to select a CSV file
        if ($csvPath -and (Test-Path -Path $csvPath)) {
            $devices += Import-Csv -Path $csvPath  # Load devices from selected CSV
        } else {
            [System.Windows.Forms.MessageBox]::Show("CSV file not found or not selected.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            return  # Exit the script if CSV is not found or not selected
        }
    }
    '3' {
        $devices += Process-Segment  # Process IP segment
    }
    default {
        [System.Windows.Forms.MessageBox]::Show("Invalid choice. Exiting script.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return  # Exit the script for an invalid choice
    }
}

# Process each device/IP
foreach ($device in $devices) {
    $ip = $device.IP
    $date = Get-Date -Format "M/dd/yyyy"  # Get current date
    $time = Get-Date -Format "HH:mm"  # Get current time
    $status = "Not Reachable"
    $errorDetails = $null

    try {
        if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {  # Test if the IP is reachable
            try {
                # Attempt to retrieve system information using WMI queries
                $machineType = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ip -ErrorAction Stop
                $osVersion = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip -ErrorAction Stop
                $hostname = $machineType.Name
                $lastLoggedUser = (Get-WmiObject -Class Win32_NetworkLoginProfile -ComputerName $ip -ErrorAction Stop | Sort-Object -Property LastLogon -Descending | Select-Object -First 1).Name
                $windowsVersion = $osVersion.Caption + " " + $osVersion.Version + " (Build " + $osVersion.BuildNumber + ") 22h2"
                $status = "Complete"  # Status set to complete if all queries succeed
            } catch {
                # Handle specific exceptions
                if ($_.Exception.Message -match "The RPC server is unavailable") {
                    $status = "RPC server unavailable"
                    $errorDetails = "The RPC server is unavailable for $ip."
                } elseif ($_.Exception.Message -match "Access is denied") {
                    $status = "Access denied"
                    $errorDetails = "Access denied when attempting to connect to $ip."
                } else {
                    $status = "WMI Error"
                    $errorDetails = $_.Exception.Message
                }
                Write-Host "$ip - $status"
                continue  # Skip to the next IP
            }
        } else {
            $status = "Not Reachable"
        }
    } catch {
        # Handle errors during the connection test
        $status = "Connection error: $($_.Exception.Message)"
        $errorDetails = $_.Exception.Message
        Write-Host "$ip - $status"
        continue  # Skip to the next IP
    }

    # Log progress to terminal
    Write-Host "$ip - $status"

    # Create output object with the gathered data
    $outputData = [PSCustomObject]@{
        IP             = $ip
        Hostname       = if ($status -eq "Complete") { $hostname } else { "N/A" }
        LastLoggedUser = if ($status -eq "Complete") { $lastLoggedUser } else { "N/A" }
        MachineType    = if ($status -eq "Complete") { $machineType.Model } else { "N/A" }
        WindowsVersion = if ($status -eq "Complete") { $windowsVersion } else { "N/A" }
        Date           = $date
        Time           = $time
        Status         = $status
        ErrorDetails   = $errorDetails
    }
    $global:outputDataList.Add($outputData) | Out-Null  # Add the output data to the global list
}

# Export all data to CSV
Save-OutputData
