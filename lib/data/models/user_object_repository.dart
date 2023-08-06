// viewmodels/user_view_model.dart
import 'package:flutter/material.dart';
import 'package:dio_api/data/models/user_object.dart';
import '../models/user.dart';
import '../repositories/user_object_repository.dart';

class UserObjectViewModel extends ChangeNotifier {
  final UserObjectRepository userRepository;

  UserObjectViewModel({required this.userRepository});

  UserObject? _user;
  bool _loading = false;
  String _errorMessage = '';

  UserObject? get user => _user;
  bool get loading => _loading;
  String get errorMessage => _errorMessage;

  Future<void> fetchUserData() async {
    _loading = true;
    _errorMessage = '';

    try {
      _user = await userRepository.getUserData();
    } catch (e) {
      _errorMessage = 'Failed to fetch user data';
    }
    _loading = false;
    notifyListeners();
  }



}
