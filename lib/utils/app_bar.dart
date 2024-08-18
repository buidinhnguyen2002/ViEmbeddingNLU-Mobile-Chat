import '/utils/colors.dart';
import '/utils/constants.dart';
import '/utils/functions.dart';
import '/utils/widgets.dart';
import 'package:flutter/material.dart';

AppBar mainAppBar(
    BuildContext context, String title, String urlImage, Widget action) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.background,
    leading: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Image.asset(urlImage),
    ),
    leadingWidth: 50,
    titleSpacing: 15,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        foreground: Paint()
          ..shader = const LinearGradient(
            colors: <Color>[
              Color(0xFFA359FF), // Màu #A359FF
              Color(0xFF00CBFF),
            ],
          ).createShader(
            const Rect.fromLTWH(0, 0, 200, 70),
          ),
      ),
    ),
    actions: [
      action,
      BoxEmpty.sizeBox10,
    ],
  );
}
