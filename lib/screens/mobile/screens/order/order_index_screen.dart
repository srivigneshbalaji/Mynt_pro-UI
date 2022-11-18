import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constants.dart';
import '../../../../themes/theme_model.dart';
import '../screens.dart';
import 'pending_order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
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
        body: Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                // color: Colors.grey[300],
                // borderRadius: BorderRadius.circular(
                //   25.0,
                // ),

                border: Border(
                  bottom: BorderSide(
                    //                   <--- left side
                    color:
                        themeNotifier.isDark ? Colors.white12 : Colors.black12,
                    width: 2.0,
                  ),
                ),
              ),
              child: TabBar(
                labelStyle: tabBtnTextStyle(size),
                unselectedLabelStyle: tabBtnTextStyle(size),
                indicatorColor: Colors.blue,
                controller: _tabController,
                labelColor: Colors.blue,
                onTap: ((value) {}),
                unselectedLabelColor:
                    themeNotifier.isDark ? Colors.white : Colors.black,
                tabs: const [
                  Tab(
                    text: 'Pending',
                  ),
                  Tab(
                    text: 'Executed',
                  ),
                  Tab(
                    text: 'Trade Book',
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  PendingOrder(),
                  ExecutedOrder(),
                  TradeBookOrder()
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
