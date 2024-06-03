import 'package:flutter/material.dart';

class LoginVM {
  final String email;
  final String password;

  LoginVM({
    required this.email,
    required this.password,
  });

  factory LoginVM.fromJson(Map<String, dynamic> json) {
    return LoginVM(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}