import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:app_chat/services/auth_service.dart';

import '../custom_button.dart';
import '../custom_input.dart';
import '../dialog_custom.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
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
                placeholder: 'Nombre',
                textController: nameCtrl),
            CustomInput(
                icon: FontAwesomeIcons.lightEnvelope,
                keyboardType: TextInputType.emailAddress,
                placeholder: 'Correo',
                textController: emailCtrl),
            CustomInput(
              icon: FontAwesomeIcons.lightLockAlt,
              placeholder: 'Contraseña',
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

                        final register = await authService.register(
                            this.nameCtrl.text.trim(),
                            this.emailCtrl.text.trim(),
                            this.passwordCtrl.text.trim());

                        if (register) {
                          Navigator.pushReplacementNamed(context, 'contacts');
                        } else {
                          dialogCustom(context, 'Registro incorrecto',
                              'revise sus datos');
                        }
                      }
                    },
            )
          ],
        ),
      ),
    );
  }
}
