import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final double marginBottom;

  const CustomInput(
      {Key key,
      @required this.icon,
      @required this.placeholder,
      @required this.textController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.marginBottom = 20.0
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: this.marginBottom),
      padding: EdgeInsets.only(top: 3, left: 15, bottom: 3, right: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextFormField(
        controller: this.textController,
        obscureText: this.isPassword,
        autocorrect: false,
        keyboardType: this.keyboardType,
        validator: (value) {
          if (value.isEmpty) {
            return '        Por favor debe ingresar un valor';
          }
            return null;
        },
        decoration: InputDecoration(
          prefixIconConstraints: BoxConstraints(
            minHeight: 32,
            minWidth: 32,
          ),
          prefixIcon: Icon(this.icon,size: 22.0,),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeholder),
      ),
    );
  }
}
