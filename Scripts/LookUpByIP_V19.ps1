# Load necessary assemblies for Windows Forms to create GUI elements
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to validate single IP input
function Validate-IP {
    param (
        [string]$ip
    )
    $regex = [regex]::new("^(([0-9]{1,3}\.){3}[0-9]{1,3})$")
    if ($regex.IsMatch($ip)) {
        $parts = $ip.Split('.')
        return $parts | ForEach-Object { $_ -ge 0 -and $_ -le 255 }
    }
    return $false
}

# Function to validate IP segment input
function Validate-IPSegment {
    param (
        [string]$segment
    )
    $regex = [regex]::new("^(([0-9]{1,3}\.){2}[0-9]{1,3})$")
    if ($regex.IsMatch($segment)) {
        $parts = $segment.Split('.')
        return $parts | ForEach-Object { $_ -ge 0 -and $_ -le 255 }
    }
    return $false
}

# Function to create and show a form for user input
function Get-UserChoice {
    # Create a new form object
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'IP Processing Tool'
    $form.Size = New-Object System.Drawing.Size(600,400)  # Double the size of the form
    $form.StartPosition = 'CenterScreen'

    # Create and configure a label on the form
    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(580,20)  # Adjust the size of the label
    $label.Text = 'Please select an option:'
    $label.Font = New-Object System.Drawing.Font("Arial", 14)  # Increase font size
    $form.Controls.Add($label)

    # Create and configure the first button (Single IP input)
    $button1 = New-Object System.Windows.Forms.Button
    $button1.Location = New-Object System.Drawing.Point(10,50)
    $button1.Size = New-Object System.Drawing.Size(560,30)  # Adjust the size of the button
    $button1.Text = '1. Input single IP'
    $button1.Font = New-Object System.Drawing.Font("Arial", 12)  # Increase font size
    $button1.Add_Click({
        $form.Tag = '1'  # Tag to identify which button was clicked
        $form.Close()    # Close the form
    })
    $form.Controls.Add($button1)

    # Create and configure the second button (Load from CSV)
    $button2 = New-Object System.Windows.Forms.Button
    $button2.Location = New-Object System.Drawing.Point(10,90)
    $button2.Size = New-Object System.Drawing.Size(560,30)  # Adjust the size of the button
    $button2.Text = '2. Select CSV file from computer'  # Changed the text to indicate file selection
    $button2.Font = New-Object System.Drawing.Font("Arial", 12)  # Increase font size
    $button2.Add_Click({
        $form.Tag = '2'  # Tag to identify which button was clicked
        $form.Close()    # Close the form
    })
    $form.Controls.Add($button2)

    # Create and configure the third button (Input IP segment)
    $button3 = New-Object System.Windows.Forms.Button
    $button3.Location = New-Object System.Drawing.Point(10,130)
    $button3.Size = New-Object System.Drawing.Size(560,30)  # Adjust the size of the button
    $button3.Text = '3. Input IP segment'
    $button3.Font = New-Object System.Drawing.Font("Arial", 12)  # Increase font size
    $button3.Add_Click({
        $form.Tag = '3'  # Tag to identify which button was clicked
        $form.Close()    # Close the form
    })
    $form.Controls.Add($button3)

    # Create and configure the fourth button (Load IP segments from CSV)
    $button4 = New-Object System.Windows.Forms.Button
    $button4.Location = New-Object System.Drawing.Point(10,170)
    $button4.Size = New-Object System.Drawing.Size(560,30)  # Adjust the size of the button
    $button4.Text = '4. Select CSV file with IP segments'  # Text for new IP segment file option
    $button4.Font = New-Object System.Drawing.Font("Arial", 12)  # Increase font size
    $button4.Add_Click({
        $form.Tag = '4'  # Tag to identify which button was clicked
        $form.Close()    # Close the form
    })
    $form.Controls.Add($button4)

    # Show the form and wait for user action
    $form.Add_Shown({$form.Activate()})
    [void] $form.ShowDialog()

    return $form.Tag  # Return the tag indicating the user's choice
}

