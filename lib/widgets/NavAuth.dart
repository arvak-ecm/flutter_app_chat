import 'package:flutter/material.dart';
import 'package:app_chat/config/config.dart';

class NavAuth extends StatelessWidget {
  final String route;
  final String title;
  final String subTitle;

  const NavAuth({
    Key key,
    @required this.route,
    @required this.title,
    @required this.subTitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.subTitle,
            style: ConfigApp.stSubTitle,
          ),
          SizedBox(height: 10),
          GestureDetector(
            child: Text(
              this.title,
              style: ConfigApp.stTitle,
            ),
            onTap: () => Navigator.pushReplacementNamed(context, this.route),
          ),
        ],
      ),
    );
  }
}
