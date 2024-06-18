# Load necessary assemblies for Windows Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to create and show a form for user input
function Get-UserChoice {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'IP Processing Tool'
    $form.Size = New-Object System.Drawing.Size(300,200)
    $form.StartPosition = 'CenterScreen'

    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(280,20)
    $label.Text = 'Please select an option:'
    $form.Controls.Add($label)

    $button1 = New-Object System.Windows.Forms.Button
    $button1.Location = New-Object System.Drawing.Point(10,50)
    $button1.Size = New-Object System.Drawing.Size(260,30)
    $button1.Text = '1. Input single IP'
    $button1.Add_Click({
        $form.Tag = '1'
        $form.Close()
    })
    $form.Controls.Add($button1)

    $button2 = New-Object System.Windows.Forms.Button
    $button2.Location = New-Object System.Drawing.Point(10,90)
    $button2.Size = New-Object System.Drawing.Size(260,30)
    $button2.Text = '2. Use devices.csv from desktop'
    $button2.Add_Click({
        $form.Tag = '2'
        $form.Close()
    })
    $form.Controls.Add($button2)

    $button3 = New-Object System.Windows.Forms.Button
    $button3.Location = New-Object System.Drawing.Point(10,130)
    $button3.Size = New-Object System.Drawing.Size(260,30)
    $button3.Text = '3. Input IP segment'
    $button3.Add_Click({
        $form.Tag = '3'
        $form.Close()
    })
    $form.Controls.Add($button3)

    $form.Add_Shown({$form.Activate()})
    [void] $form.ShowDialog()

    return $form.Tag
}

# Function to prompt for a single IP
function Process-SingleIP {
    $ip = [Microsoft.VisualBasic.Interaction]::InputBox("Enter the IP address", "Input Single IP")
    return @([PSCustomObject]@{IP = $ip})
}

# Function to process a segment of IPs
function Process-Segment {
    $segment = [Microsoft.VisualBasic.Interaction]::InputBox("Enter the IP segment (e.g., 192.168.1)", "Input Segment")
    $ips = 1..254 | ForEach-Object { "$segment.$_" }
    return $ips | ForEach-Object { [PSCustomObject]@{IP = $_} }
}

# Function to check if a file exists and load existing data if it does
function Load-ExistingData {
    $outputPath = "$([Environment]::GetFolderPath('Desktop'))\output.csv"
    if (Test-Path -Path $outputPath) {
        return Import-Csv -Path $outputPath
    } else {
        return @()
    }
}

