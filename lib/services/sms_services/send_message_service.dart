import 'package:cloud_firestore/cloud_firestore.dart';

class SendMessageService {
  sendMessageService({
    required String message,
    required String senderId,
    required String receiverId,
    required String bookingId,
  }) async {
    await FirebaseFirestore.instance
        .collection("booking")
        .doc(bookingId)
        .collection("messages")
        .add(
      {
        "message": message,
        "senderId": senderId,
        "receiverId": receiverId,
        "id": "",
        "sendTime": DateTime.now().toUtc(),
      },
    ).then(
      (value) async {
        await FirebaseFirestore.instance
            .collection("booking")
            .doc(bookingId)
            .collection("messages")
            .doc(value.id)
            .update(
          {"id": value.id},
        );
      },
    );
  }
}
