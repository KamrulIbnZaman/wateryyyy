import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/about_screen.dart';
import '../screen/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  Color backColor;
  AppDrawer(this.backColor);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Happy Shop'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('About'),
            onTap: () {
              Navigator.of(context).pushNamed(AboutScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
