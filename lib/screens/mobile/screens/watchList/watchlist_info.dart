import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import '../../../../constant/constants.dart';
import 'package:flutter_spinbox/cupertino.dart';

import '../../../../themes/theme_model.dart';

class WatchListInfo extends StatefulWidget {
  // String symbolName;
  // String exchange;
  // double lTp;
  // double perChange;
  // int token;
  const WatchListInfo({
    super.key,
    // required this.symbolName,
    // required this.exchange,
    // required this.lTp,
    // required this.perChange,
    // required this.token
  });

  @override
  State<WatchListInfo> createState() => _WatchListInfoState(

      // symbolName, exchange, lTp, perChange, token

      );

  // static const String routeName = 'WatchListInfo';
  // static Route route() {
  //   return MaterialPageRoute(
  //     settings: const RouteSettings(name: routeName),
  //     builder: (_) => WatchListInfo(),
  //   );
  // }
}

class _WatchListInfoState extends State<WatchListInfo> {
  // String symbolName;
  // String exchange;
  // double lTp;
  // double perChange;
  // int token;
  // _WatchListInfoState(
  //     this.symbolName, this.exchange, this.lTp, this.perChange, this.token);
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        backgroundColor: themeNotifier.isDark ? Colors.black : Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "symbolName",
                  style: depthSymbolNameTextStyle(size),
                ),
                Text(
                  "exchange",
                  style: listSubTitle(size),
                ),
                Text(
                  "lTp",
                  style: depthLtpTextStyle(size),
                ),
                Text(
                  "perChange",
                  style: depthPcTextStyle(size),
                ),
                sizedHeight(size),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffB5C0CF).withOpacity(.15),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 11.0, horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Open",
                              style: depthTextStyle(size),
                            ),
                            Text(
                              "8978.8",
                              style: depthTextStyle(size),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "High",
                              style: depthTextStyle(size),
                            ),
                            Text(
                              "4534",
                              style: depthTextStyle(size),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Low",
                              style: depthTextStyle(size),
                            ),
                            Text(
                              "4534",
                              style: depthTextStyle(size),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "P.Close",
                              style: depthTextStyle(size),
                            ),
                            Text(
                              "576",
                              style: depthTextStyle(size),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                sizedHeight(size),
                const SizedBox(
                  height: 470,
                  // child: WebviewScaffold(
                  //   url:
                  //       "https://advanced-charts.web.app/?symbol=$symbolName&token=$token",
                  //   // javascriptChannels: jsChannels,
                  //   mediaPlaybackRequiresUserGesture: false,
                  //   withZoom: true,
                  //   withLocalStorage: true,
                  //   initialChild: Container(
                  //     color: Colors.black,
                  //   ),
                  //   ignoreSSLErrors: true,
                  //   resizeToAvoidBottomInset: true,
                  // ),
                ),
                sizedHeight(size),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 162,
                                  height: 52,
                                  child: CupertinoSpinBox(
                                    decoration: BoxDecoration(
                                      color: const Color(0xffB5C0CF)
                                          .withOpacity(.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    spacing: 2,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 17),
                                    min: 1,
                                    max: 100,
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    incrementIcon: const Icon(
                                      Icons.add_circle_outline,
                                      color: Color(0xffB5C0CF),
                                    ),
                                    decrementIcon: const Icon(
                                        Icons.remove_circle_outline,
                                        color: Color(0xffB5C0CF)),
                                    value: 1,
                                    onChanged: (value) => {},
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 162,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff57D76A)),
                                    child: const Text(
                                      "BUY",
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        sizedHeight(size),
                        SizedBox(
                          width: size.width,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: const Text(
                              "SELL",
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      );
    });
  }
}
