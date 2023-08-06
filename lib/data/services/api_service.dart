// data/services/api_service.dart

import 'package:dio/dio.dart';

import '../../utils/logger_interceptor.dart';

class ApiService {
  late Dio _dio; // Dio instance to perform HTTP requests.

  // ApiService({required Dio dio}) : _dio = dio;
  ApiService({required Dio dio}) {
    _dio = Dio(BaseOptions(
      //baseUrl: "https://dummyjson.com/products/",
      // connectTimeout: const Duration(seconds:5),
      // receiveTimeout: const Duration(seconds: 3),
      responseType: ResponseType.json,
    ))..interceptors.addAll([

      //LoggerInterceptor(), //custom logger interceptor.

    ]);
  }




  Future<List<dynamic>> getUsers() async {
    try {
      // Make a GET request to the API endpoint to fetch user data.
      final response = await _dio.get('https://jsonplaceholder.typicode.com/users');

      // Check if the response status code is 200 (OK).
      if (response.statusCode == 200) {
        return response.data; // If successful, return the response data (List of dynamic).
      } else {
        // If the response status code is not 200, throw an exception with an error message.
        throw Exception('API failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // If any exception occurs during the API call, throw an exception with the error message.
      throw Exception('An error occurred: $e');
    }
  }

  Future<Map<String, dynamic>> getProducts() async {
    try {
      // Make a GET request to the API endpoint to fetch product data.
      //final response = await _dio.get('search?q=Laptop');
      final response = await _dio.get('https://dummyjson.com/products/search?q=Laptop');

      // Check if the response status code is 200 (OK).
      if (response.statusCode == 200) {
        return response.data; // If successful, return the response data (Map of dynamic).
      } else {
        // If the response status code is not 200, throw an exception with an error message.
        throw Exception('API failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // If any exception occurs during the API call, throw an exception with the error message.
      throw Exception('An error occurred: $e');
    }
  }







  Future<int> createComment(Map<String, dynamic> commentData) async {
    try {
      // Make a POST request to the API endpoint to create a new comment.
      final response = await _dio.post('https://jsonplaceholder.typicode.com/comments', data: commentData);

      // Check if the response status code is 201 (Created).
      if (response.statusCode == 201) {
        // If successful, return the ID of the newly created comment.
        return response.data['id'];
      } else {
        // If the response status code is not 201, throw an exception with an error message.
        throw Exception('API failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // If any exception occurs during the API call, throw an exception with the error message.
      throw Exception('An error occurred: $e');
    }
  }




  /*https://reqres.in/api/login
Request:
{
    "email": "eve.holt@reqres.in",
    "password": "cityslicka"
}

success: 201
{
    "error": "user not found"
}

failure: 404
{
    "token": "QpwL5tke4Pnpja7X4"
}*/
  Future<String?> loginUser(Map<dynamic, dynamic> req) async {
    try {
      final response = await _dio.post('https://reqres.in/api/login', data: req);
      if (response.statusCode == 200) {
        // Success
        //return response.data['token'];
        // Check if 'token' key exists in the response data
        if (response.data.containsKey('token')) {
          return response.data['token'];
        }
        // If 'error' key doesn't exist, return a generic error message
        return 'An error occurred';

      } else {
        // Handle other status codes as needed
        return 'Failed to login';
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null && e.response!.data != null && e.response!.data['error'] != null) {
          final errorMessage = e.response!.data['error'];
          print('Error Message: $errorMessage');
          return errorMessage;
        }
      }
      // Handle other errors or exceptions
      print('Error: $e');
      return null;
    }
  }





  Future<Map<String, dynamic>> getPhotos(int page, String search) async {

    try {
      // Make a GET request to the API endpoint to fetch product data.
      //final response = await _dio.get('search?q=Laptop');
      final response = await _dio.get("https://pixabay.com/api/?key=35457470-ba2fadec934c3233f2e9afacc&q=$search&image_type=photo&pretty=true&page=$page");

      // Check if the response status code is 200 (OK).
      if (response.statusCode == 200) {
        return response.data; // If successful, return the response data (Map of dynamic).
      } else {
        // If the response status code is not 200, throw an exception with an error message.
        throw Exception('API failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // If any exception occurs during the API call, throw an exception with the error message.
      throw Exception('An error occurred: $e');
    }

   /* response = await _dio.get("/api/?key=35457470-ba2fadec934c3233f2e9afacc&q=yellow+flowers&image_type=photo&pretty=true&page=$page",
      //  options: Options(headers: {'Authorization': 'Bearer PpQRtZ3LG2MrSB1MZtJvHUrZ6z7cRQvvCqOSglpzJpc30aAIE5pvdCtP'
    );
    return response.data;*/
  }




  // data/services/api_service.dart
  Future<Map<String, dynamic>> getUserObject(int id) async {
    try {
      final response = await _dio.get('https://reqres.in/api/users/$id');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('API failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }



}

