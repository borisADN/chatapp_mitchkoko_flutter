import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  void logout() {
    final authService = AuthService();

    authService.signOut();
  }

  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            DrawerHeader(
                child: Center(
                    child: Icon(Icons.message,
                        size: 50,
                        color: Theme.of(context).colorScheme.primary))),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: ListTile(
                title: const Text("A C C U E I L "),
                leading: const Icon(Icons.home),
                onTap: () {
                  // pop the drawer
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: ListTile(
                title: const Text("P A R A M E T R E S"),
                leading: const Icon(Icons.settings),
                onTap: () {
                  // pop the drawer
                  Navigator.pop(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ));
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, bottom: 25),
          child: ListTile(
            title: const Text("D E C O N N E X I O N"),
            leading: const Icon(Icons.logout),
            onTap: () => logout(),
            // onTap: () => Navigator.pushNamed(context, '/home'),
          ),
        )
      ]),
    );
  }
}
