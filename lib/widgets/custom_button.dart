import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  const CustomButton({
    Key key,
    @required this.label,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        elevation: 2,
        highlightElevation: 5,
        color: Colors.blue,
        shape: StadiumBorder(),
        child: Container(
            height: 55,
            width: double.infinity,
            child: Center(
                child: Text(
              this.label,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ))),
        onPressed: this.onPressed
    );
  }
}
