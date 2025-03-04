import 'package:chatapp/auth/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  void logout() {
    final authService = AuthService();

    authService.signOut();
  }

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 8,
        centerTitle: true,
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text("Bienvenue sur la page d'accueil !"),
      ),
    );
  }
}
