import 'package:app_chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:app_chat/widgets/ScaffoldApp.dart';
import 'package:app_chat/models/user.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final contacts = [
    User(
        uid: '1',
        name: 'Aymara Martinez',
        email: 'am@gmail.com',
        isOnline: true),
    User(
        uid: '2',
        name: 'Eduardo Cardoso',
        email: 'ec@gmail.com',
        isOnline: true),
    User(
        uid: '3',
        name: 'Pedro la casa',
        email: 'pc@gmail.com',
        isOnline: false),
    User(
        uid: '4',
        name: 'leonardo Cardoso',
        email: 'lc@gmail.com',
        isOnline: true),
    User(
        uid: '5', name: 'Haydee Martin', email: 'hm@gmail.com', isOnline: false)
  ];

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
        title: Text(contacts[i].name),
        leading: CircleAvatar(
          child: Text(contacts[i].name.substring(0, 2)),
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: contacts[i].isOnline ? Colors.green[400] : Colors.red[400],
              borderRadius: BorderRadius.circular(100)),
        ),
      ),
      separatorBuilder: (_, i) => Divider(),
      itemCount: contacts.length,
    );
  }

  void _getContacts() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
