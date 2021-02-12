import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarCustom({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      elevation: 1,
      title: Text(
        this.title,
        style: TextStyle(color: Colors.blue[400]),
      ),
      backgroundColor: Colors.white,
      leading: Icon(
        FontAwesomeIcons.lightWifi,
        size: 14,
        color: Colors.green[400],
      ),
      actions: [
        Container(margin: EdgeInsets.only(right: 20), child: _menu()
            // Icon(FontAwesomeIcons.lightWifiSlash, color: Colors.red[400]),
            // Icon(FontAwesomeIcons.lightWifi, color: Colors.blue[400])
            )
      ],
    );
  }

  Widget _menu() {
    // String dropdownValue = 'One';
    return Container(
      padding: EdgeInsets.only(top: 3.5),
      child: DropdownButton<String>(
        icon: Icon(FontAwesomeIcons.lightEllipsisV),
        iconSize: 24,
        elevation: 1,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(height: 0),
        onChanged: (String newValue) {
          print(newValue);
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
