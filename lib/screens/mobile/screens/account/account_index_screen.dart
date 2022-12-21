import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../api/api_links.dart';
import '../../../../constant/const_var.dart';
import '../../../../model/fund_model.dart';
import '../../../../themes/theme_model.dart';
import '../screens.dart';
import 'package:http/http.dart' as http;

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
    fundDetail();
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

  Future fundDetail() async {
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.fundDetail),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}","actid":"${ConstVariable.accId}" }&jKey=${ConstVariable.sessionId}''');
      setState(() {
        FundModel.fundDetailRes = json.decode(response.body);
      });

      var stat = FundModel.fundDetailRes['stat'];
      log("${FundModel.fundDetailRes}");
      if (stat == "Ok") {
        setState(() {
          FundModel.brokg = FundModel.fundDetailRes['brkage_d_i'];
          FundModel.peakMrgn = FundModel.fundDetailRes['peak_mar'];
          FundModel.avlCash = FundModel.fundDetailRes['cash'];
          FundModel.payIn = FundModel.fundDetailRes['payin'];
          FundModel.payOut = FundModel.fundDetailRes['payout'];
          FundModel.sapn = FundModel.fundDetailRes['span'];
          FundModel.relProfit = FundModel.fundDetailRes['rpnl'];
          FundModel.unRelProfit = FundModel.fundDetailRes['unclearedcash'];
          FundModel.exposur = FundModel.fundDetailRes['aux_brkcollamt'];
          FundModel.adhocMrgn = FundModel.fundDetailRes['aux_brkcollamt'];
          FundModel.stockCollotral = FundModel.fundDetailRes['brkcollamt'];
          FundModel.optionPremium = FundModel.fundDetailRes['premium'];
          FundModel.usedMrgn = FundModel.fundDetailRes['marginused'];
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(sb.unSuccessBar("Session Expired"));
      }
    } catch (e) {}
  }
}
