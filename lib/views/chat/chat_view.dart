import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tours_booking/services/sms_services/get_current_user_sms.dart';

import '../../constants/app_colors.dart';
import '../../controllers/chat_controller.dart';
import '../../models/messages_model.dart';
import '../../widgets/app_text.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;

  const ChatScreen({
    super.key,
    required this.receiverId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GetCurrentUserSms _currentUserSms = GetCurrentUserSms();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ChatController>(
        init: ChatController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 50,
              elevation: 0,
              backgroundColor: AppColors.primarycolor.withOpacity(0.4),
              centerTitle: true,
              title: const AppText(
                text: "John Doe",
                fontWeight: FontWeight.w700,
              ),
              leading: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.primarycolor,
                  backgroundImage: AssetImage("assets/account.png"),
                ),
              ),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 65),
                  child: SingleChildScrollView(
                    child: StreamBuilder<List<MessagesModel>>(
                      stream: _currentUserSms.getAllMessages(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: List.generate(
                              snapshot.data!.length,
                              (index) => BubbleNormal(
                                text: snapshot.data![index].message.toString(),
                                isSender: snapshot.data![index].senderId ==
                                    FirebaseAuth.instance.currentUser!.uid,
                                color: snapshot.data![index].senderId ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? AppColors.primarycolor
                                    : AppColors.headTextColor,
                              ),
                            ),
                          );
                        } else if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: AppText(
                              text: "NO data available!",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
                MessageBar(
                  onSend: (msg) async {
                    await controller.sendMessage(msg, widget.receiverId);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
