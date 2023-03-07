import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  List<String> allMessages = [
    "hello",
    "how are you",
    "i'm fine ",
    "me also fine",
    "what are you doing?",
    "Coding",
  ];
  sendMessage(String msg) {
    allMessages.add(msg);
    update();
  }
}
