// To parse this JSON data, do
//
//     final historyMessageResponse = historyMessageResponseFromJson(jsonString);

import 'dart:convert';

import '../../message.dart';
import '../infoResponse.dart';

HistoryMessageResponse historyMessageResponseFromJson(String str) => HistoryMessageResponse.fromJson(json.decode(str));

String historyMessageResponseToJson(HistoryMessageResponse data) => json.encode(data.toJson());

class HistoryMessageResponse {
    HistoryMessageResponse({
        this.info,
        this.output,
    });

    InfoResponse info;
    List<Message> output;

    factory HistoryMessageResponse.fromJson(Map<String, dynamic> json) => HistoryMessageResponse(
        info: InfoResponse.fromJson(json["INFO"]),
        output: List<Message>.from(json["OUTPUT"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "INFO": info.toJson(),
        "OUTPUT": List<dynamic>.from(output.map((x) => x.toJson())),
    };
}


