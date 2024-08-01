graph LR
    A[Start] --> B[Open App]
    B --> C{User Authenticated?}
    C -->|No| D[Login/Sign Up Screen]
    D --> D1[Enter Email]
    D1 --> D2[Enter Password]
    D2 --> D3{New User?}
    D3 -->|Yes| D4[Enter Name]
    D4 --> D5[Confirm Password]
    D3 -->|No| E[Authenticate]
    D5 --> E
    E --> F{Valid Credentials?}
    F -->|No| D
    F -->|Yes| G[Home Screen]
    C -->|Yes| G
    G --> H{User Action}
    H --> I[Search for Desk]
    H --> J[View Office Layout]
    H --> K[Access Settings]
    H --> W[View Bookings]
    I --> L[Enter Desk Number]
    L --> M[View Desk Information]
    M --> M1[Check Availability]
    M1 --> M2{Desk Available?}
    M2 -->|Yes| M3[Book Desk]
    M2 -->|No| M4[Suggest Alternatives]
    M3 --> N{Navigate to Desk?}
    M4 --> I
    N -->|Yes| O[Start AR Navigation]
    N -->|No| G
    J --> P[Browse Floor Map]
    P --> P1[Zoom/Pan]
    P1 --> P2[Filter by Amenities]
    P2 --> Q{Select Desk?}
    Q -->|Yes| M
    Q -->|No| G
    K --> R[Adjust App Settings]
    R --> R1[Change Theme]
    R1 --> R2[Set Notifications]
    R2 --> R3[Update Profile]
    R3 --> G
    W --> W1[View Current Bookings]
    W1 --> W2[Modify Booking]
    W2 --> W3{Cancel Booking?}
    W3 -->|Yes| W4[Confirm Cancellation]
    W3 -->|No| G
    W4 --> G
    O --> S[Follow AR Directions]
    S --> S1[Scan Environment]
    S1 --> S2[Display Overlay]
    S2 --> S3[Update Path]
    S3 --> T[Arrive at Desk]
    T --> U[End Navigation]
    U --> V{Rate Experience?}
    V -->|Yes| V1[Submit Rating]
    V -->|No| G
    V1 --> G

    %% Styling
    classDef default fill:#f9f9f9,stroke:#333,stroke-width:2px;
    classDef highlight fill:#e1f5fe,stroke:#01579b,stroke-width:2px;
    classDef process fill:#fffde7,stroke:#fbc02d,stroke-width:2px;
    class G,M,O,P,R,W highlight;
    class D1,D2,D4,D5,M1,M2,M3,M4,P1,P2,R1,R2,R3,W1,W2,W4,S1,S2,S3,V1 process;