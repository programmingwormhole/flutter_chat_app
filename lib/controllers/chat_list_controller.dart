import 'package:get/get.dart';
import 'package:small_chat/core/services/api_services.dart';
import 'package:small_chat/models/chat_list_model.dart';

class ChatListController extends GetxController {
  var isLoading = false.obs;
  var chatData = ChatListModel().data.obs;

  @override
  onInit() {
    super.onInit();
    getData();
  }

  getData () async {
    isLoading.value = true;
    final data = await ApiServices().getChatList();
    chatData.value = data!.data;
    isLoading.value = false;
    update();
    chatData.refresh();
  }

}