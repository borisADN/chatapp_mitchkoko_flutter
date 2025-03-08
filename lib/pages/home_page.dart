import 'package:chatapp/components/my_drawer.dart';
import 'package:chatapp/components/user_tile.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Colors.grey,
        elevation: 0,
        centerTitle: true,
        title: const Text("Home Page"),
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // return Text('Error: ${snapshot.error}');
          return Text('Erreur');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          // return Text('Loading...');
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 8,
            ),
          );
        }
        final List<Map<String, dynamic>>? users = snapshot.data;

        if (users == null || users.isEmpty) {
          return const Center(child: Text("Aucun utilisateur trouvé."));
        }
        print(users);
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverEmail: userData['email'],
                        receiverID: userData['uid'],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
