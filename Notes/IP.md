# IP Scanner Script Documentation

## Project Overview

The IP Scanner script is designed to provide an interactive graphical user interface (GUI) for network administrators to perform IP address scanning tasks. This includes inputting individual IPs, processing IP segments, and loading IPs from CSV files for batch processing. It aims to facilitate the identification and cataloguing of network devices.

## Features

- **Single IP Processing:** Allows the user to input a single IP address and retrieve detailed system information.
- **IP Segment Processing:** Enables the user to input an IP segment to generate a list of IP addresses within that range.
- **CSV File Processing:** Supports loading IP addresses from a CSV file for batch processing.
- **Detailed Output:** Collects and displays information such as hostname, user, machine type, and OS version.
- **Output Saving:** Automatically saves scan results to a CSV file on the desktop.

## Technology Stack

- **PowerShell:** Utilizes PowerShell to script the core functionality.
- **Windows Forms:** Used for creating the GUI elements.
- **WMI (Windows Management Instrumentation):** Employed for gathering detailed system information from networked machines.

## Setup and Configuration

1. **Load Assemblies:** The script begins by loading necessary .NET assemblies for Windows Forms and drawing functionalities.
2. **GUI Initialization:** Initializes the main form and its components, including labels, buttons, and text boxes.
3. **Event Handling:** Each button in the GUI is tied to specific functions for handling IP input and processing.

## Usage

The script presents a window with several options:
1. **Input single IP:** Opens a form to enter a single IP address for scanning.
2. **Select CSV file from computer:** Allows the user to load a CSV file containing multiple IP addresses.
3. **Input IP segment:** Enables entering an IP range for generating and processing multiple IPs.
4. **Select CSV file with IP segments:** Loads and processes IP segments from a CSV file.

## How Is It Useful?

The IP Scanner script is particularly useful for network administrators who need to manage and troubleshoot networked devices:
- **Efficiency:** Quickly identifies devices on the network and collects essential data, reducing manual work.
- **Accuracy:** Ensures accurate information retrieval which is crucial for network management.
- **Scalability:** Capable of handling individual IPs or large batches from CSV files, making it adaptable to different sizes of networks.

## Potential Improvements

### GUI Enhancements

- **Modernization:** Update the GUI with a more modern framework like WPF (Windows Presentation Foundation) for improved aesthetics and functionality.
- **Responsiveness:** Improve the form responsiveness to different screen sizes and resolutions.
- **User Feedback:** Provide more interactive feedback during long operations, such as a progress bar or live logs of the scanning process.

### Functionality

- **Asynchronous Processing:** Implement asynchronous IP scanning to improve the performance and responsiveness of the application.
- **Advanced Filtering:** Add features to filter and sort the IP scan results based on different criteria like status, OS version, or last logged user.
- **Security Features:** Incorporate enhanced security measures to protect sensitive data collected during the scanning process.

### Error Handling

- **Comprehensive Logs:** Provide more detailed error logs to help in troubleshooting and understanding why certain IPs failed to respond.
- **User Guidance:** Offer suggestions for actions when errors occur, possibly linked to a help section or troubleshooting guide.

## Conclusion

This IP Scanner script is a powerful tool for network administrators, enhancing the efficiency of network management tasks. It simplifies the process of IP scanning and data collection, providing a robust solution for large-scale network environments.
