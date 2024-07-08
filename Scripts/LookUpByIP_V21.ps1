# Load necessary assemblies for Windows Forms to create GUI elements
# Load the Microsoft.VisualBasic assembly to use VisualBasic-specific functions
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
# Add the System.Windows.Forms assembly to create Windows Forms for the GUI
Add-Type -AssemblyName System.Windows.Forms
# Add the System.Drawing assembly to handle drawing objects and UI elements
Add-Type -AssemblyName System.Drawing

# Function to create and show a form for user input
function Get-UserChoice {
    # Create a new form object (window) for the main menu
    $form = New-Object System.Windows.Forms.Form
    # Set the title of the form window
    $form.Text = 'IP Processing Tool'
    # Set the size of the form window to 800x600 pixels
    $form.Size = New-Object System.Drawing.Size(800,600)
    # Center the form window on the screen when it appears
    $form.StartPosition = 'CenterScreen'
    # Make the form window non-resizable to maintain a consistent layout
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    # Disable the maximize button to prevent resizing
    $form.MaximizeBox = $false
    # Disable the minimize button to maintain focus on the form
    $form.MinimizeBox = $false

    # Create and configure a label on the form to display instructions
    $label = New-Object System.Windows.Forms.Label
    # Position the label at coordinates (20, 40) within the form
    $label.Location = New-Object System.Drawing.Point(20,40)
    # Set the size of the label to 760x40 pixels
    $label.Size = New-Object System.Drawing.Size(760,40)
    # Set the text of the label to instruct the user to select an option
    $label.Text = 'Please select an option:'
    # Set the font of the label to Arial, size 14 for readability
    $label.Font = New-Object System.Drawing.Font("Arial", 14)
    # Add the label to the form's control collection
    $form.Controls.Add($label)

    # Create and configure the first button (Single IP input)
    $button1 = New-Object System.Windows.Forms.Button
    # Position the button at coordinates (20, 100) within the form
    $button1.Location = New-Object System.Drawing.Point(20,100)
    # Set the size of the button to 760x60 pixels
    $button1.Size = New-Object System.Drawing.Size(760,60)
    # Set the text of the button to indicate single IP input
    $button1.Text = '1. Input single IP'
    # Set the font of the button to Arial, size 12 for consistency and readability
    $button1.Font = New-Object System.Drawing.Font("Arial", 12)
    # Add a click event handler to the button to set the form's tag to '1' and close the form
    $button1.Add_Click({
        $form.Tag = '1'  # Set the form's tag to '1' to indicate this option was selected
        $form.Close()    # Close the form
    })
    # Add the button to the form's control collection
    $form.Controls.Add($button1)

    # Create and configure the second button (Load from CSV)
    $button2 = New-Object System.Windows.Forms.Button
    # Position the button at coordinates (20, 180) within the form
    $button2.Location = New-Object System.Drawing.Point(20,180)
    # Set the size of the button to 760x60 pixels
    $button2.Size = New-Object System.Drawing.Size(760,60)
    # Set the text of the button to indicate loading from a CSV file
    $button2.Text = '2. Select CSV file from computer'
    # Set the font of the button to Arial, size 12 for consistency and readability
    $button2.Font = New-Object System.Drawing.Font("Arial", 12)
    # Add a click event handler to the button to set the form's tag to '2' and close the form
    $button2.Add_Click({
        $form.Tag = '2'  # Set the form's tag to '2' to indicate this option was selected
        $form.Close()    # Close the form
    })
    # Add the button to the form's control collection
    $form.Controls.Add($button2)

    # Create and configure the third button (Input IP segment)
    $button3 = New-Object System.Windows.Forms.Button
    # Position the button at coordinates (20, 260) within the form
    $button3.Location = New-Object System.Drawing.Point(20,260)
    # Set the size of the button to 760x60 pixels
    $button3.Size = New-Object System.Drawing.Size(760,60)
    # Set the text of the button to indicate IP segment input
    $button3.Text = '3. Input IP segment'
    # Set the font of the button to Arial, size 12 for consistency and readability
    $button3.Font = New-Object System.Drawing.Font("Arial", 12)
    # Add a click event handler to the button to set the form's tag to '3' and close the form
    $button3.Add_Click({
        $form.Tag = '3'  # Set the form's tag to '3' to indicate this option was selected
        $form.Close()    # Close the form
    })
    # Add the button to the form's control collection
    $form.Controls.Add($button3)

    # Create and configure the fourth button (Upload IP segment CSV)
    $button4 = New-Object System.Windows.Forms.Button
    # Position the button at coordinates (20, 340) within the form
    $button4.Location = New-Object System.Drawing.Point(20,340)
    # Set the size of the button to 760x60 pixels
    $button4.Size = New-Object System.Drawing.Size(760,60)
    # Set the text of the button to indicate selecting a CSV file with IP segments
    $button4.Text = '4. Select CSV file with IP segments'
    # Set the font of the button to Arial, size 12 for consistency and readability
    $button4.Font = New-Object System.Drawing.Font("Arial", 12)
    # Add a click event handler to the button to set the form's tag to '4' and close the form
    $button4.Add_Click({
        $form.Tag = '4'  # Set the form's tag to '4' to indicate this option was selected
        $form.Close()    # Close the form
    })
    # Add the button to the form's control collection
    $form.Controls.Add($button4)

    # Show the form and wait for user action
    # Activate the form to ensure it is brought to the front
    $form.Add_Shown({$form.Activate()})
    # Display the form as a modal dialog box, blocking other user inputs
    [void] $form.ShowDialog()

    # Return the tag value indicating the user's choice
    return $form.Tag
}

