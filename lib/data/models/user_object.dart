// data/models/UserObject.dart
class UserObject {
  final UserObjectData? data;
  final Support? support;

  UserObject({this.data, this.support});

  factory UserObject.fromJson(Map<String, dynamic> json) {
    return UserObject(
      data: UserObjectData.fromJson(json['data']),
      support: Support.fromJson(json['support']),
    );
  }
}

class UserObjectData {
  final dynamic id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  UserObjectData({this.id, this.email, this.firstName, this.lastName, this.avatar});

  factory UserObjectData.fromJson(Map<String, dynamic> json) {
    return UserObjectData(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}

class Support {
  final String? url;
  final String? text;

  Support({this.url, this.text});

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      url: json['url'],
      text: json['text'],
    );
  }
}
