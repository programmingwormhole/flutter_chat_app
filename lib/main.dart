import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:small_chat/bindings/all_bindings.dart';
import 'package:small_chat/views/SplashScreen/splash_screen.dart';

void main() {
  runApp(const MyApp());
  AllBindings().dependencies();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}