// Step 1: Create a data model for the user object
class User {
  final int id; // User ID
  final String name; // User name
  final String email; // User email address

  User({required this.id, required this.name, required this.email});

  // Factory method to create a User object from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], // Extract the ID from the JSON map
      name: json['name'], // Extract the name from the JSON map
      email: json['email'], // Extract the email address from the JSON map
    );
  }
}
