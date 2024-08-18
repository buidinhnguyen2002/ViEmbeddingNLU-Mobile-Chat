import 'package:chat_document/models/knowledge.dart';
import 'package:chat_document/providers/bot_provider.dart';
import 'package:chat_document/providers/knowledge_provider.dart';
import 'package:chat_document/providers/user_provider.dart';

import '../providers/auth.dart';
import '../screens/main_screen.dart';
import '../utils/constants.dart';
import '../utils/functions.dart';
import '../utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void loadData() async {
    await Provider.of<UserProvider>(context, listen: false).getUserInfo();
    await Provider.of<BotProvider>(context, listen: false).getBots();
    await Provider.of<KnowledgeProvider>(context, listen: false)
        .getKnowledges();
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushNamed(MainScreen.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetConstants.bot,
                  fit: BoxFit.contain,
                  width: 300,
                  height: 300,
                ),
                BoxEmpty.sizeBox10,
                Text(
                  "ViEmbeddingNLU",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
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
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: deviceSize.width / 2 - 20,
            child: const CircularProgressIndicator.adaptive(),
          )
        ],
      ),
    );
  }
}
