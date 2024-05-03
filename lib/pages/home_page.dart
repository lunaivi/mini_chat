import 'package:chat_minits/componet/my_drawer.dart';
import 'package:chat_minits/componet/user_tile.dart';
import 'package:chat_minits/pages/chat_page.dart';
import 'package:chat_minits/service/auth/auth_service.dart';
import 'package:chat_minits/service/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

//chat & auth service
  final ChatService _chatServece = ChatService();

  final AuthService _authService = AuthService();
  void logout() {
    //get auth service
    final _auth = AuthService();

    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServece.getUsersStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("erro");
        }
        //loading.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        //return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

//build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user

    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: UserTile(
          text: userData["email"],
          onTap: () {
            //tapped on a user -> go to chat page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData["email"],
                  receiverID: userData["uid"],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
