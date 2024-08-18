// import 'package:final_project/screens/cart_screen.dart';
// import 'package:final_project/screens/home_screen.dart';
// import 'package:final_project/screens/order_screen.dart';
// import 'package:final_project/screens/profile_screen.dart';
// import 'package:final_project/screens/restaurant_screen.dart';
import 'package:chat_document/screens/bots_screen.dart';
import 'package:chat_document/screens/knowledges_screen.dart';
import 'package:chat_document/utils/constants.dart';

import '../utils/app_bar.dart';
import '../utils/colors.dart';
import '../utils/functions.dart';
import '../utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const routeName = '/main';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() {}

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget getBody() {
    switch (_selectedPageIndex) {
      case 0:
        return const BotsScreen();
      case 1:
        return const KnowledgesScreen();
      case 2:
        return const BotsScreen();
      case 3:
        return const BotsScreen();
      default:
    }
    return Container();
  }

  AppBar getAppBar(BuildContext context) {
    switch (_selectedPageIndex) {
      case 0:
        return mainAppBar(
          context,
          "Bots",
          AssetConstants.bot,
          IconButton(
            onPressed: () {
              showUpdateBotDialog(context, "", "", "");
            },
            icon: const Icon(
              Icons.add,
              color: AppColors.primaryColor,
              size: 30,
            ),
          ),
        );
      case 1:
        return mainAppBar(
          context,
          "Danh sách kiến thức",
          AssetConstants.knowledge,
          IconButton(
            onPressed: () {
              showUpdateKnowledgeDialog(context, "", "", "");
            },
            icon: const Icon(
              Icons.add,
              color: AppColors.primaryColor,
              size: 30,
            ),
          ),
        );
      case 2:
        return mainAppBar(
          context,
          "Tài khoản",
          AssetConstants.myAccount,
          SizedBox(),
        );
      default:
    }
    return AppBar();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final index = args?['index'];
    if (index != null) {
      setState(() {
        _selectedPageIndex = index;
      });
    } else {
      setState(() {
        _selectedPageIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: getAppBar(context),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.assistant_outlined), label: "Bots"),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_rounded), label: "Kiến thức"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined), label: "Tài khoản"),
        ],
        unselectedItemColor: Theme.of(context).colorScheme.onTertiary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
      ),
    );
  }
}