# Function to prompt the user for a single IP address
function Process-SingleIP {
    # Create a new form object (window) for single IP input
    $form = New-Object System.Windows.Forms.Form
    # Set the title of the form window
    $form.Text = 'Input Single IP'
    # Set the size of the form window to 800x400 pixels
    $form.Size = New-Object System.Drawing.Size(800,400)
    # Center the form window on the screen when it appears
    $form.StartPosition = 'CenterScreen'
    # Make the form window non-resizable to maintain a consistent layout
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    # Disable the maximize button to prevent resizing
    $form.MaximizeBox = $false
    # Disable the minimize button to maintain focus on the form
    $form.MinimizeBox = $false

    # Create and configure a label on the form to prompt for IP input
    $label = New-Object System.Windows.Forms.Label
    # Position the label at coordinates (20, 20) within the form
    $label.Location = New-Object System.Drawing.Point(20,20)
    # Set the size of the label to 760x40 pixels
    $label.Size = New-Object System.Drawing.Size(760,40)
    # Set the text of the label to instruct the user to enter an IP address
    $label.Text = 'Enter the IP address:'
    # Set the font of the label to Arial, size 14 for readability
    $label.Font = New-Object System.Drawing.Font("Arial", 14)
    # Add the label to the form's control collection
    $form.Controls.Add($label)

    # Create and configure a text box for IP input
    $textbox = New-Object System.Windows.Forms.TextBox
    # Position the text box at coordinates (20, 80) within the form
    $textbox.Location = New-Object System.Drawing.Point(20,80)
    # Set the size of the text box to 760x40 pixels
    $textbox.Size = New-Object System.Drawing.Size(760,40)
    # Set the font of the text box to Arial, size 14 for readability
    $textbox.Font = New-Object System.Drawing.Font("Arial", 14)
    # Add the text box to the form's control collection
    $form.Controls.Add($textbox)

    # Create and configure the submit button
    $submit = New-Object System.Windows.Forms.Button
    # Position the submit button at coordinates (20, 140) within the form
    $submit.Location = New-Object System.Drawing.Point(20,140)
    # Set the size of the submit button to 360x60 pixels
    $submit.Size = New-Object System.Drawing.Size(360,60)
    # Set the text of the submit button
    $submit.Text = 'Submit'
    # Set the font of the submit button to Arial, size 12 for consistency and readability
    $submit.Font = New-Object System.Drawing.Font("Arial", 12)
    # Add a click event handler to the submit button to capture the entered IP and close the form
    $submit.Add_Click({
        $form.Tag = $textbox.Text  # Store the entered text in the form's tag
        $form.Close()  # Close the form
    })
    # Add the submit button to the form's control collection
    $form.Controls.Add($submit)

    # Create and configure the back button
    $back = New-Object System.Windows.Forms.Button
    # Position the back button at coordinates (420, 140) within the form
    $back.Location = New-Object System.Drawing.Point(420,140)
    # Set the size of the back button to 360x60 pixels
    $back.Size = New-Object System.Drawing.Size(360,60)
    # Set the text of the back button
    $back.Text = 'Back'
    # Set the font of the back button to Arial, size 12 for consistency and readability
    $back.Font = New-Object System.Drawing.Font("Arial", 12)
    # Add a click event handler to the back button to indicate going back and close the form
    $back.Add_Click({
        $form.Tag = 'back'  # Tag to indicate the 'back' action
        $form.Close()  # Close the form
    })
    # Add the back button to the form's control collection
    $form.Controls.Add($back)

    # Show the form and wait for user action
    # Activate the form to ensure it is brought to the front
    $form.Add_Shown({$form.Activate()})
    # Display the form as a modal dialog box, blocking other user inputs
    [void] $form.ShowDialog()

    # Check if the user clicked 'back' to return null
    if ($form.Tag -eq 'back') {
        return $null  # Indicate that user wants to go back
    } else {
        # Return the entered IP as a custom object
        return @([PSCustomObject]@{IP = $form.Tag})
    }
}

