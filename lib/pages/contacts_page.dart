import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:app_chat/services/auth_service.dart';
import 'package:app_chat/services/socket_service.dart';
import 'package:app_chat/services/chat_service.dart';
import 'package:app_chat/services/users_service.dart';

import 'package:app_chat/widgets/ScaffoldApp.dart';
import 'package:app_chat/models/user.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final userService = new UsersService();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<User> listMyContacts = [];

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.connectInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.user;

    return ScaffoldAppWidget(
        appBar: true,
        title: user.name,
        widget: SmartRefresher(
          onRefresh: _getContacts,
          controller: _refreshController,
          enablePullDown: true,
          child: _listContacts(context),
          header: WaterDropHeader(
            complete: Icon(FontAwesomeIcons.lightCheck),
            waterDropColor: Colors.blue[400],
          ),
        ));
  }

  _listContacts(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, i) => ListTile(
        title: Text(listMyContacts[i].name),
        leading: CircleAvatar(
          child: Text(listMyContacts[i].name.substring(0, 2)),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: listMyContacts[i].isOnline
                  ? Colors.green[400]
                  : Colors.red[400],
              borderRadius: BorderRadius.circular(100)),
        ),
        onTap: () {
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.userTo = listMyContacts[i];
          Navigator.pushNamed(context, 'chat');
          print(listMyContacts[i].uid);
        },
      ),
      separatorBuilder: (_, i) => Divider(),
      itemCount: listMyContacts.length,
    );
  }

  void _getContacts() async {
    this.listMyContacts = await userService.listUsers();
    setState(() {});

    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
