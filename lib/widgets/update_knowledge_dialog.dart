import 'package:chat_document/utils/colors.dart';
import 'package:chat_document/utils/widgets.dart';
import 'package:chat_document/widgets/common_button.dart';
import 'package:chat_document/widgets/common_input.dart';
import 'package:flutter/material.dart';

import '../models/bot.dart';

class UpdateKnowledgeDialog extends StatefulWidget {
  final String name;
  final String description;
  final bool isCreate;
  final Function(String, String) onPress;

  UpdateKnowledgeDialog(
      {required this.onPress,
      required this.name,
      required this.description,
      required this.isCreate});

  @override
  _UpdateKnowledgeDialogState createState() => _UpdateKnowledgeDialogState();
}

class _UpdateKnowledgeDialogState extends State<UpdateKnowledgeDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name ?? '';
    _descriptionController.text = widget.description ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text(
        widget.isCreate ? "Tạo kiến thức" : 'Cập nhật kiến thức',
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.black),
      ),
      content: SizedBox(
        width: deviceSize.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Tên kiến thức",
                hintStyle: const TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.lightGrey,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                      color: AppColors.primaryColor, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
            BoxEmpty.sizeBox10,
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Mô tả kiến thức",
                hintStyle: const TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.lightGrey,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                      color: AppColors.primaryColor, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        CommonButton(
            title: widget.isCreate ? "Tạo" : 'Cập nhật',
            onPress: () {
              widget.onPress(
                _nameController.text,
                _descriptionController.text,
              );
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
