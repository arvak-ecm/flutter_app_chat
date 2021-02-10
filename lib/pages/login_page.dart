import 'package:app_chat/widgets/NavAuth.dart';
import 'package:app_chat/widgets/ScaffoldApp.dart';
import 'package:flutter/material.dart';

import 'package:app_chat/widgets/logo_app.dart';
import 'package:app_chat/widgets/form/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldAppWidget(
      listWidget: [
        LogoAppWidget(title: 'Messenger'),
        LoginForm(),
        NavAuth(
          route: 'register',
          title: 'Crea una ahora!',
          subTitle: '¿No tienes cuenta?',
        ),
        Text(
          'Términos y condiciones de uso',
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
