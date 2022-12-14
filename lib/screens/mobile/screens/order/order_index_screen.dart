import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../../api/api_links.dart';
import '../../../../constant/const_var.dart';
import '../../../../constant/constants.dart';
import '../../../../themes/theme_model.dart';
import '../screens.dart';
import 'pending_order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  static const String routeName = 'orderIndex';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const OrderScreen(),
    );
  }

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
    tradeBook();
  }

  // void _getActiveTabIndex() {
  //   executedOrderBook();
  // }

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
                unselectedLabelColor:
                    themeNotifier.isDark ? Colors.white : Colors.black,
                tabs: const [
                  Tab(
                    text: 'Executed',
                  ),
                  Tab(
                    text: 'Pending',
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
                  ExecutedOrder(),
                  PendingOrder(),
                  TradeBookOrder()
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Future tradeBook() async {
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.tradeBook),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}","actid":"${ConstVariable.accId}"}&jKey=${ConstVariable.sessionId}''');

      var mapRes = json.decode(response.body);
      String stat = mapRes['stat'];

      print("Trade-Book :: ${mapRes}");
    } catch (e) {}
  }
}
