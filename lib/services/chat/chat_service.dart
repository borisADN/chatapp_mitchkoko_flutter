import 'package:chatapp/models/message.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final AuthService authService = AuthService();

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return fireStore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  void sendMessage(String receiverID, messageText) async {
    final senderId = authService.getCurrentUser()!.uid;
    final senderEmail = authService.getCurrentUser()!.email!;

    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderID: senderId,
      senderEmail: senderEmail,
      receiverId: receiverID,
      message: messageText,
      timestamp: timestamp,
    );

    List<String> ids = [senderId, receiverID];

    ids.sort();

    String chatRoomId = ids.join("_");

    await fireStore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
    // fireStore.collection('Messages').add({
    //   'senderEmail': senderEmail,
    //   'receiverEmail': receiverEmail,
    //   'message': message,
    // });

    //get Messages
    
  }

  Stream<QuerySnapshot> getMessages(String UserID, receiverID) {
      List<String> ids = [UserID, receiverID];

      ids.sort();

      String chatRoomId = ids.join("_");

      return fireStore
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots();
    }
}
