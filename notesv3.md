# IT Notes

## Comparison

| Tool/Concept              | Purpose                                | Key Features                                                      | When to Use                                       | Baseline Requirements                          |
|---------------------------|----------------------------------------|-------------------------------------------------------------------|--------------------------------------------------|------------------------------------------------|
| **MDT (Microsoft Deployment Toolkit)** | Automates Windows OS and application deployment | Lite Touch Installation, Zero Touch Installation, USMT (User State Migration Tool) integration | Deploying new OS and applications across multiple computers | Windows Server, MDT installed, Deployment share configured, Network access |
| **WAIK (Windows Automated Installation Kit)** | Helps in deploying Windows OS with custom settings | WSIM (Windows System Image Manager) for answer files, ImageX for capturing images, command-line tools | Customizing and deploying Windows installations | Windows system, WAIK installed, Admin privileges |
| **Task Sequences (TS)**   | Automates steps in deployment process  | Customizable steps, conditions, branching                         | Ensuring all new computers have a standard configuration | MDT or SCCM (System Center Configuration Manager) installed, Task sequence template, Network access |
| **Build**                 | Creating a deployable system image     | Combines OS, applications, updates, settings                      | Creating a standardized image for multiple computers | Reference computer, OS and applications installed, Admin privileges, Sysprep (System Preparation Tool) |
| **Golden / Pristine Image** | Master image for consistent deployments | Clean, fully updated, contains critical apps                      | Baseline for all future deployments              | Reference computer, OS and applications installed, Admin privileges, Sysprep |
| **WIM (Windows Imaging Format)** | File-based disk image format       | Multiple images in one file, compression, mounting/modification   | Capturing, modifying, and deploying system images | ImageX or DISM (Deployment Image Servicing and Management), Admin privileges, Storage for WIM files |
| **LDAP (Lightweight Directory Access Protocol)** | Access/manage directory info | Hierarchical structure, standard protocol                         | User authentication, centralized directory services, SSO (Single Sign-On) | LDAP server, Network access, Directory schema configured |

## MDT / WAIK (Microsoft Deployment Toolkit / Windows Automated Installation Kit)

### MDT (Microsoft Deployment Toolkit)
- **Purpose:** Automates deployment of Windows OS and applications.
- **Features:**
  - Lite Touch Installation (LTI)
  - Zero Touch Installation (ZTI) with System Center Configuration Manager (SCCM)
  - User State Migration Tool (USMT) integration for user data migration
- **Scenario: Company-wide OS Upgrade**
  - **When to Use:** When you need to deploy a new version of Windows across all company computers.
  - **How to Use:**
    1. **Install MDT** on a server.
    2. **Create a deployment share** for storing OS images, applications, and drivers.
    3. **Import the new OS** version into the deployment share.
    4. **Create task sequences** to automate the installation process, including application and driver installations.
    5. **Update the deployment share** and create bootable media (USB or ISO).
    6. **Deploy the new OS** to all computers using network boot or bootable media.
- **Quick Reference Commands:**
  - **Create deployment share:**
    ```powershell
    New-Item -Path "C:\DeploymentShare" -ItemType Directory
    ```
  - **Import OS:**
    ```powershell
    Import-MDTOperatingSystem
    ```
  - **Update deployment share:**
    ```powershell
    Update-MDTDeploymentShare
    ```

### WAIK (Windows Automated Installation Kit)
- **Purpose:** Helps in deploying Windows OS with custom settings.
- **Features:**
  - Includes tools like Windows System Image Manager (WSIM), ImageX, and more.
  - Used for creating and customizing Windows images.
  - Provides command-line tools for deployment.
- **Scenario: Customizing Windows Installation**
  - **When to Use:** When you need to create a custom Windows installation with specific settings and applications.
  - **How to Use:**
    1. **Install WAIK** on your computer.
    2. Use **Windows System Image Manager (WSIM)** to create an answer file (.xml) for an unattended installation.
    3. Use **ImageX** to capture a base image of Windows.
    4. Apply the answer file to the image to customize the installation.
    5. Deploy the customized image using MDT or other deployment tools.
