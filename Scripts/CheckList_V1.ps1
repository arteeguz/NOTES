# Load the required assemblies
Add-Type -AssemblyName PresentationCore,PresentationFramework

# Define the output CSV file path
$outputFile = "$([Environment]::GetFolderPath('Desktop'))\CheckListOutput.csv"

# Create a new window
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" 
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Application Checklist" Height="350" Width="500">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="Auto"/>
            <ColumnDefinition Width="*"/>
        </Grid.ColumnDefinitions>
        
        <TextBlock Grid.Row="0" Grid.Column="0" Margin="10" VerticalAlignment="Center">Enter your name:</TextBlock>
        <TextBox x:Name="UserName" Grid.Row="0" Grid.Column="1" Margin="10"/>
        
        <TextBlock Grid.Row="1" Grid.Column="0" Margin="10" VerticalAlignment="Center">Select a program:</TextBlock>
        <ComboBox x:Name="ProgramSelection" Grid.Row="1" Grid.Column="1" Margin="10">
            <ComboBoxItem Content="BCS"/>
            <ComboBoxItem Content="CM"/>
            <ComboBoxItem Content="CB"/>
            <ComboBoxItem Content="GIB"/>
            <ComboBoxItem Content="GM"/>
            <ComboBoxItem Content="GM-Quant"/>
            <ComboBoxItem Content="IA"/>
            <ComboBoxItem Content="MF"/>
            <ComboBoxItem Content="QTS"/>
            <ComboBoxItem Content="RECP"/>
        </ComboBox>
        
        <StackPanel x:Name="ChecklistPanel" Grid.Row="2" Grid.Column="0" Grid.ColumnSpan="2" Margin="10">
            <!-- Checklist items will be added here dynamically -->
        </StackPanel>
        
        <TextBlock Grid.Row="3" Grid.Column="0" Margin="10" VerticalAlignment="Center">Notes:</TextBlock>
        <TextBox x:Name="Notes" Grid.Row="3" Grid.Column="1" Margin="10"/>
        
        <Button x:Name="SubmitButton" Grid.Row="4" Grid.Column="0" Grid.ColumnSpan="2" Margin="10" Width="100" HorizontalAlignment="Center">Submit</Button>
    </Grid>
</Window>
"@

# Load XAML
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$Window = [Windows.Markup.XamlReader]::Load($reader)

# Get controls from XAML
$UserName = $Window.FindName("UserName")
$ProgramSelection = $Window.FindName("ProgramSelection")
$ChecklistPanel = $Window.FindName("ChecklistPanel")
$Notes = $Window.FindName("Notes")
$SubmitButton = $Window.FindName("SubmitButton")

# Define application checklists for each program
$checklists = @{
    "BCS" = @("Change Password", "Wizard", "Outlook/Webex", "RSA")
    "CM" = @("Change Password", "Wizard", "Outlook/Webex", "RSA")
    "CB" = @("Change Password", "Wizard", "Outlook/Webex", "RSA")
    "GIB" = @("Change Password", "Wizard", "Outlook/Webex", "RSA")
    "GM" = @("Change Password", "Wizard", "Outlook/Webex", "RSA")
    "GM-Quant" = @("Change Password", "Wizard", "Outlook/Webex", "RSA")
    "IA" = @("Change Password", "Wizard", "Outlook/Webex", "RSA")
    "MF" = @("Change Password", "Wizard", "Outlook/Webex", "RSA")
    "QTS" = @("Change Password", "Wizard", "Outlook/Webex", "RSA")
    "RECP" = @("Change Password", "Wizard", "Outlook/Webex", "RSA")
}

# Function to update checklist based on selected program
function Update-Checklist {
    $ChecklistPanel.Children.Clear()
    $selectedProgram = $ProgramSelection.SelectedItem.Content
    $checklistItems = $checklists[$selectedProgram]

    foreach ($item in $checklistItems) {
        $checkbox = New-Object Windows.Controls.CheckBox
        $checkbox.Content = $item
        $ChecklistPanel.Children.Add($checkbox)
    }
}

# Event handler for program selection change
$ProgramSelection.add_SelectionChanged({
    Update-Checklist
})

# Event handler for submit button
$SubmitButton.Add_Click({
    $userName = $UserName.Text
    $selectedProgram = $ProgramSelection.SelectedItem.Content
    $notes = $Notes.Text
    $date = Get-Date -Format "yyyy-MM-dd"
    $time = Get-Date -Format "HH:mm:ss"

    $outputData = @()
    foreach ($child in $ChecklistPanel.Children) {
        $status = if ($child.IsChecked) { "Completed" } else { "Not Completed" }
        $outputData += [PSCustomObject]@{
            Program = $selectedProgram
            User = $userName
            Status = $status
            Notes = $notes
            Date = $date
            Time = $time
        }
    }

    if (-not (Test-Path $outputFile)) {
        $outputData | Export-Csv -Path $outputFile -NoTypeInformation
    } else {
        $outputData | Export-Csv -Path $outputFile -NoTypeInformation -Append
    }

    [System.Windows.MessageBox]::Show("Checklist submitted successfully!", "Success", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information)
})

# Show the window
$Window.ShowDialog() | Out-Null
