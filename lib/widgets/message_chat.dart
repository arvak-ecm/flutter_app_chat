import 'package:app_chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageChat extends StatelessWidget {
  final String text;
  final String uid;
  final AnimationController animationController;

  MessageChat(
      {Key key,
      @required this.text,
      @required this.uid,
      @required this.animationController})
      : super(key: key);

  final BorderRadius _boderRadiusBox = BorderRadius.circular(12.0);
  final EdgeInsets _paddingBox = EdgeInsets.all(10.0);
  final Color _backgroundBox1 = Colors.blue[400];
  final Color _backgroundBox2 = Colors.purple[50];
  final TextStyle _style1 = TextStyle(color: Colors.white);
  final TextStyle _style2 = TextStyle(color: Colors.purple[800]);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return FadeTransition(
        opacity: this.animationController,
        child: SizeTransition(
          sizeFactor: CurvedAnimation(
              parent: this.animationController, curve: Curves.easeInOut),
          child: Container(
              child: this.uid == authService.user.uid ? _myMessage() : _otherMessage()),
        ));
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(right: 5.0, bottom: 5.0, left: 50.0),
        decoration: BoxDecoration(
            color: _backgroundBox1, borderRadius: _boderRadiusBox),
        padding: _paddingBox,
        child: Text(this.text, style: _style1),
      ),
    );
  }

  Widget _otherMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 5.0, bottom: 5.0, right: 50.0),
        decoration: BoxDecoration(
            color: _backgroundBox2, borderRadius: _boderRadiusBox),
        padding: _paddingBox,
        child: Text(
          this.text,
          style: _style2,
        ),
      ),
    );
  }
}
