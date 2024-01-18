import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../pages/home_page.dart';
import '../theme/change_theme_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        padding: const EdgeInsets.symmetric( vertical: 25),
        children: [
          ListTile(
            minVerticalPadding: 25,
            title: const Text(
              "Home",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: const Icon(Icons.home, size: 25),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            minVerticalPadding: 25,
            title: const Text(
              "Change Theme",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: const Icon(Icons.brightness_6, size: 25),
            onTap: () {
              Provider.of<ChangeTheme>(context, listen: false).toggleTheme();
            },
          ),
          const ListTile(
            minVerticalPadding: 25,
            title: Text(
              "Change Language",
              style: TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
            leading: Icon(Icons.language, size: 25),
          ),
          ListTile(
            minVerticalPadding: 25,
            title: const Text(
              "Exit",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: const Icon(Icons.exit_to_app, size: 25),
            onTap: () {
              SystemNavigator.pop();
            },
          )
        ],
      ),
    );
  }
}