# Function to prompt the user for an IP segment and generate IPs within that segment
function Process-Segment {
    # Create a new form object (window) for IP segment input
    $form = New-Object System.Windows.Forms.Form
    # Set the title of the form window
    $form.Text = 'Input IP Segment'
    # Set the size of the form window to 800x400 pixels
    $form.Size = New-Object System.Drawing.Size(800,400)
    # Center the form window on the screen when it appears
    $form.StartPosition = 'CenterScreen'
    # Make the form window non-resizable to maintain a consistent layout
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    # Disable the maximize button to prevent resizing
    $form.MaximizeBox = $false
    # Disable the minimize button to maintain focus on the form
    $form.MinimizeBox = $false

    # Create and configure a label on the form to prompt for IP segment input
    $label = New-Object System.Windows.Forms.Label
    # Position the label at coordinates (20, 20) within the form
    $label.Location = New-Object System.Drawing.Point(20,20)
    # Set the size of the label to 760x40 pixels
    $label.Size = New-Object System.Drawing.Size(760,40)
    # Set the text of the label to instruct the user to enter an IP segment
    $label.Text = 'Enter the IP segment (e.g., 192.168.1):'
    # Set the font of the label to Arial, size 14 for readability
    $label.Font = New-Object System.Drawing.Font("Arial", 14)
    # Add the label to the form's control collection
    $form.Controls.Add($label)

    # Create and configure a text box for IP segment input
    $textbox = New-Object System.Windows.Forms.TextBox
    # Position the text box at coordinates (20, 80) within the form
    $textbox.Location = New-Object System.Drawing.Point(20,80)
    # Set the size of the text box to 760x40 pixels
    $textbox.Size = New-Object System.Drawing.Size(760,40)
    # Set the font of the text box to Arial, size 14 for readability
    $textbox.Font = New-Object System.Drawing.Font("Arial", 14)
    # Add the text box to the form's control collection
    $form.Controls.Add($textbox)

    # Create and configure the submit button
    $submit = New-Object System.Windows.Forms.Button
    # Position the submit button at coordinates (20, 140) within the form
    $submit.Location = New-Object System.Drawing.Point(20,140)
    # Set the size of the submit button to 360x60 pixels
    $submit.Size = New-Object System.Drawing.Size(360,60)
    # Set the text of the submit button
    $submit.Text = 'Submit'
    # Set the font of the submit button to Arial, size 12 for consistency and readability
    $submit.Font = New-Object System.Drawing.Font("Arial", 12)
    # Add a click event handler to the submit button to capture the entered segment and close the form
    $submit.Add_Click({
        $form.Tag = $textbox.Text  # Store the entered text in the form's tag
        $form.Close()  # Close the form
    })
    # Add the submit button to the form's control collection
    $form.Controls.Add($submit)

    # Create and configure the back button
    $back = New-Object System.Windows.Forms.Button
    # Position the back button at coordinates (420, 140) within the form
    $back.Location = New-Object System.Drawing.Point(420,140)
    # Set the size of the back button to 360x60 pixels
    $back.Size = New-Object System.Drawing.Size(360,60)
    # Set the text of the back button
    $back.Text = 'Back'
    # Set the font of the back button to Arial, size 12 for consistency and readability
    $back.Font = New-Object System.Drawing.Font("Arial", 12)
    # Add a click event handler to the back button to indicate going back and close the form
    $back.Add_Click({
        $form.Tag = 'back'  # Tag to indicate the 'back' action
        $form.Close()  # Close the form
    })
    # Add the back button to the form's control collection
    $form.Controls.Add($back)

    # Show the form and wait for user action
    # Activate the form to ensure it is brought to the front
    $form.Add_Shown({$form.Activate()})
    # Display the form as a modal dialog box, blocking other user inputs
    [void] $form.ShowDialog()

    # Check if the user clicked 'back' to return null
    if ($form.Tag -eq 'back') {
        return $null  # Indicate that user wants to go back
    } else {
        # Generate a range of IP addresses based on the entered segment
        $segment = $form.Tag
        $ips = 0..255 | ForEach-Object { "$segment.$_" }
        # Return the list of generated IPs as custom objects
        return $ips | ForEach-Object { [PSCustomObject]@{IP = $_} }
    }
}

