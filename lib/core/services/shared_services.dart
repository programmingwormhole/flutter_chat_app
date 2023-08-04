import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:small_chat/components/navigate.dart';
import 'package:small_chat/views/Authentication/LoginScreen/login_screen.dart';

class SharedServices {
  Future<bool> checkLogin () async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    if(token == null){
      return false;
    } else {
      if (kDebugMode) {
        print(token);
      }
      return true;
    }
  }

  Future<void> logOut (context) async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('token');
    removeNavigate(context, const LoginScreen());
  }
}