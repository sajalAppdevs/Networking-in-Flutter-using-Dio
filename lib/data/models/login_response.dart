// login_response.dart
class LoginResponse {
  final String? name;
  final String? job;
  // Add other fields as needed

  LoginResponse({this.name, this.job});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      name: json['name'],
      job: json['job'],
      // Parse other fields from the JSON response
    );
  }
}
