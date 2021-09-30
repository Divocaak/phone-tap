import 'package:flutter/material.dart';

class User {
  int phoneNum;
  String token;

  User(this.phoneNum, this.token);

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(int.parse(json["phoneNum"]), json["token"]);
  }

  Map<String, dynamic> toJson() => {"phoneNum": phoneNum, "token": token};
}
