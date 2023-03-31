import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../model/user.dart';
import 'authorization_interceptor.dart';
import 'firebase_performance_interceptor.dart';
import 'logger_interceptor.dart';

// Step 2: Create a repository that handles fetching the data from the API
class UserRepository {
  // Create a Dio instance with base options and logger interceptor
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds:5),
    receiveTimeout: const Duration(seconds: 3),
    responseType: ResponseType.json,
  ))..interceptors.addAll([

     //AuthorizationInterceptor(),
     LoggerInterceptor(),
     //DioFirebasePerformanceInterceptor(),

  ]);




  // This method makes a GET request to the '/users' endpoint of the API
  // and returns a list of User objects parsed from the response
  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get('/users');
      final data = response.data as List<dynamic>;
      final users = data.map((json) => User.fromJson(json)).toList();
      return users;
    } catch (e) {
      // If the request fails, throw an exception with a message
      throw Exception('Failed to load users');
    }
  }

  // This method makes a GET request to the '/users' endpoint of the API
  // and returns a list of User objects parsed from the response
  Future<List<User>> Register() async {
    try {
      final response = await _dio.get('/users');
      final data = response.data as List<dynamic>;
      final users = data.map((json) => User.fromJson(json)).toList();
      return users;
    } catch (e) {
      // If the request fails, throw an exception with a message
      throw Exception('Failed to load users');
    }
  }

}
