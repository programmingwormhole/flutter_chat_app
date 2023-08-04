import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_chat/core/services/api_services.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  void sendResponse ({
    required String phone,
    required String password,
    required BuildContext context,
}) async {
    isLoading.value = true;
    await ApiServices().getLogin(phone: phone, password: password, context: context);
    isLoading.value = false;
    update();
  }
}