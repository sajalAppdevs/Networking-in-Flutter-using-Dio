/*import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';*/
import 'package:dio/dio.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio_api/data/models/user_object_repository.dart';
import 'package:dio_api/data/repositories/login_repository.dart';
import 'package:dio_api/utils/firebase_performance_interceptor.dart';
import 'package:dio_api/utils/logger_interceptor.dart';
import 'package:dio_api/utils/shared_preferences.dart';
import 'package:dio_api/viewmodels/grid_photo_provider.dart';
import 'package:dio_api/viewmodels/login_view_model.dart';
import 'package:dio_api/viewmodels/product_view_model.dart';
import 'package:dio_api/viewmodels/user_view_model.dart';
import 'package:dio_api/views/login_page.dart';
import 'package:dio_api/views/pagination2.dart';
import 'package:dio_api/views/product_list.dart';
import 'package:dio_api/views/user_list.dart';
import 'package:dio_api/views/user_list_consumer.dart';
import 'package:dio_api/views/user_object.dart';
import 'package:provider/provider.dart';
import './data/repositories/user_repository.dart';
import './data/services/api_service.dart';
import 'data/repositories/pagination_repository.dart';
import 'data/repositories/product_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/repositories/user_object_repository.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  // Create Dio instance for HTTP requests
  final Dio dio = Dio();

  // Create ApiService instance with the Dio instance
  final ApiService apiService = ApiService(dio: dio);

  // Create UserRepository instance with the ApiService instance
  final UserRepository userRepository = UserRepository(apiService: apiService);
  final ProductRepository productRepository = ProductRepository(apiService: apiService);
  final LoginRepository loginRepository = LoginRepository(apiService: apiService);
  final paginationRepository = PaginationRepository(apiService: apiService);
  final UserObjectRepository userObjectRepository = UserObjectRepository(apiService: apiService);

  if (kIsWeb) {

  }
  else{
    // Firebase Crashlytics is only supported in Flutter for iOS, Android, and macOS.
    await Firebase.initializeApp();

    //FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

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
    //FirebaseCrashlytics.instance.crash(); test crash

    // Initialize Firebase Performance
    await FirebasePerformance.instance.setPerformanceCollectionEnabled(true);

    await SharedPrefUtils.saveString('user_id', "12345678");
    final userId = await SharedPrefUtils.getString('user_id');

    // Create the DioFirebasePerformanceInterceptor instance and set the user ID
    final interceptor = DioFirebasePerformanceInterceptor(userId: userId);
    // Add the interceptor to Dio
    dio.interceptors.add(interceptor);

  }


  // Provider
  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider<UserViewModel>(create: (context) => UserViewModel(userRepository: userRepository),),
        ChangeNotifierProvider<ProductViewModel>(create: (context) => ProductViewModel(productRepository: productRepository),),
        ChangeNotifierProvider<LoginViewModel>(create: (context) => LoginViewModel(userRepository: loginRepository),),
        ChangeNotifierProvider<PhotoProvider>(create: (context) => PhotoProvider(userRepository: paginationRepository),),
        ChangeNotifierProvider<UserObjectViewModel>(create: (context) => UserObjectViewModel(userRepository: userObjectRepository),),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    logDebug('this is debug');
    logDebug('this is debug', level: Level.debug);
    logDebug('this is info', level: Level.info);
    logDebug('this is warning', level: Level.warning);
    logDebug('this is error', level: Level.error);
    logDebug('this is alien', level: Level.alien);

    return MaterialApp(
      title: 'User List', // Meta Title for the App
      theme: ThemeData(
        //primarySwatch: Colors.green,
        useMaterial3: false,
      ),
    //  home: const ProductList(),
      home:  MyIndex(),
    );
  }
}

class MyIndex extends StatelessWidget {
  const MyIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Item> items = [

      const Item(
          title: '#1',
          description: 'Dio API Integration and Provider (without consumer) for ListView App',
          url: 'https://www.boltuix.com/2023/08/dio-mvvm-get-api-integration-with_5.html',
          widget : UserList()
      ),
    const Item(
          title: '#2',
          description: 'Dio API Integration and Provider (with consumer) for ListView App',
          url: 'https://www.boltuix.com/2023/03/networking-in-flutter-using-dio.html',
          widget : UserListConsumer()
      ),

      const Item(
          title: '#3',
          description: 'With Nested JSON Object - List view',
          url: 'https://www.boltuix.com/2023/08/dio-mvvm-get-api-integration-with.html',
          widget : ProductList()
      ),
      const Item(
          title: '#4',
          description: 'With Nested JSON Object - profile view',
          url: 'https://www.boltuix.com/2023/08/dio-mvvm-get-api-integration-with_66.html',
          widget : UserObjectPage()
      ),
       Item(
          title: '#5',
          description: 'Making POST requests with Dio + login',
          url: 'https://www.boltuix.com/2023/08/dio-api-integration-login-api-with.html',
          widget : LoginPage()
      ),

      const Item(
          title: '#6',
          description: 'Making GET requests with Dio + Pagination',
          url: 'https://www.boltuix.com/2023/08/dio-api-integration-with-pagination-in.html',
          widget : PaginationViewWidget()
      ),




      /*
      const Item(
          title: '#4',
          description: 'Making Upload requests with Dio',
          url: '',
          widget : MyUploadWidget()
      ),
      const Item(
          title: '#5',
          description: 'Making Download requests with Dio',
          url: '',
          widget : MyDownloadWidget()
      ),
      const Item(
          title: '#6',
          description: 'Switch Test',
          url: '',
          widget : UserListSwitch()
      ),*/

    ];

    return
      ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return
            Card( //                           <-- Card widget
              child: ListTile(
                //leading: Icon(icons[index]),
                title: Text(items[index].title),
                subtitle: Text(items[index].description),
                onTap: () async {
                  navigateToPage(context,items[index].widget);
                },
              ),
            );
        },
      );
  }
}

class Item {
  final String title;
  final String description;
  final String url;
  final Widget widget;

  const Item({
    required this.title,
    required this.description,
    required this.url,
    required this.widget,
  });
}

void navigateToPage(BuildContext context, Widget destination) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => destination),
  );
}
