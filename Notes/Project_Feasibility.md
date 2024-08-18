# Feasibility Analysis of the AR-Powered "Desk Finder" Project for RBC

## Abstract

The "Desk Finder" project at RBC is designed to develop a mobile application that assists employees in navigating the office using Augmented Reality (AR) and Wi-Fi positioning. Despite its innovative concept, the project faces numerous challenges that make it difficult to complete with the current resources. These challenges include the complexity of AR development, particularly in environment mapping, user positioning, and training of computer vision models. Additionally, the limitations of Wi-Fi positioning in large office environments present further obstacles. This paper explores these challenges in detail, offering multiple techniques and solutions, providing specific metrics, models, and cost estimates to explain why the "Desk Finder" project is not feasible at this time.

## 1. Introduction

The "Desk Finder" project aims to leverage AR and Wi-Fi positioning to guide employees to their desks within RBC’s office spaces. This app proposes to offer a cutting-edge solution to improve office navigation, potentially saving time and increasing productivity. However, the development of such an application is highly complex, requiring significant expertise, time, and resources that are currently not available. This paper details the specific technical and logistical challenges, offering multiple techniques and solutions for each challenge, providing a comprehensive analysis of why the project might not succeed under the present constraints.

## 2. Technology Challenges

### 2.1 Augmented Reality (AR)

### 2.1.1 Environment Mapping: The Need for Precision

Environment mapping is a critical component of AR technology. It involves creating a detailed 3D model of the physical space in real-time. Several techniques are commonly used for this purpose, each with its own set of advantages and disadvantages. Below, we explore these techniques in detail.

#### **Simultaneous Localization and Mapping (SLAM):**

