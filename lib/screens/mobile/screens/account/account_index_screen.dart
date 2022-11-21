import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../functions/user_detail.dart';
import '../../../../themes/theme_model.dart';
import '../screens.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    // userDetail(context: context);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
          backgroundColor: themeNotifier.isDark ? Colors.black : Colors.white,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            backgroundColor: themeNotifier.isDark
                ? Colors.white.withOpacity(.5)
                : Colors.black.withOpacity(.5),
            splashColor: Colors.amber,
            onPressed: () {
              themeNotifier.isDark
                  ? themeNotifier.isDark = false
                  : themeNotifier.isDark = true;
            },
            child: Icon(
              themeNotifier.isDark ? Icons.nightlight_round : Icons.wb_sunny,
              color: themeNotifier.isDark ? Colors.black : Colors.white,
              size: 30,
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: AccProfile(),
          ));
    });
  }
}
