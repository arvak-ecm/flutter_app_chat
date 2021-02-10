
import 'package:app_chat/widgets/form/register_form.dart';
import 'package:flutter/material.dart';

import 'package:app_chat/widgets/ScaffoldApp.dart';
import 'package:app_chat/widgets/logo_app.dart';
import 'package:app_chat/widgets/NavAuth.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppWidget(
      listWidget: [
        LogoAppWidget(title: 'Registro'),
        RegisterForm(),
        NavAuth(
          route: 'login',
          title: 'Ingresa ahora!',
          subTitle: '¿Ya tienes cuenta?',
        ),
        Text(
          'Términos y condiciones de uso',
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}