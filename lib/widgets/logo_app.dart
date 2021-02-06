import 'package:flutter/material.dart';

class LogoAppWidget extends StatelessWidget {
  final String title;

  const LogoAppWidget({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 20.0),
        width: 170,
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/png/tag-logo.png'),
            ),
            SizedBox(height: 10),
            Text(
              this.title,
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
