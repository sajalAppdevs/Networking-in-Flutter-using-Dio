// Step 3: Create a view model that uses the repository to get the data
import 'package:flutter/cupertino.dart';
import '../controller/api_service.dart';
import '../model/user.dart';

class UserViewModel extends ChangeNotifier {

  final UserRepository userRepository; // Declare a final UserRepository object
  UserViewModel({required this.userRepository}); // Constructor to initialize the UserRepository object

  List<User> _users = []; // List of User objects
  bool _loading = false; // Boolean flag to track if data is loading or not
  String _errorMessage = ''; // String to hold error message if any

  List<User> get users => _users; // Getter method to get the list of users
  bool get loading => _loading; // Getter method to get the loading flag
  String get errorMessage => _errorMessage; // Getter method to get the error message

  Future<void> fetchUsers() async { // Async method to fetch users from repository
    _loading = true; // Set loading flag to true
    try {
      _users = await userRepository.getUsers(); // Call getUsers() method from UserRepository and assign the returned value to _users list
    } catch (e) { // Catch any exceptions
      _errorMessage = e.toString(); // Set the error message string to the exception string
    } finally {
      _loading = false; // Set loading flag to false
      notifyListeners(); // Notify listeners that the data has changed
    }
  }
}
