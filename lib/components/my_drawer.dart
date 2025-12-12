import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/auth/login_or_register.dart';
import 'package:chatapp/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  //sign out method
  void logout(BuildContext context) async {
    //show a loading indicator
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    await AuthService().signOut();
    // Check if context is still valid before using it
    if (!context.mounted) return;
    //pop the loading indicator
    Navigator.pop(context);
    // Check again before navigation
    if (!context.mounted) return;
    //navigate to login page
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LoginOrRegister()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top section: Header, Home, and Settings
          Column(
            children: [
              //logo
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                child: Center(
                  child: Icon(
                    Icons.message,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),

              //home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  //pop the drawer
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              //settings list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  //navigate to settings page
                  onTap: () {
                    // Close drawer first
                    Navigator.pop(context);
                    // Then navigate to settings page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()));
                  },
                ),
              ),
            ],
          ),

          // Bottom section: Logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.primary,
              ),
              //sign out
              onTap: () {
                logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
