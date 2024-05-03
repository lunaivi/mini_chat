import 'package:chat_minits/componet/chat_bubble.dart';
import 'package:chat_minits/componet/my_textfield.dart';
import 'package:chat_minits/service/auth/auth_service.dart';
import 'package:chat_minits/service/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

  //constructor
  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
//text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & aut serivces
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  // for textfiel focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //add listener to focus nade
    myFocusNode.addListener(() {
      //  cause de delay so that the keyboard has time to show up
      //  then the amount of remaining space will be calculated,
      //  then scroll down
      Future.delayed(
        const Duration(milliseconds: 500),
        () => Scaffold(),
      );
    });
  }

  @override
  void dispose() {
    //TODO: implement dispone
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //  scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDowd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

//send message
  void sendMessage() async {
    // if there is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      // send the message
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);
      // clear text controller
      _messageController.clear();
    }
  }

  //build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.,
        title: Text(widget.receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(
            child: _buildMessageList(),
          ),
          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverID, senderID),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // loanding
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // return list view
        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

//buil message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    //align message to the righ if sender is the current user, otherwise left

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data["message"],
            isCurrentUser: isCurrentUser,
          )
        ],
      ),
    );
  }

  //buil message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          //textfield should take up most of the space
          Expanded(
              child: MyTextField(
            controller: _messageController,
            text: 'Type message',
            obscuretext: false,
            focusNade: myFocusNode,
          )),
          //send button
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration:
                BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(Icons.arrow_upward, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