One of the most common techniques used for environment mapping is [Simultaneous Localization and Mapping (SLAM)](https://en.wikipedia.org/wiki/Simultaneous_localization_and_mapping). SLAM algorithms, such as [ORB-SLAM2](https://github.com/raulmur/ORB_SLAM2), are designed to both build a map of the environment and track the user's position within it simultaneously.

**Understanding SLAM:**

- **SLAM Overview**: SLAM is a complex process that combines data from sensors, such as cameras and inertial measurement units (IMUs), to construct a map of an unknown environment while simultaneously keeping track of the user's location within that environment. The SLAM process typically involves several steps: feature detection, feature matching, pose estimation, and map optimization.

- **ORB-SLAM2**: ORB-SLAM2 is a widely used open-source SLAM algorithm. It stands for Oriented FAST and Rotated BRIEF (ORB), which are the key components used for feature detection and description. ORB-SLAM2 is particularly known for its ability to perform well in real-time scenarios, making it suitable for AR applications on mobile devices.

  - **ORB (Oriented FAST and Rotated BRIEF)**: The ORB algorithm is used to detect keypoints (features) in the environment. The [FAST (Features from Accelerated Segment Test)](https://www.edwardrosten.com/work/rosten_2006_machine.pdf) algorithm is employed to quickly identify corners in the image, while BRIEF (Binary Robust Independent Elementary Features) creates a binary descriptor for these keypoints. The "oriented" part refers to the enhancement that makes ORB rotation-invariant, meaning it can recognize features even if the camera's orientation changes.

**Advantages:**

- **Real-time Performance**: SLAM is widely used due to its robustness in real-time applications. Algorithms like ORB-SLAM2 are effective in dynamic environments and provide accurate mapping and localization, which are critical for AR applications.
- **Flexibility**: SLAM algorithms are versatile and can adapt to various environments, from small indoor spaces to larger, more complex areas.

**Disadvantages:**

- **Computational Demands**: SLAM is computationally intensive and may not perform well on less powerful mobile devices. Optimizing the algorithm for performance on mobile devices requires significant effort.
- **Training Requirements**: SLAM requires a significant amount of training data and fine-tuning to ensure accuracy in diverse environments. For example, training a SLAM-based model on a large dataset of images representing various office environments can take weeks to months, depending on the dataset size and computing power. Training on 10,000 images could take 2-4 weeks on a high-end GPU, costing approximately $1,500-$3,000 in cloud computing resources.

#### **Structure from Motion (SfM):**

[Structure from Motion (SfM)](https://en.wikipedia.org/wiki/Structure_from_motion) is a photogrammetry technique that constructs 3D structures from 2D image sequences. Unlike SLAM, SfM is typically used for offline mapping and requires substantial post-processing.

**Understanding SfM:**

- **SfM Overview**: Structure from Motion is based on the principle that a sequence of 2D images captured from different viewpoints can be used to reconstruct a 3D model of the environment. The process involves identifying matching points across images, estimating camera motion, and building a 3D point cloud that represents the environment's structure.

- **Image Matching and Feature Detection**: Similar to SLAM, SfM relies on detecting and matching features across images. Algorithms like SIFT (Scale-Invariant Feature Transform) or SURF (Speeded Up Robust Features) are commonly used for this purpose. These features help in identifying corresponding points in different images, which are then used to infer depth and structure.

- **3D Reconstruction**: Once the camera's motion is estimated, the SfM algorithm triangulates the matched features to build a 3D point cloud. This point cloud can be further processed to create a detailed 3D mesh or model, which can be used for various applications, including AR.

**Advantages:**

- **High-Quality Models**: SfM can generate highly detailed 3D models from ordinary 2D images, making it a powerful tool for creating realistic virtual environments. It is particularly useful in situations where high-resolution models are required, and real-time performance is not a priority.

- **Flexibility**: SfM can work with any camera that can capture images, making it accessible for a wide range of applications. The technique is also adaptable to various scales, from small objects to large landscapes.

**Disadvantages:**

- **Not Real-Time**: SfM is not suitable for real-time applications due to the extensive computational resources and time required for post-processing. The process involves significant computation, especially during the image matching and 3D reconstruction phases, which can take hours or even days depending on the dataset size.

- **Static Environments**: SfM assumes that the environment is static during the image capture process. This assumption makes it less effective in dynamic environments where objects move, as it cannot accurately account for changes between images.

#### **Depth Mapping with LIDAR:**

[Light Detection and Ranging (LIDAR)](https://en.wikipedia.org/wiki/Lidar) is a remote sensing method that uses laser pulses to measure distances to objects. By capturing the time it takes for a laser to return to the sensor, LIDAR creates accurate depth maps of the environment.

**Understanding LIDAR:**

- **LIDAR Overview**: LIDAR systems emit laser pulses and measure the time it takes for each pulse to return after reflecting off an object. By calculating the distance based on the time of flight (ToF) of the laser, LIDAR creates a detailed 3D map of the surrounding environment. LIDAR is known for its high precision and ability to capture fine details, making it a popular choice in autonomous vehicles and high-end AR systems.

- **Data Processing**: The data collected by LIDAR is typically in the form of a point cloud, where each point represents a measurement with precise 3D coordinates. This point cloud can be processed to create a detailed map or mesh of the environment. LIDAR systems are often combined with other sensors, like cameras or IMUs, to enhance accuracy and provide additional contextual information.

- **Integration with AR**: In AR applications, LIDAR can be used to accurately map the environment and place virtual objects within it. This mapping capability allows for precise overlay of AR content, enhancing the realism and immersion of the AR experience.

**Advantages:**

- **High Accuracy**: LIDAR provides extremely accurate distance measurements, often within millimeters. This accuracy is crucial for applications that require precise environmental mapping, such as AR and autonomous navigation.

- **Performance in Various Conditions**: LIDAR performs well in different lighting conditions, including low light and darkness, where camera-based systems might struggle. This makes it a versatile tool for both indoor and outdoor applications.

**Disadvantages:**

- **Cost and Accessibility**: LIDAR sensors are expensive and are typically found in high-end devices. The cost of integrating LIDAR into consumer-grade AR applications is a significant barrier, limiting its widespread adoption.

- **Battery Consumption**: LIDAR systems can be power-hungry, leading to increased battery drain when used in mobile devices. This is a concern for applications that require prolonged use, such as mobile AR experiences.

#### **Point Cloud Mapping:**

[Point Cloud Mapping](https://en.wikipedia.org/wiki/Point_cloud) involves generating a collection of data points in space, each representing a 3D coordinate. These points are gathered using various sensors, including cameras, LIDAR, or depth sensors, and are used to create a 3D model of the environment.

**Understanding Point Cloud Mapping:**

- **Point Cloud Overview**: A point cloud is a large set of data points that represent the external surface of an object or environment. Each point in the cloud has its own set of X, Y, and Z coordinates, which collectively form a three-dimensional representation of the area being scanned. Point clouds can be generated by a variety of methods, including photogrammetry, laser scanning, and depth sensing.

- **Data Collection and Processing**: Point clouds are typically generated by scanning the environment with a sensor, such as a LIDAR or a depth camera. These sensors capture thousands or even millions of data points, which are then processed to create a 3D model. This processing can include noise reduction, point cloud registration (aligning multiple point clouds), and converting the point cloud into a mesh or solid model.

- **Applications in AR**: In AR, point clouds can be used to create detailed environmental maps that allow virtual objects to interact more naturally with the physical world. For example, a point cloud can help an AR system recognize surfaces, obstacles, and spatial relationships, enabling more accurate placement and movement of virtual objects.

**Advantages:**

- **Detail and Accuracy**: Point clouds can capture a high level of detail, making them ideal for applications that require precise modeling of complex environments. This level of detail is particularly useful in industries like construction, manufacturing, and heritage preservation, where accurate 3D models are essential.

- **Scalability**: Point cloud mapping is scalable and can be used for everything from small objects to large landscapes. The ability to combine multiple point clouds into a single, cohesive model also makes it a powerful tool for comprehensive environmental mapping.

**Disadvantages:**

- **High Computational Load**: Processing point clouds requires significant computational resources, especially when dealing with large datasets. The need for powerful processing capabilities can limit the use of point clouds in real-time applications, particularly on mobile devices.

- **Data Management**: Point clouds can generate vast amounts of data, leading to challenges in storage, transmission, and real-time processing. Managing this data efficiently is crucial for successful implementation in AR applications, and failure to do so can result in lag or reduced performance.

**Specific Challenges:**

- **Algorithm Complexity**: Implementing SLAM, SfM, LIDAR, or Point Cloud Mapping requires a deep understanding of feature extraction, keypoint matching, and 3D reconstruction. For instance, ORB-SLAM2 uses Oriented FAST and Rotated BRIEF (ORB) to detect and describe keypoints in real-time, which is computationally demanding.
- **Training and Testing**: Each of these techniques requires extensive training and testing to ensure accurate environment mapping. For example, LIDAR-based systems need to be tested in various lighting conditions and environments to ensure reliability. Similarly, Point Cloud Mapping requires high-resolution data, which can be difficult to collect and process in real-time.
- **Hardware Limitations**: Most smartphones lack the advanced hardware required to execute these techniques efficiently. Even with optimization, older or less powerful devices may struggle to maintain necessary frame rates, leading to poor user experiences, such as lag or misalignment of AR objects.

#### 2.1.2 User Positioning: The Challenge of Real-Time Accuracy

Accurate user positioning within the AR environment is crucial for delivering precise navigation instructions. This positioning is typically achieved through [Visual-Inertial Odometry (VIO)](https://scholar.google.com/scholar?q=visual+inertial+odometry), which combines visual data from the camera with inertial data from the accelerometer and gyroscope to estimate the user's position. Several techniques are available to enhance user positioning accuracy.

**Techniques for User Positioning:**

1. **Visual-Inertial Odometry (VIO):**

   [Visual-Inertial Odometry](https://scholar.google.com/scholar?q=visual+inertial+odometry) (VIO) is a common method used in AR applications to provide real-time positioning by fusing data from multiple sensors. VIO typically involves processing visual information from a camera alongside inertial measurements from an IMU, allowing for accurate tracking even in environments where GPS is unreliable.

   - **Advantages**: VIO provides real-time positioning by fusing data from multiple sensors, making it ideal for dynamic environments. It is commonly used in AR applications for tracking user movements accurately.
   - **Disadvantages**: VIO's accuracy depends on the quality of sensor data and the computational power available, which can vary significantly between devices.

2. **Marker-Based Tracking:**

   [Marker-Based Tracking](https://www.sciencedirect.com/science/article/abs/pii/S1077314203000858) uses physical markers, such as QR codes or fiducial markers, placed in the environment to help determine the user’s position. These markers are recognized by the camera, which uses their known location to estimate the user's position relative to the markers.

   - **Advantages**: This method offers high accuracy and low computational requirements since the positioning is based on predefined markers rather than complex algorithms. It is particularly effective in controlled environments where markers can be strategically placed.
   - **Disadvantages**: The need for physical markers is a limitation, as it requires prior setup and is not flexible if the environment changes frequently. The visibility of markers can also be an issue in cluttered or busy spaces.

3. **GPS with Augmented Assistance:**

   [Augmented GPS](https://en.wikipedia.org/wiki/Assisted_GPS) is a method that combines traditional GPS data with additional sensors or external systems, such as Wi-Fi or Bluetooth, to improve positioning accuracy. Although GPS is typically unreliable indoors, combining it with other data sources can enhance its performance.

   - **Advantages**: GPS is widely available and can provide a baseline for positioning, particularly in larger spaces where other techniques may struggle. When augmented with additional data, GPS can offer improved accuracy and coverage.
   - **Disadvantages**: GPS's inherent limitations indoors, especially in complex environments like multi-story office buildings, make it less reliable for precise indoor navigation. The dependency on external augmentation also adds to the complexity of the system.

**Specific Challenges:**

- **Model Training and Selection**: Developing a reliable VIO system involves training a deep learning model, such as a Convolutional Neural Network (CNN), to process visual data and predict the user's position. A commonly used model is [MobileNetV2](https://arxiv.org/abs/1801.04381), chosen for its efficiency on mobile devices.
  - **Training Time**: Fine-tuning a model like MobileNetV2 could take several weeks, depending on the dataset's size and diversity. Using a cloud-based GPU instance, this might cost around $2,000-$4,000, not including the time spent on data collection and preprocessing.
  - **Accuracy Metrics**: The system needs to maintain an accuracy of at least 0.5 meters to ensure the navigation arrows are correctly aligned with physical spaces. Extensive testing and validation are required to achieve this accuracy, which could add several weeks to the project timeline.
- **Computational Demand**: Real-time positioning requires the model to process data at high speeds, which can be taxing on mobile devices. Optimizing the app to run efficiently on both Android and iOS platforms adds another layer of complexity, as these platforms have different performance characteristics and limitations.

#### 2.1.3 Path Overlay and Navigation: Complexity in Real-Time Updates

Displaying navigation paths in real-time within an AR environment involves overlaying digital arrows or indicators on the user's camera feed. This requires accurate positioning and the ability to update the path dynamically as the user moves. Various techniques are available to achieve this, each with its own set of trade-offs.

**Techniques for Path Overlay:**

1. **A* Pathfinding Algorithm:**

   [A* Algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm) is a widely used pathfinding algorithm that finds the shortest path between two points on a grid. It works by exploring the most promising paths first, using a cost function that estimates the total path length.

   - **Advantages**: A* is efficient and effective in grid-based systems, making it suitable for indoor navigation where the environment can be represented as a grid. It handles dynamic changes in the environment by recalculating the path as needed.
   - **Disadvantages**: The algorithm may require significant optimization to work in real-time on mobile devices, especially in complex 3D environments where multiple paths and obstacles must be considered simultaneously.

2. **Dijkstra’s Algorithm:**

   [Dijkstra's Algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm) is another popular algorithm for finding the shortest path in a graph. Unlike A*, Dijkstra’s algorithm explores all possible paths to find the optimal solution, which can be useful in environments where path costs are not uniform.

   - **Advantages**: Dijkstra's algorithm is reliable for calculating the shortest path between nodes in a graph, making it suitable for indoor navigation in static environments.
   - **Disadvantages**: It is less efficient than A* in large, complex environments, as it does not prioritize certain paths over others, potentially leading to slower performance.

3. **Dynamic Navigation with Machine Learning:**

   [Machine Learning-Based Navigation](https://www.sciencedirect.com/science/article/abs/pii/S0167739X19305850) uses machine learning models to predict and update the best path in real-time, accounting for dynamic changes in the environment. These models can learn from past navigation attempts, improving over time.

   - **Advantages**: Adaptive and can improve with more data, potentially leading to more efficient and context-aware navigation. It can handle complex environments better than traditional algorithms by learning patterns in user movement and environmental changes.
   - **Disadvantages**: Requires significant training and computational resources, which may not be feasible for real-time mobile applications. The need for continuous learning and updates adds complexity to the system.

**Specific Challenges:**

- **Algorithm Development**: Developing and integrating these algorithms with real-time AR updates is challenging, especially when accounting for dynamic environmental changes and obstacle avoidance. Each approach requires careful consideration of the environment's complexity, the available computational resources, and the need for real-time responsiveness.
- **Latency Issues**: Ensuring that the path overlay updates in real-time without noticeable lag is critical for user experience. Latency above 100 milliseconds can degrade the experience, causing confusion or even motion sickness. To achieve low latency, the app needs to process sensor data, update the position, and render the AR overlay within this narrow time window. Extensive optimization and testing are needed to achieve this, adding further to development time.

### 2.2 Wi-Fi Positioning

#### 2.2.1 Signal Strength Analysis: Understanding the Limitations

Wi-Fi positioning is a method that estimates a user's location based on the signal strength from multiple Wi-Fi access points. This method's accuracy depends heavily on the density of access points and environmental conditions. Several techniques are available to improve the accuracy of Wi-Fi positioning.

**Techniques for Wi-Fi Positioning:**

1. **RSSI (Received Signal Strength Indicator) Triangulation:**

   [RSSI Triangulation](https://www.sciencedirect.com/science/article/pii/S1319157815000972) is one of the simplest and most commonly used methods for Wi-Fi positioning. It involves measuring the signal strength from multiple access points and using this information to triangulate the user's position.

   - **Advantages**: RSSI triangulation is easy to implement and requires minimal infrastructure changes, making it a cost-effective option for basic indoor positioning.
   - **Disadvantages**: The accuracy of RSSI triangulation is limited, typically ranging from 2 to 5 meters. This is often insufficient for precise indoor navigation, especially in environments with significant signal interference or physical obstructions.

2. **Fingerprinting:**

   [Fingerprinting](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6498420/) is a more advanced technique that involves creating a database of signal strength readings at various known locations within the environment. When the system measures the signal strength at an unknown location, it compares this measurement to the database to estimate the user's position.

   - **Advantages**: Fingerprinting can provide higher accuracy than RSSI triangulation, especially in environments with consistent Wi-Fi coverage. It is particularly effective in large, complex environments where signal strengths vary significantly.
   - **Disadvantages**: The primary drawback of fingerprinting is the need for extensive data collection and regular updates to the database to maintain accuracy. Changes in the environment, such as moving furniture or adding new access points, require the database to be recalibrated.

3. **Time of Flight (ToF):**

   [Time of Flight (ToF)](https://en.wikipedia.org/wiki/Time_of_flight) is a technique that measures the time it takes for a Wi-Fi signal to travel from the access point to the device and back. By measuring this time delay, the system can calculate the distance between the device and the access point, leading to more accurate positioning.

   - **Advantages**: ToF offers potentially higher accuracy than RSSI by directly measuring distance rather than relying on signal strength, which can be affected by environmental factors.
   - **Disadvantages**: ToF requires precise synchronization between access points and the device, which can be difficult to achieve in practice. The complexity and cost of implementing ToF in a large office environment may outweigh its benefits.

**Specific Challenges:**

- **Accuracy Limitations**: Wi-Fi positioning typically offers accuracy within 2 to 5 meters, which may not be sufficient for precise navigation within an office. A deviation of even 3 meters could lead to the user being directed to the wrong desk or floor, significantly undermining the app's effectiveness.
  - **Metrics**: Research shows that increasing the density of Wi-Fi access points can improve accuracy slightly but at significant cost. For instance, upgrading the infrastructure to add more access points could improve accuracy by 10-20%, but the cost could exceed $20,000.
  - **Cost Considerations**: Enhancing Wi-Fi infrastructure to improve positioning accuracy is expensive and may not be justified by the marginal gains in performance. The overall cost of upgrading could be prohibitive, especially when weighed against the benefits.

#### 2.2.2 Development of Positioning Algorithms

To enhance Wi-Fi positioning accuracy, advanced algorithms such as fingerprinting or machine learning-based methods are often employed. These techniques require significant upfront data collection and ongoing maintenance.

**Techniques for Enhancing Positioning Algorithms:**

1. **k-Nearest Neighbors (k-NN):**

   [k-Nearest Neighbors (k-NN)](https://scikit-learn.org/stable/modules/neighbors.html) is a simple yet effective algorithm for positioning based on fingerprinting data. It works by finding the 'k' closest signal strength measurements in the database and averaging their locations to estimate the user's position.

   - **Advantages**: k-NN is easy to implement and can provide good accuracy in smaller environments with well-defined signal patterns.
   - **Disadvantages**: The algorithm becomes computationally expensive as the dataset grows, leading to slower performance and reduced real-time applicability.

2. **Random Forest:**

   [Random Forest](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestClassifier.html) is a machine learning technique that uses multiple decision trees to make predictions. For Wi-Fi positioning, Random Forest can be trained on signal strength data to predict the user's location.

   - **Advantages**: Random Forest provides higher accuracy by considering multiple decision trees and their outcomes for predicting the user's location. It is particularly effective in complex environments with variable signal strengths.
   - **Disadvantages**: Requires substantial computational resources and may be challenging to implement on mobile devices, especially in real-time applications.

3. **Neural Networks:**

   [Neural Networks](https://www.sciencedirect.com/science/article/abs/pii/S0031320319303654) can be trained to recognize patterns in Wi-Fi signal strength data, leading to more accurate positioning predictions. These models can handle complex, non-linear relationships between signal strength and location, making them suitable for environments with inconsistent or fluctuating signals.

   - **Advantages**: Neural networks can achieve high accuracy in complex environments by learning from large datasets and adapting to changes over time.
   - **Disadvantages**: Training neural networks requires large amounts of data and significant computational power, making them less suitable for real-time mobile applications. The need for continuous updates and retraining adds to the system's complexity and cost.

**Specific Challenges:**

- **Data Collection**: Fingerprinting requires collecting signal strength data across the entire office space, a process that could take several weeks for a 10,000 square meter office. Regular updates are necessary to maintain accuracy, adding to the project's time and cost.
- **Algorithm Training**: Machine learning models like k-NN or Random Forest can be trained on this data, but the process is resource-intensive. Training on a dataset of 100,000 samples could take days to weeks, with costs ranging from $500 to $2,000 on cloud platforms like AWS or Google Cloud.
- **Maintenance**: Wi-Fi environments are dynamic, with signal strengths fluctuating due to environmental changes. Maintaining the fingerprint map and algorithms to ensure consistent accuracy could cost an additional $5,000 annually, including personnel time and infrastructure updates.

#### 2.2.3 Real-World Testing and Validation

After developing and training the positioning system, extensive testing is required to validate its accuracy and reliability in a real-world office setting. This involves deploying the system across various office locations, monitoring its performance, and making necessary adjustments.

**Specific Challenges:**

- **Testing Time and Costs**: Comprehensive testing in a large office space could take several months, especially if the system needs frequent recalibration. Testing personnel costs could add another $10,000 to the project budget, assuming a team of two testers working part-time.
- **Environmental Variability**: Different office layouts, obstacles, and sources of signal interference introduce variability that the system must handle. Developing a robust solution that performs consistently across these variables is complex and time-consuming, further straining the project timeline.

## 3. Time Constraints

### 3.1 Project Timeline Analysis

Given the complex nature of AR and Wi-Fi positioning technologies, the timeline for the "Desk Finder" project is highly constrained. With only two interns working 20 hours per week, the total available time is approximately 320 hours over four months. This is insufficient to cover the extensive research, development, testing, and deployment phases required for the project.

**3.1.1 Research and Development Time**

The research and development phase for AR and Wi-Fi positioning would likely take up the majority of the available time. Understanding and implementing SLAM, VIO systems, and advanced Wi-Fi positioning algorithms could easily consume over half of the project's total hours. This leaves little time for the actual development and integration of the app's features.

**3.1.2 Prototyping and Testing**

Prototyping and testing are essential to ensure the app functions correctly. These phases involve creating early versions of the app, testing them in real-world environments, collecting feedback, and making improvements. Given the limited available time, completing this iterative process effectively is highly unlikely, leading to a final product that is untested and potentially unreliable.

## 4. Skill Gaps

### 4.1 The Challenge of Learning AR

Developing an AR app requires specialized skills in 3D modeling, spatial computing, and real-time rendering. The interns working on this project do not have experience in these areas, and acquiring these skills would take significant time and effort, potentially exceeding the project timeline.

### 4.2 Inexperience with Cross-Platform Development

Building an app that works on both iOS and Android is challenging, especially when using a framework like [Flutter](https://flutter.dev/). While Flutter simplifies cross-platform development, it still requires knowledge of platform-specific optimizations and integrations, particularly for complex features like AR. The team’s limited experience in mobile app development is likely to result in performance and user experience issues.

### 4.3 Complexities of Backend Development

The backend of the "Desk Finder" app needs to handle user data, location information, and real-time updates. This requires setting up a secure and scalable server, designing databases, and ensuring smooth data flow between the app and the server. These tasks are complex and require advanced knowledge of backend development. The interns’ lack of experience in this area increases the likelihood of building a fragile backend that may not withstand the demands of a production environment.

## 5. Lack of Guidance and Resources

### 5.1 Insufficient Documentation and Tutorials

AR and Wi-Fi positioning are emerging technologies with limited comprehensive, beginner-friendly documentation. The interns may struggle to find the necessary resources to learn and apply these technologies effectively. Without proper guidance, they might make critical mistakes, leading to significant delays or project failure.

### 5.2 Limited Access to Necessary Hardware and Software

Developing and testing the "Desk Finder" app requires access to modern smartphones, advanced Wi-Fi infrastructure, and possibly specialized software for calibration and testing. Limited access to these resources could hinder the development process and result in a product that doesn’t function as expected in real-world scenarios.

## 6. Conclusion

The "Desk Finder" project is an ambitious and innovative idea, but it faces numerous challenges that make it difficult to complete successfully within the current constraints. The technical difficulties of integrating AR and Wi-Fi positioning, combined with the limited time, expertise, and resources available, create a situation where the project is unlikely to succeed. It is recommended that RBC consider alternative approaches that are more achievable given the current constraints, such as smaller-scale projects or investing in training for the team to build the necessary skills for future projects.

## 7. References

- [ORB-SLAM2](https://github.com/raulmur/ORB_SLAM2)
- [ORB (Oriented FAST and Rotated BRIEF)](https://www.edwardrosten.com/work/rosten_2006_machine.pdf)
- [Visual-Inertial Odometry](https://scholar.google.com/scholar?q=visual+inertial+odometry)
- [MobileNetV2](https://arxiv.org/abs/1801.04381)
- [A* Search Algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm)
- [Dijkstra's Algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm)
- [Wi-Fi-based Positioning Systems](https://ieeexplore.ieee.org/document/7942122)
- [Fingerprinting](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6498420/)
- [k-Nearest Neighbors (k-NN)](https://scikit-learn.org/stable/modules/neighbors.html)
- [Random Forest](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestClassifier.html)
- [Flutter](https://flutter.dev/)
