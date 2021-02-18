import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_chat/routes/routes.dart';
import 'package:app_chat/services/custom_http_overrides.dart';

import 'package:app_chat/services/auth_service.dart';
import 'package:app_chat/services/socket_service.dart';
import 'package:app_chat/services/chat_service.dart';

void main() {
  HttpOverrides.global = new CustomHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => SocketService() ),
        ChangeNotifierProvider(
          create: (BuildContext context) => AuthService() ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ChatService() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Chat',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
