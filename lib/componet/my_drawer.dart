import 'package:chat_minits/pages/settings_page.dart';
import 'package:chat_minits/service/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout() {
    //get auth service
    final _auth = AuthService();

    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // logo
              const DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
              ),
// home  list tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text('H O M E'),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),
//settings list tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text(' S E T T I N GS'),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                ),
              ),
            ],
          ),
//logout list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              title: const Text('L O G O U T'),
              leading: const Icon(Icons.logout_outlined),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
