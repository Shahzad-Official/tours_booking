import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/messages_model.dart';

class GetCurrentUserSms {
  Stream<List<MessagesModel>> getAllMessages() {
    var list = FirebaseFirestore.instance
        .collection('messages')
        .where("senderId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("sendTime")
        .snapshots()
        .map(
          (snapShot) => snapShot.docs
              .map(
                (document) => MessagesModel.fromJson(
                  document.data(),
                ),
              )
              .toList(),
        );

    return list;
  }
}
