import 'package:flutter/material.dart';

import 'package:app_chat/config/config.dart';
import 'package:app_chat/widgets/AppBarCustom.dart';

class ScaffoldAppWidget extends StatelessWidget {
  final List<Widget> listWidget;
  final Widget widget;
  final bool appBar;
  final String title;

  const ScaffoldAppWidget({
    Key key,
    this.listWidget,
    this.widget,
    this.appBar,
    this.title,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (this.appBar) ? AppBarCustom(title: this.title,) : null,
      backgroundColor: ConfigApp.bgColorApp,
      body: (listWidget != null)
          ? SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
              physics: BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.95),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: this.listWidget,
                  ),
                ),
              ),
            )
          : this.widget,
    );
  }
}
