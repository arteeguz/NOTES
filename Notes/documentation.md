# Desk Finder Project Documentation

## Project Overview

The Desk Finder project aims to develop a cross-platform mobile application for RBC's office that allows users to input any desk number and receive directions to that desk. The app will leverage advanced technologies such as AR, Wi-Fi positioning, and possibly BLE beacons to achieve accurate navigation within the office space.

## Technology Options

### 1. AR (Augmented Reality) Navigation

**Description:**
Augmented Reality (AR) overlays digital content onto the real world through the device's camera. In this project, AR will be used to guide users to their desired desks by displaying navigation arrows and directions on their phone screens in real-time. ARKit (iOS) and ARCore (Android) are popular platforms for implementing AR in mobile applications.

- **How it Works:**
  - **Environment Mapping:** AR technology uses the phone's camera to scan and understand the environment.
  - **User Positioning:** By analyzing visual markers and utilizing the phone's motion sensors, AR can determine the user's position and orientation.
  - **Path Overlay:** The app calculates the shortest path to the desired desk and overlays directional arrows and instructions on the camera feed.

- **How to Develop:**
  - **Setup:** Integrate ARKit (for iOS) and ARCore (for Android) into the Flutter project.
    - [ARKit Tutorial for iOS](https://developer.apple.com/documentation/arkit/quick_start)
    - [ARCore Tutorial for Android](https://developers.google.com/ar/develop)
  - **Environment Mapping:** Use the camera to build a 3D map of the office environment.
  - **Navigation Logic:** Develop algorithms to calculate the shortest path from the user's current position to the desired desk.
  - **Overlay Directions:** Use AR to display navigation arrows and instructions on the user's screen.
  - **Testing:** Test on various devices to ensure compatibility and performance.

- **References:**
  - [ARKit Overview](https://developer.apple.com/arkit/)
  - [ARCore Overview](https://developers.google.com/ar)

- **Pros:**
  - High accuracy and user engagement.
  - Visual and intuitive navigation.
  - Enhances user experience with immersive technology.

- **Cons:**
  - Requires modern smartphones with AR support.
  - Can be complex to develop and test.
  - Potential performance issues on older devices.

### 2. Wi-Fi Positioning

**Description:**
Wi-Fi positioning uses the signal strength from multiple Wi-Fi access points to triangulate the user's position. This method is particularly useful in large indoor environments like office buildings.

- **How it Works:**
  - **Signal Strength Analysis:** The app measures the signal strength from nearby Wi-Fi access points.
  - **Triangulation:** Using the known positions of these access points, the app calculates the user's approximate location.
  - **Path Calculation:** The app then calculates the shortest path to the desired desk and provides turn-by-turn directions.

- **How to Develop:**
  - **Setup:** Integrate Wi-Fi positioning libraries into the Flutter project.
  - **Signal Strength Analysis:** Develop algorithms to measure and analyze signal strength from nearby Wi-Fi access points.
  - **Triangulation:** Use triangulation techniques to estimate the user's location within the office.
  - **Navigation Logic:** Calculate the shortest path to the desired desk and provide turn-by-turn directions.
  - **Testing:** Test in different parts of the office to ensure accuracy and performance.

- **References:**
  - [Wi-Fi Positioning Overview](https://en.wikipedia.org/wiki/Wi-Fi_positioning_system)
  - [Indoor Positioning with Wi-Fi](https://www.intechopen.com/chapters/62816)
  - [Wi-Fi Positioning Tutorial](https://www.aircable.net/indoor-positioning-system.html)

- **Pros:**
  - Utilizes existing Wi-Fi infrastructure.
  - Suitable for large indoor spaces.
  - Lower cost compared to BLE beacons.

- **Cons:**
  - May have lower accuracy compared to AR.
  - Dependent on the density and placement of Wi-Fi access points.
  - Interference from other electronic devices can affect accuracy.

### 3. BLE Beacons

**Description:**
BLE (Bluetooth Low Energy) beacons are small devices that broadcast signals to nearby smartphones. By deploying these beacons throughout the office, the app can triangulate the user's position.

- **How it Works:**
  - **Beacon Deployment:** Install BLE beacons at strategic locations throughout the office.
  - **Signal Detection:** The app detects signals from nearby beacons.
  - **Triangulation:** By analyzing the signal strength from multiple beacons, the app determines the user's location.
  - **Path Calculation:** The app calculates the shortest path to the desired desk and provides directions.

- **How to Develop:**
  - **Setup:** Deploy BLE beacons in strategic locations within the office.
  - **Signal Detection:** Integrate BLE libraries into the Flutter project to detect beacon signals.
  - **Triangulation:** Develop algorithms to triangulate the user's position based on signal strength from multiple beacons.
  - **Navigation Logic:** Calculate the shortest path to the desired desk and provide directions.
  - **Testing:** Test in different parts of the office to ensure accuracy and signal consistency.

- **References:**
  - [BLE Beacon Overview](https://en.wikipedia.org/wiki/IBeacon)
  - [How BLE Beacons Work](https://www.bluetooth.com/learn-about-bluetooth/bluetooth-technology/bluetooth-low-energy/)
  - [BLE Beacons Tutorial](https://www.novelbits.io/bluetooth-beacons/)

- **Pros:**
  - High accuracy.
  - Works well in complex indoor environments.
  - Can provide additional contextual information (e.g., proximity marketing).

- **Cons:**
  - High cost for hardware and installation.
  - Maintenance of beacons.
  - Battery life of beacons needs monitoring and management.

## Cost, Time to Develop, and Cost Savings

### Cost and Time to Develop

- **Cost:**
  - **Development:** Estimated at $42 per hour for 300-600 hours = $12,600 - $25,200.
  - **Testing:** Estimated at $42 per hour for 100-150 hours = $4,200 - $6,300.
  - **Maintenance:** Approximately $1,000 - $2,000 annually for updates and bug fixes.

- **Time:**
  - **Research and Prototyping:** 2-4 weeks.
  - **Development:** 6-12 weeks.
  - **Testing and Debugging:** 3-6 weeks.
  - **Total:** 2.5-4 months.

### Cost Savings

- Improved office navigation can save approximately 10 minutes per employee per day.
- For 250 employees, this equates to roughly 41.67 hours saved per day.
- At an average wage of $42 per hour, this is a savings of $1,750 per day.
- Annual savings (250 working days) = $437,500.

## Technology Stack

### Front-End (Mobile App)

- **Cross-Platform Development Framework:** Flutter
  - **Justification:** Flutter allows for the development of high-performance, visually appealing apps for both iOS and Android from a single codebase, reducing development time and costs.
  - [Flutter Documentation](https://flutter.dev/docs)

- **IDEs:**
  - **Android:** Android Studio
  - **iOS:** Xcode
  - **General:** Visual Studio Code
    - **Justification:** VSCode is a lightweight, versatile IDE that supports Flutter development and integrates well with other tools and plugins.
    - [Visual Studio Code Documentation](https://code.visualstudio.com/docs)

- **AR and Positioning Plugins:**
  - **AR:** ARCore (Android), ARKit (iOS)
    - [ARCore Overview](https://developers.google.com/ar)
    - [ARKit Overview](https://developer.apple.com/arkit/)
    - **Justification:** These plugins provide robust AR functionalities essential for overlaying navigation paths on the real world.
  - **Wi-Fi:** Native Wi-Fi APIs in Android/iOS SDKs
    - [Wi-Fi Positioning](https://en.wikipedia.org/wiki/Wi-Fi_positioning_system)
    - **Justification:** Utilizes existing Wi-Fi infrastructure for cost-effective indoor positioning.
  - **BLE:** CoreBluetooth (iOS), Android Bluetooth API
    - [BLE Overview](https://www.bluetooth.com/learn-about-bluetooth/bluetooth-technology/bluetooth-low-energy/)
    - **Justification:** BLE beacons provide precise indoor positioning, essential for accurate navigation.

### Back-End

- **Server-Side Development Platform:** Node.js with Express
  - [Node.js Overview](https://nodejs.org/en/)
  - [Express Overview](https://expressjs.com/)
  - **Justification:** Node.js with Express is a powerful, scalable platform suitable for developing RESTful APIs and handling concurrent connections efficiently.

- **Database:** PostgreSQL
  - [PostgreSQL Overview](https://www.postgresql.org/)
  - **Justification:** PostgreSQL is a robust, open-source relational database that ensures data integrity and supports complex queries.

- **Real-Time Communication:** WebSockets
  - [WebSockets Overview](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API)
  - **Justification:** WebSockets provide real-time, bidirectional communication between the client and server, essential for live navigation updates.

- **Web Server:** Nginx
  - [Nginx Overview](https://www.nginx.com/)
  - **Justification:** Nginx is a high-performance web server that can handle a large number of concurrent connections, ensuring fast and reliable access to the back-end services.

- **Containerization:** Docker
  - [Docker Overview](https://www.docker.com/)
  - **Justification:** Docker ensures consistent deployment environments, simplifies application distribution, and enhances scalability.

### Additional Tools

- **API Testing:** Postman
  - [Postman Overview](https://www.postman.com/)
  - **Justification:** Postman is a powerful tool for developing, testing, and documenting APIs.

- **Version Control:** Git, GitHub
  - [Git Overview](https://git-scm.com/)
  - [GitHub Overview](https://github.com/)
  - **Justification:** GitHub provides a platform for version control and collaboration, essential for managing the project codebase.

- **Deployment:** AWS, Google Cloud Platform (GCP), Microsoft Azure
  - [AWS Overview](https://aws.amazon.com/)
  - [GCP Overview](https://cloud.google.com/)
  - [Azure Overview](https://azure.microsoft.com/)
  - **Justification:** These cloud platforms offer scalable infrastructure, robust security, and various services to support the back-end deployment.

- **RBC VM/Server:**
  - **Justification:** Use RBC's virtual machine (VM) or server infrastructure to ensure data security and compliance with internal policies.
  - **Recommendation:** Request a Linux-based VM with Docker support for easy deployment and scalability.

## Development Steps and Roadmap

### Phase 1: Project Setup

#### July 1 - July 7
- **Tasks:**
  - Initialize project repositories.
  - Set up version control (GitHub).
  - Gather detailed requirements.
  - Set up project management tools (Jira, Trello).
  - Plan project timeline and milestones.

### Phase 2: Research and Planning

#### July 8 - July 14
- **Tasks:**
  - Conduct research on AR, Wi-Fi positioning, and BLE beacon technologies.
  - Select the best technology for the project.
  - Create a detailed project plan and timeline.
  - Define technical requirements and specifications.
  - Plan database schema and backend architecture.

### Phase 3: Front-End Setup and Initial Development

#### July 15 - July 28
- **Tasks:**
  - Set up the Flutter environment and initial project structure.
  - Install necessary plugins (ARCore, ARKit).
  - Set up IDE (Visual Studio Code) with Flutter and Dart.
  - Develop initial UI screens for login, home, search, map, and settings.
  - Implement basic navigation logic.

### Phase 4: Back-End Setup and Initial Development

#### July 29 - August 11
- **Tasks:**
  - Set up the Node.js environment with Express.
  - Initialize project structure.
  - Design and implement the database schema using PostgreSQL.
  - Develop RESTful APIs for user authentication, desk information, and navigation.
  - Implement WebSocket for real-time updates.

### Phase 5: Database Configuration

#### August 12 - August 18
- **Tasks:**
  - Set up PostgreSQL database on a virtual machine (request VM from IT department).
  - Configure database schemas and tables for users, desks, and map data.
  - Implement database backup and recovery plans.

### Phase 6: Front-End Navigation and AR Integration

#### August 19 - September 8
- **Tasks:**
  - Implement user positioning logic using Wi-Fi/BLE.
  - Develop route calculation algorithms.
  - Integrate ARCore (Android) and ARKit (iOS) for AR-based navigation.
  - Develop AR overlays for navigation.
  - Test and debug navigation features.

### Phase 7: Wi-Fi/BLE Positioning Implementation

#### September 9 - September 22
- **Tasks:**
  - Implement Wi-Fi positioning using native Wi-Fi APIs.
  - Implement BLE positioning using CoreBluetooth and Android Bluetooth API.
  - Test and calibrate positioning accuracy.
  - Integrate positioning data with UI.

### Phase 8: Back-End API Implementation

#### September 23 - October 6
- **Tasks:**
  - Develop back-end APIs based on the designs.
  - Implement user authentication, desk information, and navigation endpoints.
  - Ensure secure and efficient data flow between front-end and back-end.

### Phase 9: Front-End to Back-End Integration

#### October 7 - October 20
- **Tasks:**
  - Integrate front-end with back-end APIs.
  - Ensure seamless data flow between front-end and back-end.
  - Test and debug integrated features.

### Phase 10: Testing and Debugging

#### October 21 - November 10
- **Tasks:**
  - Conduct thorough testing of the app on both Android and iOS devices.
  - Use physical devices for AR testing.
  - Use Postman to test API endpoints.
  - Write unit tests for API endpoints.
  - Fix any bugs and issues.

### Phase 11: Deployment

#### November 11 - November 17
- **Tasks:**
  - Deploy back-end server on a cloud provider or company VM.
  - Configure server environment (Linux).
  - Distribute the mobile app through Google Play Store and Apple App Store.
  - Monitor app performance and address any deployment issues.

### Phase 12: Final Review and Adjustments

#### November 18 - November 24
- **Tasks:**
  - Perform a final review of the app.
  - Make any necessary adjustments.
  - Prepare project documentation.
  - Conduct a final presentation to the manager.

### Phase 13: Project Documentation

#### Ongoing from July 1
- **Tasks:**
  - Document the entire project, including the codebase, design decisions, and user guides.
  - Update documentation regularly as the project progresses.

## Detailed Development Steps

### 1. Project Setup
- **Initialize Front-End Project:** Set up a new project using Flutter.
- **Initialize Back-End Project:** Set up a new server-side project with Node.js and Express.
- **Version Control:** Set up Git repositories for version control.

### 2. Database Design
- **User Table:** Store user information (user ID, name, email, etc.).
- **Desk Table:** Store desk information (desk ID, floor number, location coordinates, etc.).
- **Map Data:** Store floor map data and AR markers.

### 3. API Design
- **User Authentication:**
  - **Sign Up:** POST /api/auth/signup
  - **Login:** POST /api/auth/login
- **Desk Information:**
  - **Get Desk Info:** GET /api/desk/:deskId
  - **Get All Desks on Floor:** GET /api/desks/:floorNumber
- **Navigation:**
  - **Get Navigation Path:** POST /api/navigation/path (takes current location and destination desk ID)

### 4. Mobile App Design
- **UI Design:**
  - **Login/Sign Up Screen:** Allow users to log in or sign up.
  - **Home Screen:** Show the office layout with search functionality.
  - **Search Screen:** Allow users to search for specific desks.
  - **Map Screen:** Display the floor map and AR navigation.
  - **Settings Screen:** Allow users to configure preferences.
- **Navigation Logic:**
  - **Determine User Position:** Use Wi-Fi positioning or BLE beacons to determine the user's current location.
  - **Calculate Route:** Use the back-end API to get the shortest path to the destination desk.
  - **AR Navigation:** Use ARCore or ARKit to provide step-by-step navigation.
- **State Management:** Use a state management solution provided by the chosen framework (e.g., Provider for Flutter).

### 5. Implementation Steps

**Front-End:**
- **Setup Project:** Create a new project using Flutter.
- **Install Necessary Plugins:** Install plugins for AR, BLE, Wi-Fi, and maps.
- **Create UI Screens and Navigation Logic:** Develop the user interface and implement navigation logic.
- **Integrate AR Navigation:** Integrate ARCore and ARKit for AR-based navigation.
- **Implement Wi-Fi and BLE Positioning:** Implement positioning using Wi-Fi and BLE.

**Back-End:**
- **Setup Project:** Create a new project using Node.js.
- **Install Necessary Frameworks and Libraries:** Install Express for Node.js.
- **Create RESTful APIs:** Develop APIs for authentication, desk information, and navigation.
- **Connect to Database:** Set up schemas and models for user and desk data.
- **Implement Real-Time Communication:** Use WebSockets for real-time updates.
- **Deploy the Back-End Server:** Deploy the server to a cloud provider.

### 6. Testing and Deployment

**Front-End Testing:**
- **Test on Android and iOS:** Use simulators/emulators and physical devices for AR testing.

**Back-End Testing:**
- **Use Postman:** Test API endpoints.
- **Write Unit Tests:** Ensure robust API functionality.

**Deployment:**
- **Deploy Back-End Server:** Use AWS, GCP, or Azure.
- **Distribute Mobile App:** Publish through Google Play Store and Apple App Store.

## Concerns and Considerations

- **AR Compatibility:** Ensure that all targeted devices support ARCore or ARKit.
- **Wi-Fi Coverage:** Verify that Wi-Fi access points are adequately distributed for positioning.
- **Cost Management:** Balance the need for BLE beacons with their cost and installation time.
- **Security:** Ensure secure user authentication and data handling.

## MVP and Deliverables

- **MVP:** Functional mobile app with basic desk search and navigation features.
- **Deliverables:**
  - Mobile app for Android and iOS
  - Backend server with RESTful APIs
  - Database setup
  - Documentation

## Launch Plan

- **Server:** Deploy on a cloud platform (AWS, GCP, Azure) or company VM.
- **Database:** Use PostgreSQL hosted on the chosen cloud platform.
- **Mobile App Distribution:** Publish on Google Play Store and Apple App Store.

## Conclusion

The Desk Finder project aims to streamline office navigation using cutting-edge technologies like AR and Wi-Fi positioning. This detailed documentation provides a comprehensive guide for development, ensuring a clear path from project setup to final deployment.
