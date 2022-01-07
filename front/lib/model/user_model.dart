import 'package:flutter/foundation.dart';

class User {
  final String username;
  final String password;
  final String picUrl;
  final String email;

  User({
    required this.username,
    required this.password,
    required this.email,
    required this.picUrl,
  });

  factory User.fromJson(Map<String, String> json) {
    return User(
      email: json['email'] as String,
      password: json['password'] as String,
      picUrl: json['picUrl'] as String,
      username: json['userName'] as String,
    );
  }
}
