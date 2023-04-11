import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/messages_model.dart';

class GetCurrentUserSms {
  Stream<List<MessagesModel>> getAllMessages({
    required String receiverId,
    required String bookingId,
  }) {
    var list = FirebaseFirestore.instance
        .collection("booking")
        .doc(bookingId)
        .collection('messages')
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
