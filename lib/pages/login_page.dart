import 'package:app_chat/widgets/NavAuth.dart';
import 'package:app_chat/widgets/ScaffoldApp.dart';
import 'package:flutter/material.dart';

import 'package:app_chat/config/config.dart';

import 'package:app_chat/widgets/logo_app.dart';
import 'package:app_chat/widgets/form/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldAppWidget(
      chidren: [
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

  Widget _labels(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            '¿No tienes cuenta?',
            style: ConfigApp.stSubTitle,
          ),
          SizedBox(height: 10),
          GestureDetector(
            child: Text(
              'Crea una ahora!',
              style: ConfigApp.stTitle,
            ),
            onTap: () => Navigator.pushReplacementNamed(context, 'register'),
          ),
        ],
      ),
    );
  }
}
