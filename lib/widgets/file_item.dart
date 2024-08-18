import 'package:chat_document/providers/knowledge_provider.dart';
import 'package:chat_document/screens/files_screen.dart';
import 'package:chat_document/utils/functions.dart';
import 'package:chat_document/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

class FileItem extends StatelessWidget {
  final String name;
  final String description;
  final String id;
  const FileItem(
      {super.key,
      required this.name,
      required this.description,
      required this.id});
  void navigateToProductDetail(BuildContext context, String knowledgeId) {
    Navigator.of(context)
        .pushNamed(FilesScreen.routeName, arguments: {"id": knowledgeId});
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => navigateToProductDetail(context, id),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.background,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: (deviceSize.width - 40 - 15 * 2) * 0.2,
                        height: 60,
                        child: Image.asset(
                          AssetConstants.document,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    BoxEmpty.sizeBox10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            description,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    showUpdateKnowledgeDialog(context, name, description, id);
                  },
                  icon: Icon(Icons.edit),
                  color: AppColors.primaryGreen,
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<KnowledgeProvider>(context, listen: false)
                        .deleteKnowledge(id);
                  },
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
