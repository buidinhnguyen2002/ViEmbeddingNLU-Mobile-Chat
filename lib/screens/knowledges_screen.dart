import 'package:chat_document/providers/knowledge_provider.dart';
import 'package:chat_document/widgets/knowledge_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bot_provider.dart';

class KnowledgesScreen extends StatelessWidget {
  const KnowledgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final knowledges = Provider.of<KnowledgeProvider>(context).knowledges;
    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: knowledges.length,
        itemBuilder: (context, index) {
          final knowledge = knowledges[index];
          return KnowledgeItem(
              id: knowledge.knowledgeId.toString(),
              name: knowledge.name.toString(),
              description: knowledge.description.toString());
        },
      ),
    );
  }
}
