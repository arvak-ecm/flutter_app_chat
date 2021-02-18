import 'dart:io';
import 'package:app_chat/models/message.dart';
import 'package:app_chat/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_chat/widgets/ScaffoldApp.dart';
import 'package:app_chat/widgets/message_chat.dart';
import 'package:provider/provider.dart';

import 'package:app_chat/services/chat_service.dart';
import 'package:app_chat/services/socket_service.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  ChatService chatService;
  SocketService socketService;
  AuthService authService;

  List<MessageChat> _messages = [];

  bool _isWriting = false;

  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this.socketService.socket.on('person-msg', _listenMsg);

    _getHistoryMessages(this.chatService.userTo.uid);
  }

  void _listenMsg(payload) {
    MessageChat msg = new MessageChat(
      text: payload['msg'],
      uid: payload['from'],
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 300)),
    );

    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userTo = this.chatService.userTo;

    return ScaffoldAppWidget(
      appBar: true,
      title: userTo.name,
      widget: Container(
        child: Column(
          children: [
            _body(),
            Divider(
              height: 1,
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Flexible(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        reverse: true,
        itemBuilder: (_, i) => _messages[i],
        itemCount: _messages.length,
      ),
    );
  }

  Widget _footer() {
    return Container(
      height: 100.0,
      color: Colors.white,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [_inputText(), _buttonSend()],
          ),
        ),
      ),
    );
  }

  Widget _inputText() {
    return Flexible(
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration.collapsed(hintText: 'Enviar Mensaje'),
        focusNode: this._focusNode,
        controller: this._textController,
        onSubmitted: _handleSubmit,
        onChanged: (String text) {
          setState(() {
            if (text.trim().length > 0) {
              this._isWriting = true;
            } else {
              this._isWriting = false;
            }
          });
        },
      ),
    );
  }

  Widget _buttonSend() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        child: !Platform.isIOS
            ? CupertinoButton(
                child: Text('Enviar'),
                onPressed: this._isWriting
                    ? () => _handleSubmit(_textController.text.trim())
                    : null,
              )
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[400]),
                  child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: this._isWriting
                          ? () => _handleSubmit(_textController.text.trim())
                          : null),
                ),
              ));
  }

  _handleSubmit(String text) {
    if (text.length > 0) {
      MessageChat msg = MessageChat(
        uid: authService.user.uid,
        text: text,
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 400)),
      );
      _messages.insert(0, msg);
      msg.animationController.forward();

      this._textController.clear();
      this._focusNode.requestFocus();

      setState(() {
        this._isWriting = false;
      });

      this.socketService.emit('person-msg', {
        'from': this.authService.user.uid,
        'to': this.chatService.userTo.uid,
        'msg': text
      });
    }
  }

  @override
  void dispose() {
    for (MessageChat msg in _messages) {
      msg.animationController.dispose();
    }

    this.socketService.socket.off('person-msg');
    super.dispose();
  }

  void _getHistoryMessages(String uid) async {
    List<Message> chat = await this.chatService.getHistoryMessage(uid);

    final history = chat.map((m) => new MessageChat(
          uid: m.from,
          text: m.msg,
          animationController: AnimationController(
              vsync: this, duration: Duration(milliseconds: 400))
            ..forward(),
        ));

    setState(() {
      _messages.insertAll(0, history);
    });
  }
}
