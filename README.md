## acuro
A new Flutter project.

## Overview
Acuro is a mobile application developed using the Flutter framework. 
It follows a modular architecture for clean and maintainable code, emphasizing separation of concerns and reusability. 
The application handles user authentication, registration, and password reset functionalities with proper state management and input validation.


## Prerequisites
- Before you can run the project, ensure that you have the following installed:
1. Flutter SDK: Flutter Installation Guide
2. Xcode (for iOS development)
3. Android Studio (with Flutter and Dart plugins)

## Setup Instructions
1. Clone the repository: "https://github.com/acuroai/acuro-forecast-platform-frontend-product-app.git"
2. Install dependencies: Run the following command to install required packages with command : "flutter pub get"
3. iOS Setup : Need Apple Developer account credentials to set up the iOS environment and upload the build to TestFlight.
4. Run the app: To run on Android or iOS: "flutter run",
5. Command for delete all configuration and rebuild :  
   Export path : "export PATH="$PATH:/Users/mac/Documents/flutter/bin",
   Rebuild command : "flutter packages pub run build_runner build --delete-conflicting-outputs"
6. Create build command : "flutter build apk -t lib/main.dart"

## Features
1. Authentication:
   - Login functionality. 
   - OTP-based verification. 
   - Password reset support for both email and phone.
2. Navigation:
   - Well-defined page routing using @RoutePage annotations.
3. Responsive Design:
   - Support for Android, iOS, and other Flutter-supported platforms.
4. Custom Components:
   - Modularized UI components for reuse across the app.


## Project structure
lib/
├── application/             # Business logic and application-level logic
│   ├── auth/                # Authentication-related BLoC and repositories
│   ├   |── bloc/            # Business Logic Components
│   ├   |── repositories/    # Data repositories for API and local data handling
├── components/              # UI components
│   ├── Common/              # Reusable UI widgets
│   ├── Login/               # Login flow-specific components
├── core/                    # Core application utilities and configurations
│   ├── constants/           # Application-wide constants
│   │   ├── Constants.dart         # General constants for the application
│   │   ├── EnvVariable.dart       # Environment-specific constants(Not fixed values)
│   │   ├── GlobalConstant.dart    # Global constants for reusable settings or values
│   │   ├── ImageConstants.dart    # Image asset paths
│   ├── di/                        # Dependency injection setup
│   │   ├── Injectable.config.dart
│   │   ├── Injectable.dart
│   ├── environment/         # Environment configurations (e.g., dev, prod)
│   ├── exceptions/          # Exception handling
│   ├── interceptors/        # Network request/response interceptors
│   ├── logging/             # Logging utilities
│   ├── navigator/           # Navigation-related utilities
│   ├── persistence/         # Local storage utilities
│   │   ├── PreferenceHelper.dart
│   │   ├── Preferences.dart
│   ├── theme/               # Theme configuration
│   │   ├── AppColors.dart        # Application color palette
│   │   ├── AppTheme.dart         # Theme settings for light/dark modes
│   ├── utils/               # Helper utilities
│       ├── AppUtils.dart         # General helper methods
│       ├── TimeUtils.dart        # Time-related utilities
│       ├── ToastUtils.dart       # Toast notifications utilities
├── models/                  # Data models
├── pages/                   # UI screens/pages
│   ├── Login/               # Screens related to user login and registration and reset password
│   ├── Main/                # Main application pages after login
│   ├── Splash/              # Splash and onboarding screens
├── app.dart                 # Main application entry point
├── main.dart                # Flutter entry point


## Usages (Structure wise explaination)

#1. Main Pages

1. main.dart is the entry point of the app. It initializes key settings and services before running the app with `runApp()`.
2. app.dart manages the main app layout, routing, and navigation between pages.
3. It connects the app to global services and organizes the app's flow.

#2. Applications

1. The BLoC pattern is used to separate business logic from the UI.
2. BLoC listens for user actions (events) and updates the UI based on data changes (states).
3. Repositories fetch data, and repoImpl contains the code to retrieve it.
4. The UI updates dynamically when data changes, like showing a loading screen during data fetch.

#3. Components

1. Components are reusable UI elements like buttons, text fields, and loading spinners.
2. They help maintain design consistency by using common components across multiple pages.
3. Components interact with the app’s state and update dynamically based on data changes.

#4. Core

1. The Core folder contains essential services like network requests, authentication, error handling, and global settings.
2. It centralizes important features, making them easy to access and reuse across the app.
3. This structure makes the app’s code cleaner and easier to maintain and update.

#5. Model

1. Models define how the app’s data is structured, representing entities like users, products, or orders.
2. They convert raw data (e.g., from APIs) into usable objects within the app.
3. Models ensure data is validated and formatted correctly before being used in the UI.

#6. Pages

1. Pages represent the main screens of the app, like login or profile pages.
2. Each page connects to business logic (via BLoCs) and displays relevant data to the user.
3. Pages manage user interactions (e.g., input, button presses) and ensure smooth app functionality.


### Thanks You ###