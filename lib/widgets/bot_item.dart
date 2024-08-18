import 'package:chat_document/screens/chat_bot.dart';
import 'package:provider/provider.dart';

import '../providers/bot_provider.dart';
import '../utils/functions.dart';
import '../utils/widgets.dart';
import '../widgets/update_bot_dialog.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

class BotItem extends StatelessWidget {
  final String name;
  final String description;
  final String id;
  const BotItem(
      {super.key,
      required this.name,
      required this.description,
      required this.id});
  // void _showUpdateBotDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => UpdateBotDialog(
  //       name: name,
  //       description: description,
  //       onUpdate: (name, description) async {
  //         try {
  //           await Provider.of<BotProvider>(context, listen: false).updateBot(
  //             id,
  //             name,
  //             description,
  //           );
  //         } catch (error) {
  //           print('Error updating bot: $error');
  //         }
  //       },
  //     ),
  //   );
  // }

  void navigateToProductDetail(BuildContext context, String botId) {
    Navigator.of(context)
        .pushNamed(ChatBot.routeName, arguments: {"id": botId});
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
            Container(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: (deviceSize.width - 40 - 15 * 2) * 0.2,
                      height: 80,
                      child: Image.asset(
                        AssetConstants.brainAi,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  BoxEmpty.sizeBox10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(description),
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    showUpdateBotDialog(context, name, description, id);
                  },
                  icon: Icon(Icons.edit),
                  color: AppColors.primaryGreen,
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<BotProvider>(context, listen: false)
                        .deleteBot(id);
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
