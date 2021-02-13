// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.isOnline,
    this.name,
    this.email,
    this.token,
    this.uid,
  });

  bool isOnline;
  String name;
  String email;
  String token;
  String uid;

  factory User.fromJson(Map<String, dynamic> json) => User(
    isOnline: json["isOnline"],
    name: json["name"],
    email: json["email"],
    token: json["token"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "isOnline": isOnline,
    "name": name,
    "email": email,
    "token": token,
    "uid": uid,
  };
}