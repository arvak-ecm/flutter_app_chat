import 'package:app_chat/pages/contacts_page.dart';
import 'package:app_chat/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_chat/services/auth_service.dart';
import 'package:app_chat/widgets/ScaffoldApp.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldAppWidget(
      appBar: false,
      widget: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapshot) {
            return Center(
              child: Text(
                'loading.....',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final isLoggedIn = await authService.isLoggedIn();

    if (isLoggedIn) {
      //Navigator.pushReplacementNamed(context, 'contacts');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => ContactsPage(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginPage(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
