import 'dart:io';

import 'package:chat_document/providers/knowledge_provider.dart';
import 'package:chat_document/utils/app_bar.dart';
import 'package:chat_document/utils/constants.dart';
import 'package:chat_document/widgets/file_item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/functions.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({super.key});
  static const routeName = '/files-screen';

  @override
  State<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  bool _initialized = false;
  @override
  void didChangeDependencies() {
    if (!_initialized) {
      loadData();
      setState(() {
        _initialized = true;
      });
    }
    super.didChangeDependencies();
  }

  void loadData() async {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      final id = args['id'];
      await Provider.of<KnowledgeProvider>(context, listen: false)
          .getFilesKnowledge(id);
    }
  }

  late List<File> _files;
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final files = Provider.of<KnowledgeProvider>(context).files;
    return Scaffold(
      appBar: mainAppBar(
        context,
        "Danh sách tài liệu",
        AssetConstants.document,
        IconButton(
          onPressed: _pickFile,
          icon: const Icon(
            Icons.add,
            color: AppColors.primaryColor,
            size: 30,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, index) {
            final file = files[index];
            return FileItem(
              id: file.fileId.toString(),
              name: file.name.toString(),
              description: file.chunkCount.toString(),
            );
          },
        ),
      ),
    );
  }
}
