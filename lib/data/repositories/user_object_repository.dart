// data/repositories/user_repository.dart
import '../models/user.dart';
import '../models/user_object.dart';
import '../services/api_service.dart';

class UserObjectRepository {
  final ApiService apiService;

  UserObjectRepository({required this.apiService});

  Future<UserObject> getUserData() async {
    try {
      final data = await apiService.getUserObject(2);
      return UserObject.fromJson(data);
    } catch (e) {
      throw Exception('Failed to fetch user data');
    }
  }
}
