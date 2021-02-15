import 'package:app_chat/widgets/dialog_custom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:app_chat/services/auth_service.dart';

import '../custom_button.dart';
import '../custom_input.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            CustomInput(
                icon: FontAwesomeIcons.lightUser,
                keyboardType: TextInputType.emailAddress,
                placeholder: 'Ingrese su usuario',
                textController: emailCtrl),
            CustomInput(
              icon: FontAwesomeIcons.lightLockAlt,
              placeholder: 'Ingrese su contraseña',
              textController: passwordCtrl,
              isPassword: true,
            ),
            CustomButton(
                label: 'Ingresar',
                onPressed: authService.isAuth
                    ? null
                    : () async {
                        if (_formKey.currentState.validate()) {
                          FocusScope.of(context).unfocus();

                          final login = await authService.login(
                              this.emailCtrl.text.trim(),
                              this.passwordCtrl.text.trim());

                          if (login) {
                            //socketService.connect();
                            Navigator.pushReplacementNamed(context, 'contacts');
                          } else {
                            dialogCustom(context, 'Login incorrecto',
                                'revise sus credenciales');
                          }
                        }
                      })
          ],
        ),
      ),
    );
  }
}
