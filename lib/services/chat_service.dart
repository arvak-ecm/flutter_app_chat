import 'dart:io';

import 'package:app_chat/config/enviroment.dart';
import 'package:app_chat/models/message.dart';
import 'package:app_chat/models/response/messages/historymessagesResponse.dart';
import 'package:flutter/material.dart';
import 'package:app_chat/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/io_client.dart';

class ChatService with ChangeNotifier {
  final _storage = new FlutterSecureStorage();
  User userTo;

  Future<List<Message>> getHistoryMessage(String tokenFrom) async {
    final token = await _storage.read(key: 'token');

    try {
      final ioc = new HttpClient();
      final http = new IOClient(ioc);

      final resp = await http.get('${Enviroment.apiPath}/messages/msghistory/$tokenFrom',
          headers: {'Content-Type': 'application/json', 'x-token': token});

      if (resp.statusCode == 200) {
        final historyMessageResponse = historyMessageResponseFromJson(resp.body);
        if (historyMessageResponse.info.code == '00') {
          return historyMessageResponse.output;
        }
      } else {
        return [];
      }
    } catch (err) {
      return [];
    }
    return [];
  }

}
