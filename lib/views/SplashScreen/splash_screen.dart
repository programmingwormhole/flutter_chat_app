// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:small_chat/components/navigate.dart';
import 'package:small_chat/core/services/shared_services.dart';
import 'package:small_chat/views/Authentication/LoginScreen/login_screen.dart';
import 'package:small_chat/views/HomeScreen/home_screen.dart';
import '../../utils/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  checkLogin () async {
    final isLoggedIn = await SharedServices().checkLogin();
    if(isLoggedIn){
      removeNavigate(context, const HomeScreen());
    } else {
      removeNavigate(context, const LoginScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          '$imagePath/logo.png',
          width: 200,
        ),
      ),
    );
  }
}
