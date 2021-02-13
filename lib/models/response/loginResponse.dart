// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_chat/models/user.dart';
import 'package:app_chat/models/response/infoResponse.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());
String userResponseToJson(User data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.info,
    this.output,
  });

  InfoResponse info;
  User output;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    info: InfoResponse.fromJson(json["INFO"]),
    output: User.fromJson(json["OUTPUT"]),
  );

  Map<String, dynamic> toJson() => {
    "INFO": info.toJson(),
    "OUTPUT": output.toJson(),
  };
}