- **Quick Reference Commands:**
  - **Create answer file:**
    - Use WSIM (GUI tool)
  - **Capture image:**
    ```cmd
    ImageX /capture C: D:\Images\MyImage.wim "My Windows Image"
    ```

## Task Sequences (TS)
- **Purpose:** Automates the steps in the deployment process.
- **Features:**
  - Customizable steps for OS deployment, application installation, driver installation, etc.
  - Can include conditions and branching.
- **Scenario: Automated Deployment of Standard Configuration**
  - **When to Use:** When you need to ensure all new computers have a standard configuration, including OS, applications, and settings.
  - **How to Use:**
    1. **Create a task sequence** in MDT.
    2. Choose a template (e.g., Standard Client Task Sequence).
    3. **Customize the task sequence** by adding steps for OS installation, application installation, and configuration settings.
    4. Use the task sequence during deployment to automate the entire process.
- **Quick Reference Commands:**
  - **Create new task sequence in MDT:**
    - Use MDT GUI

## Build
- **Purpose:** The process of creating a deployable system image.
- **Features:**
  - Combines OS, applications, updates, and settings into a single image.
  - Ensures consistency across multiple deployments.
- **Scenario: Creating a Standardized System Image**
  - **When to Use:** When you need to create a standardized image that can be deployed to multiple computers.
  - **How to Use:**
    1. **Prepare a reference computer** with the desired OS, applications, and settings.
    2. Use **Sysprep (System Preparation Tool)** to generalize the system (removes unique information).
    3. **Capture the image** using ImageX or MDT.
    4. **Store the image** in the deployment share for future use.
- **Quick Reference Commands:**
  - **Sysprep:**
    ```cmd
    C:\Windows\System32\Sysprep\Sysprep.exe /generalize /oobe /shutdown
    ```
  - **Capture image:**
    ```cmd
    ImageX /capture C: D:\Images\GoldenImage.wim "Golden Image"
    ```

## Golden / Pristine Image
- **Purpose:** A master image that is clean, fully updated, and configured as a standard for deployment.
- **Features:**
  - Contains OS, critical updates, and core applications.
  - Used as a baseline for creating new deployments.
- **Scenario: Ensuring Consistency Across Deployments**
  - **When to Use:** When you need a clean, fully updated image as a baseline for all future deployments.
  - **How to Use:**
    1. Install a fresh copy of the OS on a reference machine.
    2. **Apply all updates** and install core applications.
    3. **Configure system settings** as needed.
    4. Use **Sysprep (System Preparation Tool)** to generalize the image.
    5. **Capture the image** using ImageX or MDT.
    6. **Store the golden image** in the deployment share for future use.
- **Quick Reference Commands:**
  - **Sysprep:**
    ```cmd
    C:\Windows\System32\Sysprep\Sysprep.exe /generalize /oobe /shutdown
    ```
  - **Capture image:**
    ```cmd
    ImageX /capture C: D:\Images\GoldenImage.wim "Golden Image"
    ```

## WIM (Windows Imaging Format)
- **Purpose:** File-based disk image format used by Microsoft for deployment.
- **Features:**
  - Can capture multiple images within a single WIM file.
  - Allows for compression to save space.
  - Supports image mounting and modification.
- **Scenario: Managing and Modifying System Images**
  - **When to Use:** When you need to capture, modify, and deploy system images.
  - **How to Use:**
    1. Use **ImageX** or **DISM (Deployment Image Servicing and Management)** to capture a WIM image of a system.
    2. To modify the image, use **DISM** to mount the WIM image.
       - Command: `DISM /Mount-WIM /WimFile:D:\Images\MyImage.wim /Index:1 /MountDir:C:\Mount`
    3. Make the necessary modifications to the mounted image.
    4. Unmount the image and commit changes:
       - Command: `DISM /Unmount-WIM /MountDir:C:\Mount /Commit`
    5. Deploy the WIM image to target machines as needed.
- **Quick Reference Commands:**
  - **Mount WIM:**
    ```cmd
    DISM /Mount-WIM /WimFile:D:\Images\MyImage.wim /Index:1 /MountDir:C:\Mount
    ```
  - **Unmount WIM:**
    ```cmd
    DISM /Unmount-WIM /Mount