# Function to create and show an input form with submit and back buttons
function Show-InputForm {
    param (
        [string]$title,
        [string]$prompt,
        [ref]$inputValue
    )

    # Create a new form object
    $form = New-Object System.Windows.Forms.Form
    $form.Text = $title
    $form.Size = New-Object System.Drawing.Size(600,400)  # Same size as the initial window
    $form.StartPosition = 'CenterScreen'

    # Create and configure a label on the form
    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(580,20)
    $label.Text = $prompt
    $label.Font = New-Object System.Drawing.Font("Arial", 14)  # Increase font size
    $form.Controls.Add($label)

    # Create and configure a text box for input
    $textbox = New-Object System.Windows.Forms.TextBox
    $textbox.Location = New-Object System.Drawing.Point(10,50)
    $textbox.Size = New-Object System.Drawing.Size(560,30)
    $textbox.Font = New-Object System.Drawing.Font("Arial", 12)  # Increase font size
    $form.Controls.Add($textbox)

    # Create and configure the submit button
    $submitButton = New-Object System.Windows.Forms.Button
    $submitButton.Location = New-Object System.Drawing.Point(10,90)
    $submitButton.Size = New-Object System.Drawing.Size(260,30)
    $submitButton.Text = 'Submit'
    $submitButton.Font = New-Object System.Drawing.Font("Arial", 12)  # Increase font size
    $submitButton.Add_Click({
        $inputValue.Value = $textbox.Text
        $form.Tag = 'submit'
        $form.Close()
    })
    $form.Controls.Add($submitButton)

    # Create and configure the back button
    $backButton = New-Object System.Windows.Forms.Button
    $backButton.Location = New-Object System.Drawing.Point(310,90)
    $backButton.Size = New-Object System.Drawing.Size(260,30)
    $backButton.Text = 'Back'
    $backButton.Font = New-Object System.Drawing.Font("Arial", 12)  # Increase font size
    $backButton.Add_Click({
        $form.Tag = 'back'
        $form.Close()
    })
    $form.Controls.Add($backButton)

    # Show the form and wait for user action
    $form.Add_Shown({$form.Activate()})
    [void] $form.ShowDialog()

    return $form.Tag  # Return the tag indicating the user's action
}

# Function to prompt the user for a single IP address
function Process-SingleIP {
    $inputValue = [ref]$null
    do {
        $result = Show-InputForm -title "Input Single IP" -prompt "Enter the IP address" -inputValue $inputValue
        if ($result -eq 'back') { return 'back' }
    } while (-not (Validate-IP -ip $inputValue.Value))
    return @([PSCustomObject]@{IP = $inputValue.Value})  # Return the IP as a custom object
}

# Function to prompt the user for an IP segment and generate IPs within that segment
function Process-Segment {
    $inputValue = [ref]$null
    do {
        $result = Show-InputForm -title "Input Segment" -prompt "Enter the IP segment (e.g., 192.168.1)" -inputValue $inputValue
        if ($result -eq 'back') { return 'back' }
    } while (-not (Validate-IPSegment -segment $inputValue.Value))
    $ips = 0..255 | ForEach-Object { "$($inputValue.Value).$_" }  # Generate IPs from 0 to 255 within the segment
    return $ips | ForEach-Object { [PSCustomObject]@{IP = $_} }  # Return each IP as a custom object
}

# Function to prompt the user for an IP segment file and generate IPs within those segments
function Process-SegmentFile {
    $csvPath = Select-CsvFile
    if ($csvPath -and (Test-Path -Path $csvPath)) {
        $segments = Import-Csv -Path $csvPath
        $allIps = @()
        foreach ($segment in $segments) {
            if (Validate-IPSegment -segment $segment.Segment) {
                $ips = 0..255 | ForEach-Object { "$($segment.Segment).$_" }
                $allIps += $ips | ForEach-Object { [PSCustomObject]@{IP = $_} }
            }
        }
        return $allIps
    } else {
        [System.Windows.Forms.MessageBox]::Show("CSV file not found or not selected.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return $null
    }
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
$devices = @()  # Initialize an empty array to store device information

do {
    $choice = Get-UserChoice  # Get user's choice from the form
    switch ($choice) {
        '1' {
            $result = Process-SingleIP  # Process single IP
            if ($result -eq 'back') { continue }
            $devices += $result
        }
        '2' {
            $csvPath = Select-CsvFile  # Prompt the user to select a CSV file
            if ($csvPath -and (Test-Path -Path $csvPath)) {
                $devices += Import-Csv -Path $csvPath  # Load devices from selected CSV
            } else {
                [System.Windows.Forms.MessageBox]::Show("CSV file not found or not selected.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
                continue
            }
        }
        '3' {
            $result = Process-Segment  # Process IP segment
            if ($result -eq 'back') { continue }
            $devices += $result
        }
        '4' {
            $result = Process-SegmentFile  # Process IP segments from file
            if ($result -eq 'back') { continue }
            $devices += $result
        }
        default {
            [System.Windows.Forms.MessageBox]::Show("Invalid choice. Exiting script.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            return  # Exit the script for an invalid choice
        }
    }
    break
} while ($true)

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
                $windowsVersion = $osVersion.Caption + " " + $osVersion.Version + " (Build " + $osVersion.BuildNumber + ")"
                # Determine the specific Windows version detail (22H2, 22H3, etc.)
                $versionDetail = if ($osVersion.Version -match "10.0.1904.") {
                    if ($osVersion.BuildNumber -ge 19042 -and $osVersion.BuildNumber -le 19044) { "22H2" }
                    elseif ($osVersion.BuildNumber -ge 19045) { "22H3" }
                    else { "Unknown Version" }
                } else { "Unknown Version" }
                $windowsVersion += " $versionDetail"
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
