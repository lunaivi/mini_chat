import 'package:chat_minits/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
// get instance of firestoe & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
//obtener flujo de usuarios
/*List<Map<String, dynamic>> =
[
{
'email': test@gmail.com,
'id': ..
}
{
'email': mitch@gmail.com,
'id': ..'
}]
 */
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through eah individual user
        final user = doc.data();

        // return user
        return user;
      }).toList();
    });
  }

//enviar mensaje
  Future<void> sendMessage(String receiverID, message) async {
    // get current user
    final String currenUserID = _auth.currentUser!.uid;
    final String currenUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    // create a new message
    Message newMessage = Message(
      senderID: currenUserID,
      senderEmail: currenUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room ID for the two users  (sorted to ensure uniqueness)
    List<String> ids = [currenUserID, receiverID];
    ids.sort(); // sort the ids (this. ensure the chatroomID is the same for any 2 people)
    final String chatRoomID = ids.join("_");
    // add new message to database
    await _firestore
        .collection("chatRooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

// recibir mensajes
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    // construct a chat room ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    final String chatRoomID = ids.join("_");

    // return collection
    return _firestore
        .collection("chatRooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp")
        .snapshots();
  }
}
