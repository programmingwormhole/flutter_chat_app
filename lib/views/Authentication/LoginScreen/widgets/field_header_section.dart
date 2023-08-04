import 'package:flutter/material.dart';

import '../../../../components/snack_bar.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/config.dart';
import '../../../../utils/strings.dart';
Widget fieldHeader(BuildContext context) {
  return Column(
    children: [
      const Text(
        '$welcomeTo $appName',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            notHaveAcc,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              snackBar(
                context: context,
                message: somethingWrong,
                backgroundColor: Colors.red,
              );
            },
            child: const Text(
              signUp,
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Divider(
        color: black.withOpacity(.1),
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}