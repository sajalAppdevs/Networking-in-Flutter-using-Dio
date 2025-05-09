# Networking in Flutter using Dio

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![Dio](https://img.shields.io/badge/Dio-5.0+-orange.svg)](https://pub.dev/packages/dio)
[![Firebase](https://img.shields.io/badge/Firebase-Latest-yellow.svg)](https://firebase.google.com/)

A comprehensive Flutter application demonstrating best practices for handling network requests using the Dio HTTP client. This project showcases proper API integration, error handling, and performance monitoring using Firebase.

<img src="https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhhwDKBixLPb1QBFh8gI2-BwmmyTggRAbBQ9nyRzhUwPGl_ZLl31u8j4D54f83d_qLTyt6ZETpj5_0Hbg9vIqJyuRZc4cN1olCPn7cR2M7J3nqLuwcJTUGj4HiC193766rlH7qcBEH8Jc_OBbgxa8iIDeaJ5_E9dzKrere2KxlEnRZVUK21kx10-rjE/s16000/API.jpg" alt="Project Banner">

## Features

- 🔒 **Authentication** - Implements login functionality with proper token management
- 📊 **Data Management** - Demonstrates CRUD operations using REST APIs
- 📱 **Modern UI** - Clean and responsive user interface using Provider for state management
- 🔍 **API Interceptors** - Custom interceptors for logging and performance monitoring
- 📈 **Firebase Integration** - Performance monitoring and crash reporting
- 📝 **Pagination** - Efficient data loading with pagination support
- 🎯 **Repository Pattern** - Clean architecture with separation of concerns

## Project Structure

```
lib/
├── data/
│   ├── models/         # Data models
│   ├── repositories/   # Repository implementations
│   └── services/       # API service layer
├── utils/
│   ├── authorization_interceptor.dart
│   ├── firebase_performance_interceptor.dart
│   ├── logger_interceptor.dart
│   └── shared_preferences.dart
├── viewmodels/        # Business logic and state management
├── views/             # UI components and screens
└── main.dart          # Application entry point
```

## Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/Networking-in-Flutter-using-Dio.git
cd Networking-in-Flutter-using-Dio
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Create a new Firebase project
   - Add your `google-services.json` for Android and `GoogleService-Info.plist` for iOS
   - Enable Firebase Performance Monitoring and Crashlytics

4. Run the application:
```bash
flutter run
```

## Dependencies

- [dio](https://pub.dev/packages/dio) - HTTP client for API requests
- [provider](https://pub.dev/packages/provider) - State management
- [firebase_core](https://pub.dev/packages/firebase_core) - Firebase core functionality
- [firebase_performance](https://pub.dev/packages/firebase_performance) - Performance monitoring
- [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics) - Crash reporting

## Key Features Implementation

### API Service Setup
```dart
final Dio dio = Dio();
final ApiService apiService = ApiService(dio: dio);
```

### Custom Interceptors
- **Logger Interceptor** - For debugging API calls
- **Firebase Performance Interceptor** - For monitoring API performance
- **Authorization Interceptor** - For handling authentication tokens

### Repository Pattern
```dart
final UserRepository userRepository = UserRepository(apiService: apiService);
final ProductRepository productRepository = ProductRepository(apiService: apiService);
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Learn More

For more information about networking in Flutter using Dio, visit:
https://www.boltuix.com/2023/03/networking-in-flutter-using-dio.html