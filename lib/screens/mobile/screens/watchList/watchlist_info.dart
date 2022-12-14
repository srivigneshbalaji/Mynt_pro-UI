import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mynt_pro/web_socket/market_depth.dart';
import 'package:mynt_pro/web_socket/websocket_connection.dart';
import 'package:provider/provider.dart';
import '../../../../api/api_links.dart';
import '../../../../constant/constants.dart';
import '../../../../model/models.dart';
import '../../../../constant/snackbar.dart';
import '../../../../themes/theme_model.dart';
import '../../../../web_socket/depth_response.dart';
import '../../../../web_socket/depth_ws_ack.dart';
import '../order/orders.dart';

class WatchListInfo extends StatefulWidget {
  final MarketDepth marketDepth;
  String exchange;
  String scriptName;
  String token;
  WatchListInfo({
    super.key,
    required this.exchange,
    required this.marketDepth,
    required this.scriptName,
    required this.token,
  });

  @override
  State<WatchListInfo> createState() =>
      _WatchListInfoState(exchange, marketDepth, scriptName, token);
}

class _WatchListInfoState extends State<WatchListInfo> {
  String exchange;
  final MarketDepth marketDepth;
  String scriptName;
  String token;
  bool isDepth = true;
  bool isChart = false;

  _WatchListInfoState(
      this.exchange, this.marketDepth, this.scriptName, this.token);
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  bool buyActive = false;
  bool sellActive = false;
  final MySnackBars sb = MySnackBars();
  @override
  void initState() {
    scriptInfo(exchange, token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      var buyPrice;
      double price = 0;
      var che;
      var pChange;

      String token = marketDepth.token as String;
      String symbolName = "";
      String lastPrice = "";
      return WillPopScope(
        onWillPop: () async {
          Map watchlistDepth = {"exch": exchange.toString(), "token": token};
          WebSocketConnection.estcon("ud", watchlistDepth, true);
          WebSocketConnection.estcon("t", WatchListModel.mWatchList, true);

          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Map watchlistDepth = {
                  "exch": exchange.toString(),
                  "token": token.toString()
                };

                WebSocketConnection.estcon(
                    "t", WatchListModel.mWatchList, true);
                WebSocketConnection.estcon("ud", watchlistDepth, true);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              scriptName,
              style: depthSymbolNameTextStyle(size),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: SizedBox(
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        child: const Text("BUY"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BuyOrder(
                                    scriptName: scriptName,
                                    exch: exchange,
                                    tok: token,
                                    lastPrice: price,
                                  )));
                        },
                      )),
                  SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text("SELL"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SellOrder(
                                    scriptName: scriptName,
                                    exch: exchange,
                                    tok: token,
                                    lastPrice: price,
                                  )));
                        },
                      ))
                ],
              ),
            ),
          ),
          backgroundColor: themeNotifier.isDark ? Colors.black : Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            child: StreamBuilder(
                stream: WebSocketConnection.dpAckStream.stream
                    .where((event) => event.tk == marketDepth.token),
                builder: (_,
                    AsyncSnapshot<DepthAckWSResponse> snapshotAcknowledgement) {
                  marketDepth.change = "0.00";
                  if (snapshotAcknowledgement.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshotAcknowledgement.data != null) {
                    if (snapshotAcknowledgement.data!.tk == marketDepth.token) {
                      WebSocketConnection.datacontroller
                          .add(snapshotAcknowledgement.data);
                      marketDepth.symbolname =
                          snapshotAcknowledgement.data!.ts == null ||
                                  snapshotAcknowledgement.data!.ts! == 'null'
                              ? marketDepth.symbolname
                              : snapshotAcknowledgement.data!.ts!;
                      symbolName =
                          marketDepth.symbolname!.replaceAll("-EQ", "");
                      marketDepth.exc =
                          snapshotAcknowledgement.data!.e == null ||
                                  snapshotAcknowledgement.data!.e! == 'null'
                              ? marketDepth.exc
                              : snapshotAcknowledgement.data!.e!;
                      marketDepth.close =
                          snapshotAcknowledgement.data!.c == null ||
                                  snapshotAcknowledgement.data!.c! == 'null'
                              ? marketDepth.close
                              : snapshotAcknowledgement.data!.c!;
                      marketDepth.open =
                          snapshotAcknowledgement.data!.o == null ||
                                  snapshotAcknowledgement.data!.o! == 'null'
                              ? marketDepth.open
                              : snapshotAcknowledgement.data!.o!;
                      marketDepth.high =
                          snapshotAcknowledgement.data!.h == null ||
                                  snapshotAcknowledgement.data!.h! == 'null'
                              ? marketDepth.high
                              : snapshotAcknowledgement.data!.h!;
                      marketDepth.low =
                          snapshotAcknowledgement.data!.l == null ||
                                  snapshotAcknowledgement.data!.l! == 'null'
                              ? marketDepth.low
                              : snapshotAcknowledgement.data!.l!;
                      marketDepth.bQty1 =
                          snapshotAcknowledgement.data!.bq1 == null ||
                                  snapshotAcknowledgement.data!.bq1! == 'null'
                              ? marketDepth.bQty1
                              : snapshotAcknowledgement.data!.bq1!;
                      marketDepth.bQty2 =
                          snapshotAcknowledgement.data!.bq2 == null ||
                                  snapshotAcknowledgement.data!.bq2! == 'null'
                              ? marketDepth.bQty2
                              : snapshotAcknowledgement.data!.bq2!;
                      marketDepth.bQty3 =
                          snapshotAcknowledgement.data!.bq3 == null ||
                                  snapshotAcknowledgement.data!.bq3! == 'null'
                              ? marketDepth.bQty3
                              : snapshotAcknowledgement.data!.bq3!;
                      marketDepth.bQty4 =
                          snapshotAcknowledgement.data!.bq4 == null ||
                                  snapshotAcknowledgement.data!.bq4! == 'null'
                              ? marketDepth.bQty4
                              : snapshotAcknowledgement.data!.bq4!;
                      marketDepth.bQty5 =
                          snapshotAcknowledgement.data!.bq5 == null ||
                                  snapshotAcknowledgement.data!.bq5! == 'null'
                              ? marketDepth.bQty5
                              : snapshotAcknowledgement.data!.bq5!;

                      marketDepth.sQty1 =
                          snapshotAcknowledgement.data!.sq1 == null ||
                                  snapshotAcknowledgement.data!.sq1! == 'null'
                              ? marketDepth.sQty1
                              : snapshotAcknowledgement.data!.sq1!;
                      marketDepth.sQty2 =
                          snapshotAcknowledgement.data!.sq2 == null ||
                                  snapshotAcknowledgement.data!.sq2! == 'null'
                              ? marketDepth.sQty2
                              : snapshotAcknowledgement.data!.sq2!;
                      marketDepth.sQty3 =
                          snapshotAcknowledgement.data!.sq3 == null ||
                                  snapshotAcknowledgement.data!.sq3! == 'null'
                              ? marketDepth.sQty3
                              : snapshotAcknowledgement.data!.sq3!;
                      marketDepth.sQty4 =
                          snapshotAcknowledgement.data!.sq4 == null ||
                                  snapshotAcknowledgement.data!.sq4! == 'null'
                              ? marketDepth.sQty4
                              : snapshotAcknowledgement.data!.sq4!;
                      marketDepth.sQty5 =
                          snapshotAcknowledgement.data!.sq5 == null ||
                                  snapshotAcknowledgement.data!.sq5! == 'null'
                              ? marketDepth.sQty5
                              : snapshotAcknowledgement.data!.sq5!;

                      marketDepth.bOrders1 =
                          snapshotAcknowledgement.data!.bo1 == null ||
                                  snapshotAcknowledgement.data!.bo1! == 'null'
                              ? marketDepth.bOrders1
                              : snapshotAcknowledgement.data!.bo1!;
                      marketDepth.bOrders2 =
                          snapshotAcknowledgement.data!.bo2 == null ||
                                  snapshotAcknowledgement.data!.bo2! == 'null'
                              ? marketDepth.bOrders2
                              : snapshotAcknowledgement.data!.bo2!;
                      marketDepth.bOrders3 =
                          snapshotAcknowledgement.data!.bo3 == null ||
                                  snapshotAcknowledgement.data!.bo3! == 'null'
                              ? marketDepth.bOrders3
                              : snapshotAcknowledgement.data!.bo3!;
                      marketDepth.bOrders4 =
                          snapshotAcknowledgement.data!.bo4 == null ||
                                  snapshotAcknowledgement.data!.bo4! == 'null'
                              ? marketDepth.bOrders4
                              : snapshotAcknowledgement.data!.bo4!;
                      marketDepth.bOrders5 =
                          snapshotAcknowledgement.data!.bo5 == null ||
                                  snapshotAcknowledgement.data!.bo5! == 'null'
                              ? marketDepth.bOrders5
                              : snapshotAcknowledgement.data!.bo5!;
                      marketDepth.sOrders1 =
                          snapshotAcknowledgement.data!.so1 == null ||
                                  snapshotAcknowledgement.data!.so1! == 'null'
                              ? marketDepth.sOrders1
                              : snapshotAcknowledgement.data!.so1!;
                      marketDepth.sOrders2 =
                          snapshotAcknowledgement.data!.so2 == null ||
                                  snapshotAcknowledgement.data!.so2! == 'null'
                              ? marketDepth.sOrders2
                              : snapshotAcknowledgement.data!.so2!;
                      marketDepth.sOrders3 =
                          snapshotAcknowledgement.data!.so3 == null ||
                                  snapshotAcknowledgement.data!.so3! == 'null'
                              ? marketDepth.sOrders3
                              : snapshotAcknowledgement.data!.so3!;
                      marketDepth.sOrders4 =
                          snapshotAcknowledgement.data!.so4 == null ||
                                  snapshotAcknowledgement.data!.so4! == 'null'
                              ? marketDepth.sOrders4
                              : snapshotAcknowledgement.data!.so4!;
                      marketDepth.sOrders5 =
                          snapshotAcknowledgement.data!.so5 == null ||
                                  snapshotAcknowledgement.data!.so5! == 'null'
                              ? marketDepth.sOrders5
                              : snapshotAcknowledgement.data!.so5!;

                      marketDepth.bPrice1 =
                          snapshotAcknowledgement.data!.bp1 == null ||
                                  snapshotAcknowledgement.data!.bp1! == 'null'
                              ? marketDepth.bPrice1
                              : snapshotAcknowledgement.data!.bp1!;
                      marketDepth.bPrice2 =
                          snapshotAcknowledgement.data!.bp2 == null ||
                                  snapshotAcknowledgement.data!.bp2! == 'null'
                              ? marketDepth.bPrice2
                              : snapshotAcknowledgement.data!.bp2!;
                      marketDepth.bPrice3 =
                          snapshotAcknowledgement.data!.bp3 == null ||
                                  snapshotAcknowledgement.data!.bp3! == 'null'
                              ? marketDepth.bPrice3
                              : snapshotAcknowledgement.data!.bp3!;
                      marketDepth.bPrice4 =
                          snapshotAcknowledgement.data!.bp4 == null ||
                                  snapshotAcknowledgement.data!.bp4! == 'null'
                              ? marketDepth.bPrice4
                              : snapshotAcknowledgement.data!.bp4!;
                      marketDepth.bPrice5 =
                          snapshotAcknowledgement.data!.bp5 == null ||
                                  snapshotAcknowledgement.data!.bp5! == 'null'
                              ? marketDepth.bPrice5
                              : snapshotAcknowledgement.data!.bp5!;

                      marketDepth.sPrice1 =
                          snapshotAcknowledgement.data!.sp1 == null ||
                                  snapshotAcknowledgement.data!.sp1! == 'null'
                              ? marketDepth.sPrice1
                              : snapshotAcknowledgement.data!.sp1!;
                      marketDepth.sPrice2 =
                          snapshotAcknowledgement.data!.sp2 == null ||
                                  snapshotAcknowledgement.data!.sp2! == 'null'
                              ? marketDepth.sPrice2
                              : snapshotAcknowledgement.data!.sp2!;
                      marketDepth.sPrice3 =
                          snapshotAcknowledgement.data!.sp3 == null ||
                                  snapshotAcknowledgement.data!.sp3! == 'null'
                              ? marketDepth.sPrice3
                              : snapshotAcknowledgement.data!.sp3!;
                      marketDepth.sPrice4 =
                          snapshotAcknowledgement.data!.sp4 == null ||
                                  snapshotAcknowledgement.data!.sp4! == 'null'
                              ? marketDepth.sPrice4
                              : snapshotAcknowledgement.data!.sp4!;
                      marketDepth.sPrice5 =
                          snapshotAcknowledgement.data!.sp5 == null ||
                                  snapshotAcknowledgement.data!.sp5! == 'null'
                              ? marketDepth.sPrice5
                              : snapshotAcknowledgement.data!.sp5!;
                      marketDepth.averagePrice =
                          snapshotAcknowledgement.data!.ap == null ||
                                  snapshotAcknowledgement.data!.ap! == 'null'
                              ? marketDepth.averagePrice
                              : snapshotAcknowledgement.data!.ap!;
                      marketDepth.volume =
                          snapshotAcknowledgement.data!.v == null ||
                                  snapshotAcknowledgement.data!.v! == 'null'
                              ? marketDepth.volume
                              : snapshotAcknowledgement.data!.v!;
                      marketDepth.lasttradedtime =
                          snapshotAcknowledgement.data!.ltt == null ||
                                  snapshotAcknowledgement.data!.ltt! == 'null'
                              ? marketDepth.lasttradedtime
                              : snapshotAcknowledgement.data!.ltt!;
                      marketDepth.lowercircuitlimit =
                          snapshotAcknowledgement.data!.lc == null ||
                                  snapshotAcknowledgement.data!.lc! == 'null'
                              ? marketDepth.lowercircuitlimit
                              : snapshotAcknowledgement.data!.lc!;
                      marketDepth.highercircuitlimit =
                          snapshotAcknowledgement.data!.uc == null ||
                                  snapshotAcknowledgement.data!.uc! == 'null'
                              ? marketDepth.highercircuitlimit
                              : snapshotAcknowledgement.data!.uc!;
                      marketDepth.lasttradedqty =
                          snapshotAcknowledgement.data!.ltq == null ||
                                  snapshotAcknowledgement.data!.ltq! == 'null'
                              ? marketDepth.lasttradedqty
                              : snapshotAcknowledgement.data!.ltq!;
                      marketDepth.ltp =
                          snapshotAcknowledgement.data!.lp == null ||
                                  snapshotAcknowledgement.data!.lp! == 'null'
                              ? marketDepth.ltp
                              : snapshotAcknowledgement.data!.lp!;
                      price = double.parse(marketDepth.ltp!);
                      marketDepth.perChange =
                          snapshotAcknowledgement.data!.pc == null ||
                                  snapshotAcknowledgement.data!.pc! == 'null'
                              ? marketDepth.perChange
                              : snapshotAcknowledgement.data!.pc!;
                      marketDepth.change = marketDepth.change == null
                          ? marketDepth.change
                          : (double.parse(marketDepth.ltp!) -
                                  double.parse(marketDepth.close!))
                              .toStringAsFixed(2);
                      buyPrice = (double.parse(marketDepth.ltp!));

                      pChange =
                          num.tryParse("${marketDepth.perChange}")?.toDouble();

                      che = num.tryParse("${marketDepth.change}")?.toDouble();
                    }
                  }

                  return StreamBuilder(
                    stream: WebSocketConnection.dpStream.stream
                        .where((event) => event.tk == marketDepth.token),
                    builder: (_, AsyncSnapshot<DepthWSResponse> snapshot) {
                      if (snapshot.data != null) {
                        if (snapshot.data!.tk == marketDepth.token) {
                          WebSocketConnection.datacontroller.add(snapshot.data);
                          marketDepth.ltp = snapshot.data!.lp == null ||
                                  snapshot.data!.lp! == '0'
                              ? marketDepth.ltp
                              : snapshot.data!.lp!;
                          price = double.parse(marketDepth.ltp!);
                          marketDepth.perChange = snapshot.data!.pc == null ||
                                  snapshot.data!.pc! == '0'
                              ? marketDepth.perChange
                              : snapshot.data!.pc!;
                          marketDepth.close = snapshot.data!.c == null ||
                                  snapshot.data!.c! == '0'
                              ? marketDepth.close
                              : snapshot.data!.c!;

                          marketDepth.bQty1 = snapshot.data!.bq1 == null ||
                                  snapshot.data!.c! == '0'
                              ? marketDepth.bQty1
                              : snapshot.data!.bq1!;
                          marketDepth.bQty2 = snapshot.data!.bq2 == null ||
                                  snapshot.data!.c! == '0'
                              ? marketDepth.bQty2
                              : snapshot.data!.bq2!;
                          marketDepth.bQty3 = snapshot.data!.bq3 == null ||
                                  snapshot.data!.c! == '0'
                              ? marketDepth.bQty3
                              : snapshot.data!.bq3!;
                          marketDepth.bQty4 = snapshot.data!.bq4 == null ||
                                  snapshot.data!.c! == '0'
                              ? marketDepth.bQty4
                              : snapshot.data!.bq4!;
                          marketDepth.bQty5 = snapshot.data!.bq5 == null ||
                                  snapshot.data!.c! == '0'
                              ? marketDepth.bQty5
                              : snapshot.data!.bq5!;

                          marketDepth.sQty1 = snapshot.data!.sq1 == null ||
                                  snapshot.data!.c! == '0'
                              ? marketDepth.sQty1
                              : snapshot.data!.sq1!;
                          marketDepth.sQty2 = snapshot.data!.sq2 == null ||
                                  snapshot.data!.c! == '0'
                              ? marketDepth.sQty2
                              : snapshot.data!.sq2!;
                          marketDepth.sQty3 = snapshot.data!.sq3 == null ||
                                  snapshot.data!.c! == '0'
                              ? marketDepth.sQty3
                              : snapshot.data!.sq3!;
                          marketDepth.sQty4 = snapshot.data!.sq4 == null ||
                                  snapshot.data!.c! == '0'
                              ? marketDepth.sQty4
                              : snapshot.data!.sq4!;
                          marketDepth.sQty5 = snapshot.data!.sq5 == null ||
                                  snapshot.data!.c! == '0'
                              ? marketDepth.sQty5
                              : snapshot.data!.sq5!;

                          marketDepth.bOrders1 = snapshot.data!.bo1 == null ||
                                  snapshot.data!.bo1! == '0'
                              ? marketDepth.bOrders1
                              : snapshot.data!.bo1!;
                          marketDepth.bOrders2 = snapshot.data!.bo2 == null ||
                                  snapshot.data!.bo2! == '0'
                              ? marketDepth.bOrders2
                              : snapshot.data!.bo2!;
                          marketDepth.bOrders3 = snapshot.data!.bo3 == null ||
                                  snapshot.data!.bo3! == '0'
                              ? marketDepth.bOrders3
                              : snapshot.data!.bo3!;
                          marketDepth.bOrders4 = snapshot.data!.bo4 == null ||
                                  snapshot.data!.bo4! == '0'
                              ? marketDepth.bOrders4
                              : snapshot.data!.bo4!;
                          marketDepth.bOrders5 = snapshot.data!.bo5 == null ||
                                  snapshot.data!.bo5! == '0'
                              ? marketDepth.bOrders5
                              : snapshot.data!.bo5!;
                          marketDepth.sOrders1 = snapshot.data!.so1 == null ||
                                  snapshot.data!.so1! == '0'
                              ? marketDepth.sOrders1
                              : snapshot.data!.so1!;
                          marketDepth.sOrders2 = snapshot.data!.so2 == null ||
                                  snapshot.data!.so2! == '0'
                              ? marketDepth.sOrders2
                              : snapshot.data!.so2!;
                          marketDepth.sOrders3 = snapshot.data!.so3 == null ||
                                  snapshot.data!.so3! == '0'
                              ? marketDepth.sOrders3
                              : snapshot.data!.so3!;
                          marketDepth.sOrders4 = snapshot.data!.so4 == null ||
                                  snapshot.data!.so4! == '0'
                              ? marketDepth.sOrders4
                              : snapshot.data!.so4!;
                          marketDepth.sOrders5 = snapshot.data!.so5 == null ||
                                  snapshot.data!.so5! == '0'
                              ? marketDepth.sOrders5
                              : snapshot.data!.so5!;

                          marketDepth.bPrice1 = snapshot.data!.bp1 == null ||
                                  snapshot.data!.bp1! == '0'
                              ? marketDepth.bPrice1
                              : snapshot.data!.bp1!;
                          marketDepth.bPrice2 = snapshot.data!.bp2 == null ||
                                  snapshot.data!.bp2! == '0'
                              ? marketDepth.bPrice2
                              : snapshot.data!.bp2!;
                          marketDepth.bPrice3 = snapshot.data!.bp3 == null ||
                                  snapshot.data!.bp3! == '0'
                              ? marketDepth.bPrice3
                              : snapshot.data!.bp3!;
                          marketDepth.bPrice4 = snapshot.data!.bp4 == null ||
                                  snapshot.data!.bp4! == '0'
                              ? marketDepth.bPrice4
                              : snapshot.data!.bp4!;
                          marketDepth.bPrice5 = snapshot.data!.bp5 == null ||
                                  snapshot.data!.bp5! == '0'
                              ? marketDepth.bPrice5
                              : snapshot.data!.bp5!;

                          marketDepth.sPrice1 = snapshot.data!.sp1 == null ||
                                  snapshot.data!.sp1! == '0'
                              ? marketDepth.sPrice1
                              : snapshot.data!.sp1!;
                          marketDepth.sPrice2 = snapshot.data!.sp2 == null ||
                                  snapshot.data!.sp2! == '0'
                              ? marketDepth.sPrice2
                              : snapshot.data!.sp2!;
                          marketDepth.sPrice3 = snapshot.data!.sp3 == null ||
                                  snapshot.data!.sp3! == '0'
                              ? marketDepth.sPrice3
                              : snapshot.data!.sp3!;
                          marketDepth.sPrice4 = snapshot.data!.sp4 == null ||
                                  snapshot.data!.sp4! == '0'
                              ? marketDepth.sPrice4
                              : snapshot.data!.sp4!;
                          marketDepth.sPrice5 = snapshot.data!.sp5 == null ||
                                  snapshot.data!.sp5! == '0'
                              ? marketDepth.sPrice5
                              : snapshot.data!.sp5!;
                          marketDepth.averagePrice =
                              snapshot.data!.ap == null ||
                                      snapshot.data!.ap! == '0'
                                  ? marketDepth.averagePrice
                                  : snapshot.data!.ap!;
                          marketDepth.volume = snapshot.data!.v == null ||
                                  snapshot.data!.v! == '0'
                              ? marketDepth.volume
                              : snapshot.data!.v!;
                          marketDepth.lasttradedtime =
                              snapshot.data!.ltt == null ||
                                      snapshot.data!.ltt! == '0' ||
                                      snapshot.data!.ltt! == 'null'
                                  ? marketDepth.lasttradedtime
                                  : snapshot.data!.ltt!;
                          marketDepth.lowercircuitlimit =
                              snapshot.data!.lc == null ||
                                      snapshot.data!.lc! == '0'
                                  ? marketDepth.lowercircuitlimit
                                  : snapshot.data!.lc!;
                          marketDepth.highercircuitlimit =
                              snapshot.data!.uc == null ||
                                      snapshot.data!.uc! == '0'
                                  ? marketDepth.highercircuitlimit
                                  : snapshot.data!.uc!;
                          marketDepth.lasttradedqty =
                              snapshot.data!.ltq == null ||
                                      snapshot.data!.ltq! == '0'
                                  ? marketDepth.lasttradedqty
                                  : snapshot.data!.ltq!;
                          marketDepth.change = marketDepth.change == null ||
                                  marketDepth.change == "0.00" ||
                                  marketDepth.change == "00.00"
                              ? marketDepth.change
                              : (double.parse(marketDepth.ltp!) -
                                      double.parse(marketDepth.close!))
                                  .toStringAsFixed(2);
                          buyPrice = (double.parse(marketDepth.ltp!));
                          pChange = num.tryParse("${marketDepth.perChange}")
                              ?.toDouble();

                          che =
                              num.tryParse("${marketDepth.change}")?.toDouble();
                        }
                        return scriptInfoData(
                            size, che, pChange, context, symbolName);
                      } else {
                        return scriptInfoData(
                            size, che, pChange, context, symbolName);
                      }
                    },
                  );
                }),
          ),
        ),
      );
    });
  }

  Column scriptInfoData(
      Size size, che, pChange, BuildContext context, String symbolName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${marketDepth.symbolname}",
              style: depthSymbolNameTextStyle(size),
            ),
            Text(
              "${marketDepth.ltp}",
              style: depthSymbolNameTextStyle(size),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${marketDepth.exc}",
              style: listSubTitle(size),
            ),
            Text(
              " $che ($pChange%)",
              style: listSubTitle(size),
            ),
          ],
        ),
        sizedHeight(size),
        Row(
          children: [
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: isDepth ? Colors.black : Colors.white),
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
                  style:
                      TextStyle(color: isDepth ? Colors.white : Colors.black),
                )),
            const SizedBox(
              width: 12,
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: isDepth ? Colors.white : Colors.black),
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
                  style:
                      TextStyle(color: isDepth ? Colors.black : Colors.white),
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
                  const Center(child: Text("B-Id")),
                  Text("${marketDepth.bPrice1}"),
                  Text("${marketDepth.bPrice2}"),
                  Text("${marketDepth.bPrice3}"),
                  Text("${marketDepth.bPrice4}"),
                  Text("${marketDepth.bPrice5}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Ords"),
                  Text("${marketDepth.bOrders1}"),
                  Text("${marketDepth.bOrders2}"),
                  Text("${marketDepth.bOrders3}"),
                  Text("${marketDepth.bOrders4}"),
                  Text("${marketDepth.bOrders5}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Qty"),
                  Text("${marketDepth.bQty1}"),
                  Text("${marketDepth.bQty2}"),
                  Text("${marketDepth.bQty3}"),
                  Text("${marketDepth.bQty4}"),
                  Text("${marketDepth.bQty5}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("S-Id"),
                  Text("${marketDepth.sPrice1}"),
                  Text("${marketDepth.sPrice2}"),
                  Text("${marketDepth.sPrice3}"),
                  Text("${marketDepth.sPrice4}"),
                  Text("${marketDepth.sPrice5}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Ords"),
                  Text("${marketDepth.sOrders1}"),
                  Text("${marketDepth.sOrders2}"),
                  Text("${marketDepth.sOrders3}"),
                  Text("${marketDepth.sOrders4}"),
                  Text("${marketDepth.sOrders5}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Qty"),
                  Text("${marketDepth.sQty1}"),
                  Text("${marketDepth.sQty2}"),
                  Text("${marketDepth.sQty3}"),
                  Text("${marketDepth.sQty4}"),
                  Text("${marketDepth.sQty5}"),
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
                  "https://advanced-charts.web.app/?symbol=$symbolName&token=${marketDepth.token}",
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
                        const Text("High"),
                        Text("${marketDepth.high}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Open"),
                        Text("${marketDepth.open}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Vol"),
                        Text("${marketDepth.volume}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("LTQ"),
                        Text("${marketDepth.lasttradedqty}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("LCL"),
                        Text("${marketDepth.lowercircuitlimit}"),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Text("Low"), Text("${marketDepth.low}")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Close"),
                        Text("${marketDepth.close}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Avg.Price"),
                        Text("${marketDepth.averagePrice}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("LTT"),
                        Text("${marketDepth.lasttradedtime}")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("UCL"),
                        Text("${marketDepth.highercircuitlimit}")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future scriptInfo(exchange, token) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.secInfo),
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
          ScriptInfoModel.segment = ScriptInfoModel.scriptInfoRes['seg'];
          ScriptInfoModel.lotSize =
              int.parse("${ScriptInfoModel.scriptInfoRes['ls']}");
          ScriptInfoModel.frzQty = ScriptInfoModel.scriptInfoRes['frzqty'];
          ScriptInfoModel.tikTik = ScriptInfoModel.scriptInfoRes['ti'];
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(sb.unSuccessBar("Session Expired"));
      }
    } catch (e) {}
  }
}
