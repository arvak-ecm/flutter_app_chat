import 'package:app_chat/config/config.dart';
import 'package:flutter/material.dart';

class ScaffoldAppWidget extends StatelessWidget {
  final List<Widget> chidren;
  const ScaffoldAppWidget({
    Key key,
    this.chidren
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConfigApp.bgColorApp,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
          physics: BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.95),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: this.chidren,
              ),
            ),
          ),
        ),
    );
  }
}