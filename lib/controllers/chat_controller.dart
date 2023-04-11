import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tours_booking/services/sms_services/send_message_service.dart';

class ChatController extends GetxController {
  final SendMessageService _sendMessage = SendMessageService();
  bool isLoading = false;
  sendMessage(String msg, String receiverId, String bookingId) async {
    isLoading = true;
    update();
    await _sendMessage.sendMessageService(
      bookingId: bookingId,
      message: msg,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      receiverId: receiverId,
    );
    isLoading = false;
    update();
  }
}
