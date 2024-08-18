import '../utils/colors.dart';
import 'package:flutter/material.dart';

class CommonInput extends StatelessWidget {
  const CommonInput(
      {super.key, required this.controller, required this.hinText, this.icon});
  final TextEditingController controller;
  final String? hinText;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.transparent,
          width: 1.0,
        ),
        color: AppColors.lightGrey,
      ),
      // height: 45,
      child: Center(
        child: TextField(
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hintText: hinText, // Placeholder
            border: InputBorder.none,
            // prefixIcon: Icon(Icons.email_rounded),
            prefixIcon: Icon(icon),
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          ),
          controller: controller,
        ),
      ),
    );
  }
}
