import 'package:flutter/material.dart';

import 'package:app_chat/routes/routes.dart';
// import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Chat',
      initialRoute: 'login',
      routes: appRoutes,
    );
  }
}
