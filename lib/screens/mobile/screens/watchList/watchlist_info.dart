// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import '../../../../api/api_links.dart';
import '../../../../constant/constants.dart';
import 'package:http/http.dart' as http;
import '../../../../model/models.dart';
import '../../../../constant/snackbar.dart';
import '../../../../shared_widgets/custom_button.dart';
import '../../../../themes/theme_model.dart';

class WatchListInfo extends StatefulWidget {
  String exchange;
  String token;
  String scriptName;

  WatchListInfo({
    super.key,
    required this.exchange,
    required this.token,
    required this.scriptName,
  });

  @override
  State<WatchListInfo> createState() =>
      _WatchListInfoState(exchange, token, scriptName);
}

class _WatchListInfoState extends State<WatchListInfo> {
  String exchange;
  String token;
  String scriptName;
  bool isDepth = true;
  bool isChart = false;
  _WatchListInfoState(this.exchange, this.token, this.scriptName);
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  @override
  void initState() {
    scriptInfo(exchange, token);
    super.initState();
  }

  bool buyActive = false;
  bool sellActive = false;
  final MySnackBars sb = MySnackBars();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      var symName = scriptName.replaceAll("-EQ", "");

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),

            //replace with our own icon data.
          ),
          title: Text(
            ScriptInfoModel.scriptName,
            style: depthSymbolNameTextStyle(size),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: CustomOutlineButton(
                    isSelected: buyActive,
                    onPress: () {
                      setState(() {
                        buyActive = true;
                        sellActive = false;
                      });
                    },
                    label: 'Buy',
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: CustomOutlineButton(
                    isSelected: sellActive,
                    onPress: () {
                      setState(() {
                        buyActive = false;
                        sellActive = true;
                      });
                    },
                    label: 'Sell',
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
        backgroundColor: themeNotifier.isDark ? Colors.black : Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ScriptInfoModel.scriptName,
                    style: depthSymbolNameTextStyle(size),
                  ),
                  Text(
                    ScriptInfoModel.ltp,
                    style: depthSymbolNameTextStyle(size),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ScriptInfoModel.exchange,
                    style: listSubTitle(size),
                  ),
                  Text(
                    ScriptInfoModel.pChange,
                    style: listSubTitle(size),
                  ),
                ],
              ),
              sizedHeight(size),
              Row(
                children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isDepth ? Colors.black : Colors.white),
                      onPressed: () {
                        setState(() {
                          isChart = false;
                          isDepth = true;
                        });
                      },
                      icon: Icon(
                        Icons.align_horizontal_center,
                        color: isDepth ? Colors.white : Colors.black,
                      ),
                      label: Text(
                        "Market depth",
                        style: TextStyle(
                            color: isDepth ? Colors.white : Colors.black),
                      )),
                  SizedBox(
                    width: 12,
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isDepth ? Colors.white : Colors.black),
                      onPressed: () {
                        setState(() {
                          isChart = true;
                          isDepth = false;
                        });
                      },
                      icon: Icon(
                        Icons.equalizer,
                        color: isDepth ? Colors.black : Colors.white,
                      ),
                      label: Text(
                        "Chart",
                        style: TextStyle(
                            color: isDepth ? Colors.black : Colors.white),
                      ))
                ],
              ),
              sizedHeight(size),
              Visibility(
                visible: isDepth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(child: Text("B-Id")),
                        Text(ScriptInfoModel.bPrice1),
                        Text(ScriptInfoModel.bPrice2),
                        Text(ScriptInfoModel.bPrice3),
                        Text(ScriptInfoModel.bPrice4),
                        Text(ScriptInfoModel.bPrice5),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Ords"),
                        Text(ScriptInfoModel.bOrder1),
                        Text(ScriptInfoModel.bOrder2),
                        Text(ScriptInfoModel.bOrder3),
                        Text(ScriptInfoModel.bOrder4),
                        Text(ScriptInfoModel.bOrder5),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Qty"),
                        Text(ScriptInfoModel.bQty1),
                        Text(ScriptInfoModel.bQty2),
                        Text(ScriptInfoModel.bQty3),
                        Text(ScriptInfoModel.bQty4),
                        Text(ScriptInfoModel.bQty5),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("S-Id"),
                        Text(ScriptInfoModel.sPrice1),
                        Text(ScriptInfoModel.sPrice2),
                        Text(ScriptInfoModel.sPrice3),
                        Text(ScriptInfoModel.sPrice4),
                        Text(ScriptInfoModel.sPrice5),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Ords"),
                        Text(ScriptInfoModel.sOrder1),
                        Text(ScriptInfoModel.sOrder2),
                        Text(ScriptInfoModel.sOrder3),
                        Text(ScriptInfoModel.sOrder4),
                        Text(ScriptInfoModel.sOrder5),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Qty"),
                        Text(ScriptInfoModel.sQty1),
                        Text(ScriptInfoModel.sQty2),
                        Text(ScriptInfoModel.sQty3),
                        Text(ScriptInfoModel.sQty4),
                        Text(ScriptInfoModel.sQty5),
                      ],
                    )
                  ],
                ),
              ),
              sizedHeight(size),
              Visibility(
                visible: isChart,
                child: SizedBox(
                  height: 450,
                  width: MediaQuery.of(context).size.width,
                  child: WebviewScaffold(
                    url:
                        "https://advanced-charts.web.app/?symbol=$symName&token=$token",
                    mediaPlaybackRequiresUserGesture: false,
                    withZoom: true,
                    withLocalStorage: true,
                    initialChild: Container(
                      color: Colors.black,
                    ),
                    ignoreSSLErrors: true,
                  ),
                ),
              ),
              Visibility(
                visible: isDepth,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("High"),
                              Text(ScriptInfoModel.high)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Open"),
                              Text(ScriptInfoModel.open)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Vol"),
                              Text(ScriptInfoModel.volume)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("LTQ"),
                              Text(ScriptInfoModel.lTradeQty)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("LCL"),
                              Text(ScriptInfoModel.lowerCircuit)
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text("Low"), Text(ScriptInfoModel.low)],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Close"),
                              Text(ScriptInfoModel.close)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Avg.Price"),
                              Text(ScriptInfoModel.avgPrice)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("LTT"),
                              Text(ScriptInfoModel.lTradeTime)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("UCL"),
                              Text(ScriptInfoModel.upperCircuit)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future scriptInfo(exchange, token) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.getQuotes),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}","exch":"$exchange","token":"$token"}&jKey=${ConstVariable.sessionId}''');

      setState(() {
        ScriptInfoModel.scriptInfoRes = json.decode(response.body);
      });

      var stat = ScriptInfoModel.scriptInfoRes['stat'];
      if (stat == "Ok") {
        setState(() {
          ScriptInfoModel.scriptName = ScriptInfoModel.scriptInfoRes['symname'];
          ScriptInfoModel.exchange = ScriptInfoModel.scriptInfoRes['exch'];
          ScriptInfoModel.pChange = ScriptInfoModel.scriptInfoRes['pp'];
          ScriptInfoModel.ltp = ScriptInfoModel.scriptInfoRes['lp'];
          ScriptInfoModel.bPrice1 = ScriptInfoModel.scriptInfoRes['bp1'];
          ScriptInfoModel.bPrice2 = ScriptInfoModel.scriptInfoRes['bp2'];
          ScriptInfoModel.bPrice3 = ScriptInfoModel.scriptInfoRes['bp3'];
          ScriptInfoModel.bPrice4 = ScriptInfoModel.scriptInfoRes['bp4'];
          ScriptInfoModel.bPrice5 = ScriptInfoModel.scriptInfoRes['bp5'];
          ScriptInfoModel.bOrder1 = ScriptInfoModel.scriptInfoRes['bo1'];
          ScriptInfoModel.bOrder2 = ScriptInfoModel.scriptInfoRes['bo2'];
          ScriptInfoModel.bOrder3 = ScriptInfoModel.scriptInfoRes['bo3'];
          ScriptInfoModel.bOrder4 = ScriptInfoModel.scriptInfoRes['bo4'];
          ScriptInfoModel.bOrder5 = ScriptInfoModel.scriptInfoRes['bo5'];
          ScriptInfoModel.bQty1 = ScriptInfoModel.scriptInfoRes['bq1'];
          ScriptInfoModel.bQty2 = ScriptInfoModel.scriptInfoRes['bq2'];
          ScriptInfoModel.bQty3 = ScriptInfoModel.scriptInfoRes['bq3'];
          ScriptInfoModel.bQty4 = ScriptInfoModel.scriptInfoRes['bq4'];
          ScriptInfoModel.bQty5 = ScriptInfoModel.scriptInfoRes['bq5'];
          ScriptInfoModel.sPrice1 = ScriptInfoModel.scriptInfoRes['sp1'];
          ScriptInfoModel.sPrice2 = ScriptInfoModel.scriptInfoRes['sp2'];
          ScriptInfoModel.sPrice3 = ScriptInfoModel.scriptInfoRes['sp3'];
          ScriptInfoModel.sPrice4 = ScriptInfoModel.scriptInfoRes['sp4'];
          ScriptInfoModel.sPrice5 = ScriptInfoModel.scriptInfoRes['sp5'];
          ScriptInfoModel.sOrder1 = ScriptInfoModel.scriptInfoRes['so1'];
          ScriptInfoModel.sOrder2 = ScriptInfoModel.scriptInfoRes['so2'];
          ScriptInfoModel.sOrder3 = ScriptInfoModel.scriptInfoRes['so3'];
          ScriptInfoModel.sOrder4 = ScriptInfoModel.scriptInfoRes['so4'];
          ScriptInfoModel.sOrder5 = ScriptInfoModel.scriptInfoRes['so5'];
          ScriptInfoModel.sQty1 = ScriptInfoModel.scriptInfoRes['sq1'];
          ScriptInfoModel.sQty2 = ScriptInfoModel.scriptInfoRes['sq2'];
          ScriptInfoModel.sQty3 = ScriptInfoModel.scriptInfoRes['sq3'];
          ScriptInfoModel.sQty4 = ScriptInfoModel.scriptInfoRes['sq4'];
          ScriptInfoModel.sQty5 = ScriptInfoModel.scriptInfoRes['sq5'];
          ScriptInfoModel.open = ScriptInfoModel.scriptInfoRes['o'];
          ScriptInfoModel.high = ScriptInfoModel.scriptInfoRes['h'];
          ScriptInfoModel.low = ScriptInfoModel.scriptInfoRes['l'];
          ScriptInfoModel.close = ScriptInfoModel.scriptInfoRes['c'];
          ScriptInfoModel.volume = ScriptInfoModel.scriptInfoRes['v'];
          ScriptInfoModel.avgPrice = ScriptInfoModel.scriptInfoRes['ap'];
          ScriptInfoModel.lTradeQty = ScriptInfoModel.scriptInfoRes['ltq'];
          ScriptInfoModel.lTradeTime = ScriptInfoModel.scriptInfoRes['ltt'];
          ScriptInfoModel.lowerCircuit = ScriptInfoModel.scriptInfoRes['lc'];
          ScriptInfoModel.upperCircuit = ScriptInfoModel.scriptInfoRes['uc'];
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(sb.unSuccessBar("Session Expired"));
      }
    } catch (e) {}
  }
}
