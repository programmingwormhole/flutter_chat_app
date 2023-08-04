import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_chat/controllers/user_messages_controller.dart';
import 'package:small_chat/core/services/api_services.dart';

class SendMessageController extends GetxController {
  var isLoading = false.obs;
  var messageStatus = false.obs;
  var messageController = Get.put(UserMessagesController());
  final messageDataController = TextEditingController();

  sendResponse({required String userID, required String message}) async {
    isLoading.value = true;
    messageStatus.value = false;
    await ApiServices()
        .sendMessage(userID: userID, message: messageDataController.text)
        .then(
      (value) {
        messageController.getData(userID: userID);
        messageDataController.clear();
      },
    );
    isLoading.value = false;
    messageStatus.value = true;
    update();
    messageStatus.refresh();
  }
}
