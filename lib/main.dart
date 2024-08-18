// import 'package:final_project/providers/NavigatorProvider.dart';
import 'package:chat_document/providers/bot_provider.dart';
import 'package:chat_document/providers/knowledge_provider.dart';
import 'package:chat_document/providers/user_provider.dart';
import 'package:chat_document/screens/auth_screen.dart';
import 'package:chat_document/screens/chat_bot.dart';
import 'package:chat_document/screens/files_screen.dart';

import '../providers/auth.dart';
import '../providers/theme_provider.dart';
// import '../screens/home_screen.dart';
import '../screens/main_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
        ChangeNotifierProxyProvider<Auth, UserProvider>(
          create: (context) => UserProvider(accessToken: ""),
          update: (context, auth, previous) =>
              UserProvider(accessToken: auth.accessToken),
        ),
        ChangeNotifierProxyProvider<Auth, BotProvider>(
          create: (context) => BotProvider(accessToken: ""),
          update: (context, auth, previous) =>
              BotProvider(accessToken: auth.accessToken),
        ),
        ChangeNotifierProxyProvider<Auth, KnowledgeProvider>(
          create: (context) => KnowledgeProvider(accessToken: ""),
          update: (context, auth, previous) =>
              KnowledgeProvider(accessToken: auth.accessToken),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: Provider.of<ThemeProvider>(context).themeData,
          home: auth.isAuth ? const SplashScreen() : const AuthScreen(),
          routes: {
            AuthScreen.routeName: (context) => const AuthScreen(),
            MainScreen.routeName: (context) => const MainScreen(),
            FilesScreen.routeName: (context) => const FilesScreen(),
            ChatBot.routeName: (context) => ChatBot(),
          },
        ),
      ),
    );
  }
}
