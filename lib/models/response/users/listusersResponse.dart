// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_chat/models/user.dart';
import 'package:app_chat/models/response/infoResponse.dart';

ListUserResponse listUserResponseFromJson(String str) => ListUserResponse.fromJson(json.decode(str));
String listUserResponseToJson(ListUserResponse data) => json.encode(data.toJson());

class ListUserResponse {
    ListUserResponse({
        this.info,
        this.output,
    });

    InfoResponse info;
    List<User> output;

    factory ListUserResponse.fromJson(Map<String, dynamic> json) => ListUserResponse(
        info: InfoResponse.fromJson(json["INFO"]),
        output: List<User>.from(json["OUTPUT"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "INFO": info.toJson(),
        "OUTPUT": List<User>.from(output.map((x) => x.toJson())).toList(),
    };
}
