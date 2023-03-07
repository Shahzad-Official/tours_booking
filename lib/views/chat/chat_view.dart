import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/chat_controller.dart';
import '../../widgets/app_text.dart';

class ChatScreen extends StatelessWidget {
  final String? receiverId;
  const ChatScreen({
    super.key,
    this.receiverId,
  });

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
              title: AppText(
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
                    child: Column(
                      children: List.generate(
                        controller.allMessages.length,
                        (index) => BubbleNormal(
                          text: controller.allMessages[index],
                          isSender: index.isEven,
                          color: index.isEven
                              ? AppColors.primarycolor
                              : AppColors.headTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                MessageBar(
                  onSend: (msg) {
                    controller.sendMessage(msg);
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