# Function to prompt the user to select a CSV file with IP segments
function Process-SegmentCsvFile {
    # Prompt the user to select a CSV file
    $csvPath = Select-CsvFile
    # Check if a valid CSV file path was selected
    if ($csvPath -and (Test-Path -Path $csvPath)) {
        # Import the CSV file containing IP segments
        $segments = Import-Csv -Path $csvPath
        # Generate a list of IP addresses for each segment in the CSV
        $ips = foreach ($segment in $segments) {
            $baseSegment = $segment.IP  # Get the base segment from the CSV
            # Generate IP addresses from .0 to .255 for each segment
            0..255 | ForEach-Object { "$baseSegment.$_" }
        }
        # Return the list of generated IPs as custom objects
        return $ips | ForEach-Object { [PSCustomObject]@{IP = $_} }
    } else {
        # Show an error message if the CSV file was not found or not selected
        [System.Windows.Forms.MessageBox]::Show("CSV file not found or not selected.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return $null  # Return null to indicate an error occurred
    }
}

# Function to check if the output file exists and load existing data if it does
function Load-ExistingData {
    # Define the path to the output CSV file on the user's desktop
    $outputPath = "$([Environment]::GetFolderPath('Desktop'))\output.csv"
    # Check if the output file exists at the specified path
    if (Test-Path -Path $outputPath) {
        # If the file exists, import and return the existing data
        return Import-Csv -Path $outputPath
    } else {
        # If the file does not exist, return an empty array
        return @()
    }
}

# Function to save output data to a CSV file on the desktop
function Save-OutputData {
    # Check if the script should skip saving (e.g., if the back button was pressed)
    if ($global:skipSave) { return }
    # Define the path to the output CSV file on the user's desktop
    $outputPath = "$([Environment]::GetFolderPath('Desktop'))\output.csv"
    # Export the global output data list to the CSV file
    $global:outputDataList | Export-Csv -Path $outputPath -NoTypeInformation
    # Show a message box indicating that the data has been saved
    [System.Windows.Forms.MessageBox]::Show("Data saved to $outputPath", "Information", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
}

# Function to prompt the user to select a CSV file
function Select-CsvFile {
    # Load necessary assemblies for Windows Forms and Drawing (if not already loaded)
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null

    # Create a new file dialog for selecting a CSV file
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog
    # Set the file filter to only show CSV files
    $FileBrowser.Filter = "CSV Files (*.csv)|*.csv"
    # Show the file dialog and wait for user input
    $FileBrowser.ShowDialog() | Out-Null

    # Check if the user selected a file
    if ($FileBrowser.FileName -ne "") {
        # Return the selected file path
        return $FileBrowser.FileName
    } else {
        # Return null if no file was selected
        return $null
    }
}

# Function to detect the correct Windows version
function Get-WindowsVersion {
    param ($ip)  # Accept an IP address as a parameter
    try {
        # Query the operating system information from the specified IP address using WMI
        $osVersion = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ip -ErrorAction Stop
        # Determine the Windows version based on the build number
        $version = switch ($osVersion.BuildNumber) {
            {$_ -eq 19042} {'20H2'}
            {$_ -eq 19043} {'21H1'}
            {$_ -eq 19044} {'21H2'}
            {$_ -eq 19045} {'22H2'}
            {$_ -eq 22631} {'22H3'}
            default {"Unknown"}
        }
        # Return the operating system caption along with the determined version and build number
        return "$($osVersion.Caption) $version (Build $($osVersion.BuildNumber))"
    } catch {
        # Return "Unknown" if there was an error querying the information
        return "Unknown"
    }
}

# Setup variables and load existing data
# Initialize a global variable to store output data, loading existing data from the output CSV if it exists
$global:outputDataList = [System.Collections.ArrayList]@(Load-ExistingData)
# Initialize a global variable to control whether data should be saved (used for the back button functionality)
$global:skipSave = $false

# Add a handler to save the output data on script termination
$terminationHandler = {
    Save-OutputData
    Write-Host "Script terminated. Data saved."
}

# Register the handler for script termination
Register-EngineEvent -SourceIdentifier "powershell.exiting" -Action $terminationHandler

# Start an infinite loop to repeatedly prompt the user for actions until they choose to exit
try {
    while ($true) {
        # Get the user's choice from the main menu form
        $choice = Get-UserChoice
        # Break the loop if the user closed the form (returned null)
        if ($choice -eq $null) {
            break
        }

        # Initialize an empty array to store device information
        $devices = @()

        # Process the user's choice based on the returned tag value
        switch ($choice) {
            '1' {
                # Process single IP input
                $device = Process-SingleIP
                # If the user chose to go back, set the skipSave flag and restart the loop
                if ($device -eq $null) {
                    $global:skipSave = $true
                    continue
                }
                # Add the processed single IP to the devices array
                $devices += $device
            }
            '2' {
                # Prompt the user to select a CSV file
                $csvPath = Select-CsvFile
                # If a valid CSV file was selected, import the devices from the CSV
                if ($csvPath -and (Test-Path -Path $csvPath)) {
                    $devices += Import-Csv -Path $csvPath
                } else {
                    # Show an error message if the CSV file was not found or not selected
                    [System.Windows.Forms.MessageBox]::Show("CSV file not found or not selected.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
                    # Set the skipSave flag and restart the loop
                    $global:skipSave = $true
                    continue
                }
            }
            '3' {
                # Process IP segment input
                $device = Process-Segment
                # If the user chose to go back, set the skipSave flag and restart the loop
                if ($device -eq $null) {
                    $global:skipSave = $true
                    continue
                }
                # Add the processed IP segment to the devices array
                $devices += $device
            }
            '4' {
                # Process IP segments from a CSV file
                $device = Process-SegmentCsvFile
                # If the user chose to go back, set the skipSave flag and restart the loop
                if ($device -eq $null) {
                    $global:skipSave = $true
                    continue
                }
                # Add the processed IP segments to the devices array
                $devices += $device
            }
            default {
                # Show an error message for an invalid choice and exit the script
                [System.Windows.Forms.MessageBox]::Show("Invalid choice. Exiting script.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
                return
            }
        }

        # Reset the skipSave flag if processing continues
        $global:skipSave = $false

        # Process each device/IP in the devices array
        foreach ($device in $devices) {
            $ip = $device.IP
            $date = Get-Date -Format "M/dd/yyyy"  # Get the current date
            $time = Get-Date -Format "HH:mm"  # Get the current time
            $status = "Not Reachable"
            $errorDetails = $null

            try {
                # Test if the IP is reachable using the Test-Connection cmdlet
                if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {
                    try {
                        # Retrieve system information using WMI queries
                        $machineType = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ip -ErrorAction Stop
                        $hostname = $machineType.Name
                        $lastLoggedUser = (Get-WmiObject -Class Win32_NetworkLoginProfile -ComputerName $ip -ErrorAction Stop | Sort-Object -Property LastLogon -Descending | Select-Object -First 1).Name
                        $windowsVersion = Get-WindowsVersion -ip $ip
                        $status = "Complete"
                    } catch {
                        # Handle specific WMI query exceptions
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
                        continue
                    }
                } else {
                    $status = "Not Reachable"
                }
            } catch {
                # Handle errors during the connection test
                $status = "Connection error: $($_.Exception.Message)"
                $errorDetails = $_.Exception.Message
                Write-Host "$ip - $status"
                continue
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
            # Add the output data to the global list
            $global:outputDataList.Add($outputData) | Out-Null
        }

        # Save the output data to a CSV file on the desktop
        Save-OutputData
    }
} finally {
    # Save the output data when the script terminates
    Save-OutputData
}
