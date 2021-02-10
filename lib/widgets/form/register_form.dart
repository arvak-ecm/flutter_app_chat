import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../custom_button.dart';
import '../custom_input.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onPressed: () {
              print(this.nameCtrl.text);
              print(this.emailCtrl.text);
              print(this.passwordCtrl.text);
            },
          )
        ],
      ),
    );
  }
}
