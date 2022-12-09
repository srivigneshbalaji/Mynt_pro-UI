// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../api/api_links.dart';
import '../../../../constant/const_var.dart';
import '../../../../constant/constants.dart';
import '../../../../model/portfolio_model.dart';
import '../../../../themes/theme_model.dart';
import '../screens.dart';
import 'holding_screen.dart';

import 'position_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    positionBook();
    holding();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                unselectedLabelColor:
                    themeNotifier.isDark ? Colors.white : Colors.black,
                tabs: const [
                  Tab(
                    text: 'Position',
                  ),
                  Tab(
                    text: 'Holding',
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  PositionScreen(
                    positions: PortfolioModel.portfolioDatas,
                  ),
                  HoldingScreen()
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Future positionBook() async {
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.positionBook),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}","actid":"${ConstVariable.accId}"}&jKey=${ConstVariable.sessionId}''');

      var mapRes = json.decode(response.body);
      String stat = mapRes['stat'];
      String emgs = mapRes['emsg'];
      print("Position-Book :: ${mapRes}");
    } catch (e) {}
  }

  Future holding() async {
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.holdings),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}","actid":"${ConstVariable.accId}","prd":"F"}&jKey=${ConstVariable.sessionId}''');

      List holdingRes = json.decode(response.body);

      print("Holding :: ${holdingRes}");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          sb.unSuccessBar("Connection issue, Please Try again later"));
    }
  }
}
