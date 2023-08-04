// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:small_chat/components/snack_bar.dart';
import 'package:small_chat/models/messages_model.dart';
import '../../components/navigate.dart';
import '../../models/chat_list_model.dart';
import '../../utils/config.dart';
import '../../utils/strings.dart';
import '../../views/HomeScreen/home_screen.dart';

class ApiServices {
  Future<bool> getLogin({
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    final response = await http.post(Uri.parse('$apiUrl/login'), body: {
      'phone': phone,
      'password': password,
    });
    if (response.statusCode == 200) {
      final pref = await SharedPreferences.getInstance();
      final decode = jsonDecode(response.body);
      pref.setString('token', decode['data']['token']);
      pref.setString('id', decode['data']['user']['id'].toString());
      removeNavigate(context, const HomeScreen());
      return true;
    } else {
      final decode = jsonDecode(response.body);
      snackBar(
        backgroundColor: Colors.red,
        context: context,
        message: decode['message'] == 'validation.min.string'
            ? passValidation
            : decode['message'],
      );
      return false;
    }
  }

  Future<ChatListModel?> getChatList() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    final response = await http.get(Uri.parse('$apiUrl/chat-list'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return chatListModelFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<MessagesModel?> getUserMessages({required String userID}) async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    final response = await http.get(
        Uri.parse('$apiUrl/sms-history?to_user=$userID'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return messagesModelFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> sendMessage({required String userID, required String message}) async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    final response = await http.post(
      Uri.parse('$apiUrl/send-sms'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'to_user' : userID,
        'message' : message,
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