# Function to save output data to CSV
function Save-OutputData {
    $outputPath = "$([Environment]::GetFolderPath('Desktop'))\output.csv"
    $global:outputDataList | Export-Csv -Path $outputPath -NoTypeInformation
    [System.Windows.Forms.MessageBox]::Show("Data saved to $outputPath", "Information", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}

# Setup variables and load existing data
$global:outputDataList = [System.Collections.ArrayList]@(Load-ExistingData)
$choice = Get-UserChoice
$devices = @()

# Processing based on user choice
switch ($choice) {
    '1' {
        $devices += Process-SingleIP
    }
    '2' {
        $csvPath = "$([Environment]::GetFolderPath('Desktop'))\devices.csv"
        if (Test-Path -Path $csvPath) {
            $devices += Import-Csv -Path $csvPath
        } else {
            [System.Windows.Forms.MessageBox]::Show("CSV file not found on the desktop.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            return
        }
    }
    '3' {
        $devices += Process-Segment
    }
    default {
        [System.Windows.Forms.MessageBox]::Show("Invalid choice. Exiting script.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }
}

# Process each device/IP
foreach ($device in $devices) {
    $ip = $device.IP
    $date = Get-Date -Format "M/dd/yyyy"
    $time = Get-Date -Format "HH:mm"
    $status = "Not Reachable"

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
        } catch {
            $status = "Failed to retrieve information. Error: $_"
        }
    }

    # Create output object
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
    $global:outputDataList.Add($outputData) | Out-Null
}

# Export all data to CSV
Save-OutputData


# Load necessary assemblies for Windows Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to create and show a form for user input
function Get-UserChoice {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'IP Processing Tool'
    $form.Size = New-Object System.Drawing.Size(300,200)
    $form.StartPosition = 'CenterScreen'

    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(280,20)
    $label.Text = 'Please select an option:'
    $form.Controls.Add($label)

    $button1 = New-Object System.Windows.Forms.Button
    $button1.Location = New-Object System.Drawing.Point(10,50)
    $button1.Size = New-Object System.Drawing.Size(260,30)
    $button1.Text = '1. Input single IP'
    $button1.Add_Click({
        $form.Tag = '1'
        $form.Close()
    })
    $form.Controls.Add($button1)

    $button2 = New-Object System.Windows.Forms.Button
    $button2.Location = New-Object System.Drawing.Point(10,90)
    $button2.Size = New-Object System.Drawing.Size(260,30)
    $button2.Text = '2. Use devices.csv from desktop'
    $button2.Add_Click({
        $form.Tag = '2'
        $form.Close()
    })
    $form.Controls.Add($button2)

    $button3 = New-Object System.Windows.Forms.Button
    $button3.Location = New-Object System.Drawing.Point(10,130)
    $button3.Size = New-Object System.Drawing.Size(260,30)
    $button3.Text = '3. Input IP segment'
    $button3.Add_Click({
        $form.Tag = '3'
        $form.Close()
    })
    $form.Controls.Add($button3)

    $form.Add_Shown({$form.Activate()})
    [void] $form.ShowDialog()

    return $form.Tag
}

# Function to prompt for a single IP
function Process-SingleIP {
    $ip = [Microsoft.VisualBasic.Interaction]::InputBox("Enter the IP address", "Input Single IP")
    return @([PSCustomObject]@{IP = $ip})
}

# Function to process a segment of IPs
function Process-Segment {
    $segment = [Microsoft.VisualBasic.Interaction]::InputBox("Enter the IP segment (e.g., 192.168.1)", "Input Segment")
    $ips = 1..254 | ForEach-Object { "$segment.$_" }
    return $ips | ForEach-Object { [PSCustomObject]@{IP = $_} }
}

# Function to check if a file exists and load existing data if it does
function Load-ExistingData {
    $outputPath = "$([Environment]::GetFolderPath('Desktop'))\output.csv"
    if (Test-Path -Path $outputPath) {
        return Import-Csv -Path $outputPath
    } else {
        return @()
    }
}

# Function to save output data to CSV
function Save-OutputData {
    $outputPath = "$([Environment]::GetFolderPath('Desktop'))\output.csv"
    $global:outputDataList | Export-Csv -Path $outputPath -NoTypeInformation
    [System.Windows.Forms.MessageBox]::Show("Data saved to $outputPath", "Information", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}

# Setup variables and load existing data
$global:outputDataList = [System.Collections.ArrayList]@(Load-ExistingData)
$choice = Get-UserChoice
$devices = @()

# Processing based on user choice
switch ($choice) {
    '1' {
        $devices += Process-SingleIP
    }
    '2' {
        $csvPath = "$([Environment]::GetFolderPath('Desktop'))\devices.csv"
        if (Test-Path -Path $csvPath) {
            $devices += Import-Csv -Path $csvPath
        } else {
            [System.Windows.Forms.MessageBox]::Show("CSV file not found on the desktop.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            return
        }
    }
    '3' {
        $devices += Process-Segment
    }
    default {
        [System.Windows.Forms.MessageBox]::Show("Invalid choice. Exiting script.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }
}

# Process each device/IP
foreach ($device in $devices) {
    $ip = $device.IP
    $date = Get-Date -Format "M/dd/yyyy"
    $time = Get-Date -Format "HH:mm"
    $status = "Not Reachable"

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
        } catch {
            $status = "Failed to retrieve information. Error: $_"
        }
    }

    # Create output object
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
    $global:outputDataList.Add($outputData) | Out-Null
}

# Export all data to CSV
Save-OutputData
