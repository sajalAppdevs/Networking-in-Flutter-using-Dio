import 'package:dio_api/view/my_index.dart';
import 'package:dio_api/view/user_list.dart';
import 'package:dio_api/view_model.dart/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/api_service.dart';

// Main function to run the app
Future<void> main() async {

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
