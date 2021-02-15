import 'dart:io';
import 'package:app_chat/models/response/users/listusersResponse.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/io_client.dart';

import 'package:app_chat/config/enviroment.dart';
import 'package:app_chat/models/user.dart';

class UsersService {
  final _storage = new FlutterSecureStorage();

  Future<List<User>> listUsers() async {
    final token = await _storage.read(key: 'token');

    try {
      final ioc = new HttpClient();
      final http = new IOClient(ioc);

      final resp = await http.get('${Enviroment.apiPath}/users/listusers',
          headers: {'Content-Type': 'application/json', 'x-token': token});

      if (resp.statusCode == 200) {
        final listUserResponse = listUserResponseFromJson(resp.body);
        if (listUserResponse.info.code == '00') {
          return listUserResponse.output;
        }
      } else {
        return [];
      }
    } catch (err) {
      return [];
    }
  }
}
