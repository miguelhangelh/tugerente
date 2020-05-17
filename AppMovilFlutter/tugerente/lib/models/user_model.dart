import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int usercode;
  String name;
  String email;
  String password;
  User({
    this.usercode,
    this.name = '',
    this.email = '',
    this.password = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      usercode: json["usercode"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() => {
        // "usercode"         : usercode,
        "name": name,
        "email": password,
        "password": password,
      };
}
