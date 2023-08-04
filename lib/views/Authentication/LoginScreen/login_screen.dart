// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:small_chat/components/snack_bar.dart';
import 'package:small_chat/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:small_chat/utils/strings.dart';
import 'package:small_chat/views/Authentication/LoginScreen/widgets/field_header_section.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../helper/custom_field.dart';
import '../../../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(AuthController());
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isSecured = true;

  // bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  '$imagePath/logo.png',
                  color: white,
                  width: 200,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: size.width * .9,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          fieldHeader(context),
                          customField(
                            controller: _phoneController,
                            topLabel: phone,
                            label: enterPhone,
                            leadingIcon: Icons.alternate_email,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          customField(
                              controller: _passwordController,
                              topLabel: password,
                              label: enterPass,
                              leadingIcon: Icons.password,
                              secured: isSecured,
                              trailingIcon: isSecured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTrailingTap: () {
                                setState(() {
                                  isSecured = !isSecured;
                                });
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  snackBar(
                                    context: context,
                                    message: somethingWrong,
                                    backgroundColor: Colors.red,
                                  );
                                },
                                child: const Text(
                                  forgetPass,
                                  style: TextStyle(
                                    color: primary,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => customButton(
                              isLoading: controller.isLoading.value,
                              context: context,
                              title: signInText,
                              backgroundColor: primary,
                              onTap: () async {
                                if (_phoneController.text.isEmpty ||
                                    _passwordController.text.isEmpty) {
                                  snackBar(
                                    context: context,
                                    message: validationErrorMsg,
                                    backgroundColor: Colors.red,
                                  );
                                } else {
                                  controller.sendResponse(
                                    phone: _phoneController.text,
                                    password: _passwordController.text,
                                    context: context,
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
