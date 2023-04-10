import 'package:dio_api/view/my_index.dart';
import 'package:dio_api/view_model.dart/user_view_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/api_service.dart';
import 'package:firebase_core/firebase_core.dart';
// Main function to run the app
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {

  }
  else{
    // Firebase Crashlytics is only supported in Flutter for iOS, Android, and macOS.
    await Firebase.initializeApp();

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: false);
      return true;
    };
    // Set user ID for Firebase Crashlytics
    FirebaseCrashlytics.instance.setUserIdentifier('5514');
  }

  // Create a multi-provider for the app and provide UserViewModel
  runApp(
      MultiProvider(
        providers: [
          // Pass in the UserRepository instance as an argument
          ChangeNotifierProvider(create: (_) => UserViewModel(userRepository: UserRepository())),
        ],
        child: const MyApp(),
      ));
}

// MyApp widget to build the app
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// State for MyApp widget
class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DIO api',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.red,
      ),

      // Set the home screen to the UserList screen
      home:
      const Scaffold(
        body: MyIndex(),
      ),

    );
  }
}
