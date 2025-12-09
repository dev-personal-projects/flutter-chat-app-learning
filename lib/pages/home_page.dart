import 'package:chatapp/auth/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  //sign out method
  void logout() async {
    await AuthService().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () async {
              logout();
              // Navigation will be handled by AuthGate
            },
            icon: Icon(Icons.logout,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.tertiary),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: Center(
          child: Text('Welcome to the Home Page',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold))),
    );
  }
}
