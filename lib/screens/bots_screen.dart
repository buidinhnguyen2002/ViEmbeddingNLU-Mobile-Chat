import 'package:chat_document/providers/bot_provider.dart';
import 'package:chat_document/utils/colors.dart';
import 'package:chat_document/utils/constants.dart';
import 'package:chat_document/widgets/bot_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BotsScreen extends StatelessWidget {
  const BotsScreen({super.key});
  static const routeName = '/bots-screen';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final bots = Provider.of<BotProvider>(context).bots;
    return Padding(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: bots.length,
        itemBuilder: (context, index) {
          final bot = bots[index];
          return BotItem(
              id: bot.botId.toString(),
              name: bot.name.toString(),
              description: bot.description.toString());
        },
      ),
    );
  }
}
