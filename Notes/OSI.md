# OSI Model Explained

The OSI (Open Systems Interconnection) model is a conceptual framework used to understand network interactions in seven distinct layers. Each layer has specific functions and communicates with the layers directly above and below it.

## OSI Model Layers Table

| **Layer**      | **Purpose**                                                       | **Use Case (Bank IT)**                           | **Network Correlation**                         |
|----------------|-------------------------------------------------------------------|--------------------------------------------------|-------------------------------------------------|
| **Layer 7: Application** | Interface for end-user applications. | Deploying and managing banking applications like financial software and email systems. | HTTP, FTP, SMTP. |
| **Layer 6: Presentation** | Translates data formats and encrypts/decrypts. | Encrypting data during application installations and ensuring compatibility. | SSL/TLS, JPEG, ASCII. |
| **Layer 5: Session** | Manages sessions between applications. | Maintaining secure connections for remote administration tools. | NetBIOS, RPC. |
| **Layer 4: Transport** | Ensures complete data transfer with error handling. | Ensuring reliable data transfer for automated scripts and application updates. | TCP, UDP. |
| **Layer 3: Network** | Routes data packets between devices. | Managing IP addresses and subnets for different departments within the bank. | IP, ICMP. |
| **Layer 2: Data Link** | Frames data and manages error detection/correction. | Configuring VLANs and ensuring error-free data transfer on the bank's LAN. | Ethernet, MAC addresses. |
| **Layer 1: Physical** | Transmits raw data bits over physical medium. | Setting up and maintaining physical network infrastructure such as cables and switches. | Cables, switches, wireless signals. |

## Correlating OSI Model to Network in a Bank IT Environment

- **Application Layer (Layer 7):** In your role, you might install and configure applications like banking software, financial tools, and email systems, ensuring they are properly deployed and accessible to users.

- **Presentation Layer (Layer 6):** During application installations, you ensure that data is properly encrypted (using SSL/TLS) and formatted, so that applications run securely and without compatibility issues.

- **Session Layer (Layer 5):** You use remote administration tools to manage systems across the bank. This layer ensures that your remote sessions remain active and secure while you perform administrative tasks.

- **Transport Layer (Layer 4):** When running automated scripts or deploying application updates, this layer ensures that data is transmitted reliably and without errors, using protocols like TCP.

- **Network Layer (Layer 3):** You manage IP addressing and subnets for different bank departments, ensuring that data packets are routed correctly within the bank's network infrastructure.

- **Data Link Layer (Layer 2):** Configuring VLANs to segment network traffic and ensuring error detection/correction within the bank's LAN. This ensures efficient and secure data transfer between devices.

- **Physical Layer (Layer 1):** You are responsible for setting up and maintaining the physical network infrastructure, including cables, switches, and other hardware that facilitate data transmission.

By understanding each layer of the OSI model and its specific functions, you can effectively manage the bank's IT infrastructure, ensuring secure, reliable, and efficient operations across all systems and applications.
