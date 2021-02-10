import 'package:app_chat/models/contacts.dart';
import 'package:app_chat/widgets/ScaffoldApp.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final contacts = [
    Contact( uid: '1', name: 'Aymara Martinez', mail: 'am@gmail.com', isOnline: true),
    Contact( uid: '2', name: 'Eduardo Cardoso', mail: 'ec@gmail.com', isOnline: true),
    Contact( uid: '3', name: 'Pedro la casa', mail: 'pc@gmail.com', isOnline: false),
    Contact( uid: '4', name: 'leonardo Cardoso', mail: 'lc@gmail.com', isOnline: true),
    Contact( uid: '5', name: 'Haydee Martin', mail: 'hm@gmail.com', isOnline: false)
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldAppWidget(
      appBar: true,
      widget: SmartRefresher(
        onRefresh: _getContacts,
        controller: _refreshController,
        enablePullDown: true,
        child: _listContacts(context),
        header: WaterDropHeader(
          complete: Icon(FontAwesomeIcons.lightCheck),
          waterDropColor: Colors.blue[400],
        ),
      )
    );
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
            borderRadius: BorderRadius.circular(100)
          ),
        ),
      ),
      separatorBuilder: (_, i) => Divider(),
      itemCount: contacts.length,
    );
  }

    _getContacts() async {

    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

  }
}
