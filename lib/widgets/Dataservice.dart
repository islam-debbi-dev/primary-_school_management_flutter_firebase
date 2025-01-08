import 'package:cloud_firestore/cloud_firestore.dart';

import 'messageMOdel.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(Message message) async {
    await _db.collection('messages').add(message.toMap());
  }

  Stream<List<Message>> getMessages(String userId) {
    return _db
        .collection('messages')
        .where('receiverId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Message.fromMap(doc.data())).toList());
  }
}
