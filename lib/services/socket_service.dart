import 'package:app_chat/config/enviroment.dart';
import 'package:app_chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  void connectInit() async {
    final token = await AuthService.getToken();
    // Dart client
    try {
      this._socket = io(
          '${Enviroment.socketPath}',
          OptionBuilder()
              .setTransports(['websocket'])
              .enableForceNew()
              .enableAutoConnect()
              .setExtraHeaders({'x-token': token})
              .build());

      this._socket.onConnect((_) {
        this._serverStatus = ServerStatus.Online;
        notifyListeners();
        print('connect');
      });

      this._socket.onDisconnect((_) {
        this._serverStatus = ServerStatus.Offline;
        notifyListeners();
        print('disconnect');
      });

      this._socket.on('connect_error', (data) {
        this._serverStatus = ServerStatus.Offline;
        notifyListeners();
        print(data);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void disconnect() {
    this._socket.clearListeners();
    this._socket.disconnect();
  }
}
