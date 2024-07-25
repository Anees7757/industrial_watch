# Industrial Watch

Industrial Watch is a comprehensive quality assurance solution designed to monitor products and employees in a company. It ensures efficiency and compliance with company policies through real-time monitoring and dynamic rule application.

## Features

- **Defect Monitoring**: Real-time monitoring of products for quality assurance.
- **Employee Monitoring**: Tracks attendance, posture, smoking, and mobile usage.
- **Dynamic Rule Application**: Apply and manage rules for different sections within the company.
- **Real-time Alerts and Notifications**: Receive real-time alerts for rule violations and critical events.
- **Data Visualization and Analytics**: Visualize data and analyze trends to improve operations.

## Technologies Used

- **Frontend**: Flutter (for mobile and web interface)
- **Backend**: Flask (Python) [Backend Repository](https://github.com/usamafayaz/IndustrialWatchBackend)
- **Face Detection**: FaceNet
- **Posture Detection**: MediaPipe
- **Trained Models**: For smoking and mobile usage detection

## Installation

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Python](https://www.python.org/downloads/) and Flask

### Setup

1. Clone the repository
    ```bash
    git clone https://github.com/Anees7757/industrial_watch.git
    cd industrial_watch
    ```

2. Install dependencies
    ```bash
    flutter pub get
    ```

### Backend

1. Clone the backend repository
    ```bash
    git clone https://github.com/usamafayaz/IndustrialWatchBackend.git
    cd IndustrialWatchBackend
    ```

2. Install Python dependencies
    ```bash
    pip install -r requirements.txt
    ```

3. Run the Flask server
    ```bash
    flask run
    ```

## Permissions

### Android

Ensure the following permissions and configurations are included in `android/app/src/main/AndroidManifest.xml`:
```xml
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
    <uses-permission android:name="android.permission.CAMERA"
        tools:ignore="PermissionImpliesUnsupportedChromeOsHardware" />
```

Ensure your `android/build.gradle` and `android/app/build.gradle` files are properly configured.

### iOS

Ensure your `ios/Runner/Info.plist` file contains the necessary configurations.

## Usage

1. Run the Flutter application
    ```bash
    flutter run
    ```

2. Access the application via the web, Android, or iOS.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.

1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Open a pull request

## Contact

For any inquiries, please reach out to [anees7757@gmail.com](mailto:anees7757@gmail.com).

---

*Industrial Watch* - Ensuring quality and compliance in industrial operations.