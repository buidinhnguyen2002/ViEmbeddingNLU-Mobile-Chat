import 'package:chat_document/providers/knowledge_provider.dart';
import 'package:chat_document/widgets/update_knowledge_dialog.dart';
import 'package:provider/provider.dart';

import '../providers/bot_provider.dart';
import '../widgets/notification_dialog.dart';
import 'package:flutter/material.dart';

import '../widgets/update_bot_dialog.dart';

void navigation(BuildContext context, String routerName) {
  Navigator.of(context).pushNamed(routerName);
}

Future<void> showNotification(BuildContext context, String content) async {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      Future.delayed(
        const Duration(seconds: 1, microseconds: 50),
        () {
          Navigator.of(ctx).pop(true);
        },
      );
      return NotificationDialog(content: content);
    },
  );
}

void showUpdateBotDialog(BuildContext context, name, description, id) {
  final isCreate = id == "";
  showDialog(
    context: context,
    builder: (context) => UpdateBotDialog(
      isCreate: isCreate,
      name: name,
      description: description,
      onUpdate: (name, description) async {
        try {
          if (isCreate) {
            await Provider.of<BotProvider>(context, listen: false).createBot(
              name,
              description,
            );
          } else {
            await Provider.of<BotProvider>(context, listen: false).updateBot(
              id,
              name,
              description,
            );
          }
        } catch (error) {
          print('Error updating bot: $error');
        }
      },
    ),
  );
}

void showUpdateKnowledgeDialog(BuildContext context, name, description, id) {
  final isCreate = id == "";
  showDialog(
    context: context,
    builder: (context) => UpdateKnowledgeDialog(
      isCreate: isCreate,
      name: name,
      description: description,
      onPress: (name, description) async {
        try {
          if (isCreate) {
            await Provider.of<KnowledgeProvider>(context, listen: false)
                .createKnowledge(
              name,
              description,
            );
          } else {
            await Provider.of<KnowledgeProvider>(context, listen: false)
                .updateKnowledge(
              id,
              name,
              description,
            );
          }
        } catch (error) {
          print('Error updating bot: $error');
        }
      },
    ),
  );
}
