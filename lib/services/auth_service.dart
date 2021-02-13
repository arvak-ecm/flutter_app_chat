import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:app_chat/models/response/loginResponse.dart';
import 'package:app_chat/models/user.dart';
import 'package:app_chat/config/enviroment.dart';

class AuthService with ChangeNotifier {
  User user;

  bool _isAuth = false;
  final _storage = new FlutterSecureStorage();

  bool get isAuth => this._isAuth;
  set isAuth(bool value) {
    this._isAuth = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    return await _storage.read(key: 'token');
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future login(String mail, String password) async {
    this._isAuth = true;
    await _deleteToken();

    final data = {'email': mail, 'password': password};

    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      final resp = await http.post('${Enviroment.apiPath}/auth/login',
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});

      // print(resp.body);

      this._isAuth = false;

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        if (loginResponse.info.code == '00') {
          this.user = loginResponse.output;
          this._saveToken(this.user.token);
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      this._isAuth = false;
      return false;
    }
  }

  Future register(String name, String mail, String password) async {
    this._isAuth = true;
    await _deleteToken();

    final data = {'name': name, 'email': mail, 'password': password};

    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      final resp = await http.post('${Enviroment.apiPath}/auth/register',
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});

      // print(resp.body);

      this._isAuth = false;

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        if (loginResponse.info.code == '00') {
          this.user = loginResponse.output;
          this._saveToken(this.user.token);
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      this._isAuth = false;
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);

      final resp = await http.get('${Enviroment.apiPath}/auth/renewJWT',
          headers: {'Content-Type': 'application/json', 'x-token': token});

      // print(resp.body);

      this._isAuth = false;

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        if (loginResponse.info.code == '00') {
          this.user = loginResponse.output;
          this._saveToken(this.user.token);
          return true;
        }
      } else {
        this._deleteToken();
        return false;
      }
    } catch (e) {
      this._isAuth = false;
      this._deleteToken();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _deleteToken() async {
    return await _storage.delete(key: 'token');
  }
}
