// data/repositories/user_repository.dart
import '../models/login_response.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class LoginRepository {
  final ApiService
  apiService; // Instance of the ApiService class to perform API requests.

  LoginRepository({required this.apiService});

  Future<String?> login(Map<dynamic, dynamic> req) async {
    try {
      // Attempt to make the API call to login the user using the apiService.
      final response = await apiService.loginUser(req);
      // Store the response from the API call in the 'response' variable.

      return response;
      // If the API call is successful, return the response (String) to the caller.
    } catch (e) {
      // If an exception occurs during the API call, catch it and handle the error.

      throw Exception('Failed to login');
      // Throw a new Exception with the message 'Failed to login', indicating that the login process failed.
      // The caller of this function can catch this exception and handle the error appropriately.
    }
  }
}
