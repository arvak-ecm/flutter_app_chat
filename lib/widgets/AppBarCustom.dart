import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:app_chat/services/auth_service.dart';
import 'package:app_chat/services/socket_service.dart';


class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarCustom({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return AppBar(
      elevation: 1,
      title: Text(
        this.title,
        style: TextStyle(color: Colors.blue[400]),
      ),
      backgroundColor: Colors.white,
      leading: (socketService.serverStatus == ServerStatus.Online )
        ? Icon( FontAwesomeIcons.lightWifi, size: 14, color: Colors.green[400], )
        : Icon( FontAwesomeIcons.lightWifiSlash, size: 14, color: Colors.red[400], ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: _menu(context)
        )
      ],
    );
  }

  Widget _menu(BuildContext context) {
    // String dropdownValue = 'One';
    final socketService = Provider.of<SocketService>(context);
    return Container(
      padding: EdgeInsets.only(top: 3.5),
      child: DropdownButton<String>(
        icon: Icon(FontAwesomeIcons.lightEllipsisV),
        iconSize: 24,
        elevation: 1,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(height: 0),
        onChanged: (String newValue) {
          switch (newValue) {
            case 'Salir':
              AuthService.deleteToken();
              socketService.disconnect();
              Navigator.pushReplacementNamed(context, 'login');
              break;
          }
          // dropdownValue = newValue;
        },
        items: <String>['Salir'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Icon(FontAwesomeIcons.lightSignOut),
                SizedBox(
                  width: 10,
                ),
                Text(value)
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(60.0);
}
