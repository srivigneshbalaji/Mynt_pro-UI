import 'package:flutter/material.dart';

import '../../../../constant/text_style.dart';
import '../../../../model/fund_model.dart';

class FundScreen extends StatefulWidget {
  const FundScreen({super.key});
  static const String routeName = 'fund';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const FundScreen(),
    );
  }

  @override
  State<FundScreen> createState() => _FundScreenState();
}

class _FundScreenState extends State<FundScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Funds",
          style: listTitle(size),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  sizedHeight(size),
                  Card(
                    child: SizedBox(
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: Column(
                            children: [
                              Text(
                                "Margin available",
                                style: listSubTitle(size),
                              ),
                              Text(
                                FundModel.avlCash,
                                style: listTitle(size),
                              ),
                            ],
                          ),
                        )),
                  ),
                  sizedHeight(size),
                  Card(
                    child: SizedBox(
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Opening balance",
                                    style: listSubTitle(size),
                                  ),
                                  Text(
                                    FundModel.avlCash,
                                    style: listSubTitle(size),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Margin used",
                                    style: listSubTitle(size),
                                  ),
                                  Text(
                                    FundModel.usedMrgn,
                                    style: listSubTitle(size),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  sizedHeight(size),
                  Card(
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Brokerage",
                                style: listSubTitle(size),
                              ),
                              Text(
                                FundModel.brokg,
                                style: listSubTitle(size),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Available Cash",
                                style: listSubTitle(size),
                              ),
                              Text(
                                FundModel.avlCash,
                                style: listSubTitle(size),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Peak Margin",
                                style: listSubTitle(size),
                              ),
                              Text(
                                FundModel.peakMrgn,
                                style: listSubTitle(size),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payin",
                                style: listSubTitle(size),
                              ),
                              Text(
                                FundModel.payIn,
                                style: listSubTitle(size),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payout",
                                style: listSubTitle(size),
                              ),
                              Text(
                                FundModel.payOut,
                                style: listSubTitle(size),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Span",
                                style: listSubTitle(size),
                              ),
                              Text(
                                FundModel.sapn,
                                style: listSubTitle(size),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Realized Profit",
                                style: listSubTitle(size),
                              ),
                              Text(
                                FundModel.relProfit,
                                style: listSubTitle(size),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Unrealized Profit",
                                style: listSubTitle(size),
                              ),
                              Text(
                                FundModel.unRelProfit,
                                style: listSubTitle(size),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Exposure",
                                style: listSubTitle(size),
                              ),
                              Text(
                                FundModel.exposur,
                                style: listSubTitle(size),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Adhoc Margin",
                                style: listSubTitle(size),
                              ),
                              Text(
                                FundModel.adhocMrgn,
                                style: listSubTitle(size),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Stock Collateral",
                                style: listSubTitle(size),
                              ),
                              Text(
                                FundModel.stockCollotral,
                                style: listSubTitle(size),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Option Premium",
                                style: listSubTitle(size),
                              ),
                              Text(
                                FundModel.optionPremium,
                                style: listSubTitle(size),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
