import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tours_booking/services/get_user_data.dart';
import 'package:tours_booking/services/sms_services/get_current_user_sms.dart';
import 'package:tours_booking/widgets/app_cache_image.dart';

import '../../constants/app_colors.dart';
import '../../controllers/chat_controller.dart';
import '../../models/messages_model.dart';
import '../../widgets/app_text.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String bookingId;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.bookingId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GetCurrentUserSms _currentUserSms = GetCurrentUserSms();
  final GetUserData _userData = GetUserData();
  bool isLoading = false;
  getUserData() async {
    setState(() {
      isLoading = true;
    });
    await _userData.getUserData(widget.receiverId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

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
              title: isLoading
                  ? const CircularProgressIndicator()
                  : AppText(
                      text: _userData.userProfile.userName!,
                      fontWeight: FontWeight.w700,
                    ),
              leading: isLoading
                  ? const CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: AppCircularCachedImage(
                        picRadius: 20,
                        picUrl: _userData.userProfile.profile!,
                      ),
                    ),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 65),
                  child: SingleChildScrollView(
                    child: StreamBuilder<List<MessagesModel>>(
                      stream: _currentUserSms.getAllMessages(
                        bookingId: widget.bookingId,
                        receiverId: widget.receiverId,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: List.generate(
                              snapshot.data!.length,
                              (index) => BubbleNormal(
                                textStyle:
                                    GoogleFonts.poppins(color: Colors.white),
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
                        } else if (snapshot.data == null) {
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
                    await controller.sendMessage(
                        msg, widget.receiverId, widget.bookingId);
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
