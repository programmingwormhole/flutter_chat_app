import 'package:get/get.dart';
import 'package:small_chat/controllers/auth_controller.dart';
import 'package:small_chat/controllers/chat_list_controller.dart';
import 'package:small_chat/controllers/send_message_controller.dart';
import 'package:small_chat/controllers/user_messages_controller.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ChatListController());
    Get.lazyPut(() => UserMessagesController());
    Get.lazyPut(() => SendMessageController());
  }

}