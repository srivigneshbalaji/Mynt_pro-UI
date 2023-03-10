// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/const_var.dart';
import '../../model/index_list_model.dart';
import '../../model/watchlist_model.dart';
import '../../themes/theme_model.dart';
import '../../web_socket/web_sockts.dart';
import 'screens/screens.dart';
import 'widget/widgets.dart';

import 'package:provider/provider.dart';

class MobileIndex extends StatefulWidget {
  const MobileIndex({super.key});
  static const String routeName = 'mobIndex';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const MobileIndex(),
    );
  }

  @override
  State<MobileIndex> createState() => _MobileIndexState();
}

class _MobileIndexState extends State<MobileIndex> {
  get value => null;

  @override
  void initState() {
    super.initState();
    // ConstVariable.bottomIndex = 0;
  }

  void changePage(int? index) {
    setState(() {
      ConstVariable.bottomIndex = index!;
      if (ConstVariable.bottomIndex == 1 ||
          ConstVariable.bottomIndex == 2 ||
          ConstVariable.bottomIndex == 3) {
        WebSocketConnection.estcon("u", WatchListModel.mWatchList, true);
      }
    });
  }

  List<Widget> tabItems = [
    WatchlistScreen(),
    OrderScreen(),
    PortfolioScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return true;
          },
          child: Scaffold(
            backgroundColor: themeNotifier.isDark ? Colors.black : Colors.white,
            appBar: MobileAppBar(
              indexLists: IndexListItem.indexDatas,
            ),
            body: tabItems[ConstVariable.bottomIndex],
            bottomNavigationBar: NavigationBarTheme(
              data: NavigationBarThemeData(
                  indicatorColor: Color.fromARGB(255, 255, 246, 237),
                  labelTextStyle: MaterialStateProperty.all(TextStyle(
                    fontSize: 12,
                    fontFamily: 'Rajdhani',
                    fontWeight: FontWeight.w900,
                  ))),
              child: NavigationBar(
                height: 60,
                // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                animationDuration: const Duration(seconds: 1),
                backgroundColor:
                    themeNotifier.isDark ? Colors.black : Colors.white,
                onDestinationSelected: (int index) {
                  setState(() {
                    ConstVariable.bottomIndex = index;
                  });
                },
                selectedIndex: ConstVariable.bottomIndex,
                destinations: <Widget>[
                  NavigationDestination(
                    icon: Icon(
                      Icons.av_timer_outlined,
                      color: themeNotifier.isDark ? Colors.white : Colors.black,
                    ),
                    selectedIcon: Icon(
                      Icons.av_timer,
                      // rgba(255, 141, 36, 1)
                      color: Color.fromARGB(255, 255, 142, 36),
                    ),
                    label: "Watchlist",
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.layers_outlined,
                      color: themeNotifier.isDark ? Colors.white : Colors.black,
                    ),
                    selectedIcon: Icon(
                      Icons.layers,
                      color: Color.fromARGB(255, 255, 142, 36),
                    ),
                    label: 'Order',
                  ),
                  NavigationDestination(
                    icon: Image.asset(
                      'bullseye-arrow.png',
                      color: themeNotifier.isDark ? Colors.white : Colors.black,
                      height: 23,
                      width: 24,
                    ),
                    selectedIcon: Image.asset(
                      'bullseye-arrow.png',
                      color: Color.fromARGB(255, 255, 142, 36),
                      height: 23,
                      width: 24,
                    ),
                    label: 'Portfolio',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.account_circle_outlined,
                      color: themeNotifier.isDark ? Colors.white : Colors.black,
                    ),
                    selectedIcon: Icon(
                      Icons.account_circle,
                      color: Color.fromARGB(255, 255, 142, 36),
                    ),
                    label: 'Account',
                  ),
                ],
              ),
              // bottomNavigationBar: BubbleBottomBar(
              //   backgroundColor: themeNotifier.isDark ? Colors.black : Colors.white,
              //   hasNotch: true,
              //   currentIndex: ConstVariable.bottomIndex,
              //   onTap: changePage,
              //   borderRadius: BorderRadius.vertical(
              //     top: Radius.circular(16),
              //   ), //border radius doesn't work when the notch is enabled.
              //   elevation: 8,
              //   tilesPadding: EdgeInsets.symmetric(
              //     vertical: 8.0,
              //   ),
              //   items: <BubbleBottomBarItem>[
              //     BubbleBottomBarItem(
              //       // showBadge: true,
              //       // badge: Text("5", style: TextStyle(color: Colors.white)),
              //       // badgeColor: Colors.redAccent,
              //       backgroundColor:
              //           themeNotifier.isDark ? Colors.white : Colors.black,
              //       icon: Icon(
              //         Icons.av_timer_outlined,
              //         color: themeNotifier.isDark ? Colors.white : Colors.black,
              //       ),
              //       activeIcon: Icon(
              //         Icons.av_timer,
              //         color: themeNotifier.isDark ? Colors.black : Colors.white,
              //       ),
              //       title: Text(
              //         "Watchlist",
              //         style: GoogleFonts.lexend(
              //           fontSize: size.height * 0.019,
              //           fontWeight: FontWeight.w600,
              //           color: themeNotifier.isDark ? Colors.black : Colors.white,
              //         ),
              //       ),
              //     ),
              //     BubbleBottomBarItem(
              //         backgroundColor:
              //             themeNotifier.isDark ? Colors.white : Colors.black,
              //         icon: Icon(
              //           Icons.layers_outlined,
              //           color: themeNotifier.isDark ? Colors.white : Colors.black,
              //         ),
              //         activeIcon: Icon(
              //           Icons.layers,
              //           color: themeNotifier.isDark ? Colors.black : Colors.white,
              //         ),
              //         title: Text(
              //           "Order",
              //           style: GoogleFonts.lexend(
              //             fontSize: size.height * 0.019,
              //             fontWeight: FontWeight.w600,
              //             color: themeNotifier.isDark ? Colors.black : Colors.white,
              //           ),
              //         )),
              //     BubbleBottomBarItem(
              //         backgroundColor:
              //             themeNotifier.isDark ? Colors.white : Colors.black,
              //         icon: Image.asset(
              //           'bullseye-arrow.png',
              //           color: themeNotifier.isDark ? Colors.white : Colors.black,
              //           height: 23,
              //           width: 24,
              //         ),
              //         activeIcon: Image.asset(
              //           'bullseye-arrow.png',
              //           color: themeNotifier.isDark ? Colors.black : Colors.white,
              //           height: 23,
              //           width: 24,
              //         ),
              //         title: Text(
              //           "Portfolio",
              //           style: GoogleFonts.lexend(
              //             fontSize: size.height * 0.019,
              //             fontWeight: FontWeight.w600,
              //             color: themeNotifier.isDark ? Colors.black : Colors.white,
              //           ),
              //         )),
              //     BubbleBottomBarItem(
              //         backgroundColor:
              //             themeNotifier.isDark ? Colors.white : Colors.black,
              //         icon: Icon(
              //           Icons.account_circle_outlined,
              //           color: themeNotifier.isDark ? Colors.white : Colors.black,
              //         ),
              //         activeIcon: Icon(
              //           Icons.account_circle,
              //           color: themeNotifier.isDark ? Colors.black : Colors.white,
              //         ),
              //         title: Text(
              //           "Account",
              //           style: GoogleFonts.lexend(
              //             fontSize: size.height * 0.019,
              //             fontWeight: FontWeight.w600,
              //             color: themeNotifier.isDark ? Colors.black : Colors.white,
              //           ),
              //         )),
              //   ],
              //   opacity: .9,
              // ),
            ),
          ));
    });
  }
}
