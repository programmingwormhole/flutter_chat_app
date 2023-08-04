import 'package:flutter/material.dart';

import '../utils/colors.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    {required BuildContext context, required String message, Color? backgroundColor}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(
          seconds: 2
      ),
      backgroundColor: backgroundColor ?? primary,
      content: Text(message),
    ),
  );
}
