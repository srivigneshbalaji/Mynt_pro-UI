// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:mynt_pro/screens/mobile/screens/watchList/watchlist_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../api/api_links.dart';
import '../../../../constant/constants.dart';
import 'package:http/http.dart' as http;
import '../../../../functions/user_detail.dart';
import '../../../../model/models.dart';
import '../../../../constant/snackbar.dart';
import '../../../../functions/client_detail.dart';
import '../../../../themes/theme_model.dart';
import '../../../../web_socket/web_sockts.dart';
import '../screens.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({
    super.key,
  });

  static const String routeName = 'WatchListModel.watchList';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const WatchlistScreen(),
    );
  }

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

List<Values>? data;

class _WatchlistScreenState extends State<WatchlistScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MySnackBars sb = MySnackBars();
  bool hideLogo = true;
  final List<Tab> mWLTabs = <Tab>[
    const Tab(text: 'WL 1'),
    const Tab(text: 'WL 2'),
    const Tab(text: 'WL 3'),
    const Tab(text: 'WL 4'),
    const Tab(text: 'WL 5'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: mWLTabs.length, vsync: this);
    super.initState();

    // marketWatchList(1);
    closeSession();

    _tabController.addListener(_getActiveTabIndex);
  }

  void _getActiveTabIndex() {
    if (mounted) {
      setState(() {
        WatchListModel.selectedIndex = _tabController.index + 1;
        marketWatchList(WatchListModel.selectedIndex);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          backgroundColor: themeNotifier.isDark ? Colors.black : Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          enableDrag: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () => Navigator.pop(context),
                                    )),
                                const Text('BottomSheet'),
                              ],
                            );
                          },
                        );
                      },
                      child: SizedBox(
                        height: 33,
                        child: Center(
                          child: Text(
                            " My Watchlists ",
                            style: watchListTextStyle(size),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          tooltip: "Add Script",
                          onPressed: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchScreen(
                                      callFunction: marketWatchList)),
                              (route) => true),
                          icon: const Icon(
                            Icons.search,
                            color: Color(0xff7B7B7B),
                          ),
                        ),
                        popMenu(size),
                      ],
                    )
                  ],
                ),
                // const SizedBox(
                //   height: 4,
                // ),
                Container(
                  height: 45,
                  width: size.width,
                  decoration: BoxDecoration(
                    // color: Colors.grey[300],
                    // borderRadius: BorderRadius.circular(
                    //   25.0,
                    // ),
                    border: Border(
                      bottom: BorderSide(
                        color: themeNotifier.isDark
                            ? Colors.white12
                            : Colors.black12,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: TabBar(
                      isScrollable: true,
                      labelStyle: tabBtnTextStyle(size),
                      unselectedLabelStyle: tabBtnTextStyle(size),
                      indicatorColor: Colors.blue,
                      controller: _tabController,
                      labelColor: Colors.blue,
                      unselectedLabelColor:
                          themeNotifier.isDark ? Colors.white : Colors.black,
                      onTap: ((tabIndex) {
                        _getActiveTabIndex();
                      }),
                      tabs: mWLTabs),
                ),
                // tab bar view here
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: mWLTabs.map((Tab tab) {
                      return WatchListModel.mWatchList.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "This WatchList has no symbols",
                                    style: noDataTextStyle(size),
                                  ),
                                  TextButton.icon(
                                      onPressed: () {
                                        Navigator.pushNamed(context, 'search');
                                      },
                                      icon: const Icon(
                                        Icons.add_box_outlined,
                                        color: Colors.grey,
                                      ),
                                      label: Text(
                                        "Add script",
                                        style: listSubTitle(size),
                                      ))
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: WatchListModel.mWatchList.length,
                              itemBuilder: (context, index) {
                                // Future<bool> imageCircle(
                                //     tokenVal, symName) async {
                                //   var request = http.Request(
                                //       'GET',
                                //       Uri.parse(
                                //           'https://besim.zebull.in/static/equity/icons/${tokenVal}_$symbolName.webp'));

                                //   http.StreamedResponse response =
                                //       await request.send();

                                //   if (response.statusCode == 200) {
                                //     return true;
                                //   } else {
                                //     return false;
                                //   }
                                // }

                                return InkWell(
                                  onTap: () {
                                    var exc = WatchListModel.mWatchList[index]
                                            ["exch"]
                                        .toString();
                                    var token = WatchListModel.mWatchList[index]
                                            ["token"]
                                        .toString();
                                    Map watchlistDepth = {
                                      "exch": exc,
                                      "token": token
                                    };
                                    WebSocketConnection.estcon(
                                        "u", WatchListModel.mWatchList, true);
                                    WebSocketConnection.estcon(
                                        "d", watchlistDepth, false);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => WatchListInfo(
                                                  marketDepth: ConstVariable
                                                      .mdpdata![index],
                                                  exchange: WatchListModel
                                                          .mWatchList[index]
                                                      ["exch"],
                                                )));
                                  },

                                  // => Navigator.of(context)
                                  //     .push(MaterialPageRoute(
                                  //         builder: (context) => WatchListInfo(
                                  //               exchange: WatchListModel
                                  //                   .mWatchList[index]["exch"],
                                  //               token: WatchListModel
                                  //                   .mWatchList[index]["token"],
                                  //               scriptName: WatchListModel
                                  //                   .mWatchList[index]["tsym"],
                                  //             ))),
                                  onLongPress: () => Navigator.pushNamed(
                                      context, 'editWatchlist'),
                                  child: WatchListData(
                                    data: ConstVariable.data![index],
                                  ),
                                );
                              },
                            );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  PopupMenuButton<int> popMenu(Size size) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              const Icon(
                Icons.sort_by_alpha,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "A ⇒ Z",
                style: txtBtnTextStyle(size),
              )
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              const Icon(
                Icons.sort_by_alpha,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Z ⇒ A",
                style: txtBtnTextStyle(size),
              )
            ],
          ),
        ),
      ],
      offset: const Offset(0, 35),
      elevation: 2,
      onSelected: (value) {
        // if (value == 1) {
        //   setState(() {
        //     hideLogo = !hideLogo;
        //   });
        // } else

        if (value == 1) {
          setState(() {
            WatchListModel.mWatchList.sort((a, b) {
              return a['tsym'].toLowerCase().compareTo(b['tsym'].toLowerCase());
            });
          });
        } else if (value == 2) {
          setState(() {
            WatchListModel.mWatchList.sort((a, b) {
              return b['tsym'].toLowerCase().compareTo(a['tsym'].toLowerCase());
            });
          });
        }
      },
    );
  }

  Future closeSession() async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST',
        Uri.parse('http://154.83.3.25:8889/NorenWsHelper/InvalidateSess'));
    request.bodyFields = {
      'uid': ConstVariable.userId,
      'usession': ConstVariable.sessionId,
      'src': 'MOB'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      createSession();
      marketWatchList(1);
    } else {
      // print(response.reasonPhrase);
    }
  }

  Future createSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      ConstVariable.userId = prefs.getString('userId')!;
      ConstVariable.sessionId = prefs.getString('userSession')!;
    } catch (e) {}
    var bytes = utf8.encode(ConstVariable.sessionId);
    final bytes1 = utf8.encode(sha256.convert(bytes).toString());
    ConstVariable.sha556Session = sha256.convert(bytes1).toString();

    print(ConstVariable.sha556Session);
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('http://154.83.3.25:8889/NorenWsHelper/CreateSess'));
    request.bodyFields = {
      'uid': ConstVariable.userId,
      'usession': ConstVariable.sessionId,
      'src': 'MOB',
      'vcode': 'STONE_AGE'
    };

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future marketWatchList(selectedIndex) async {
    http.Response response = await http.post(Uri.parse(ApiLinks.marketWatch),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body:
            '''jData={"uid":"${ConstVariable.userId}","wlname":"$selectedIndex"}&jKey=${ConstVariable.sessionId}''');

    Map mapRes = json.decode(response.body);
    if (mapRes['stat'] == "Ok") {
      setState(() {
        WatchListModel.mWatchList = mapRes["values"];
        final resp = MarketWatchScrips.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        ConstVariable.data = resp.values;
        final depthDesp = MarketDepthScrips.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
        ConstVariable.mdpdata = depthDesp.mdpdata;
        clientDetail(context: context);
        userDetail(context: context);
        log("MarkWatchList Data's :*: ${WatchListModel.mWatchList}");
      });

      setState(() {
        if (WebSocketConnection.wsConnected == false) {
          WebSocketConnection.estcon("t", WatchListModel.mWatchList, false);
        } else {
          WebSocketConnection.estcon("t", WatchListModel.mWatchList, true);
        }
      });
    } else {
      if (mapRes['emsg'] == "Session Expired :  Invalid Session Key") {
        Navigator.pushNamed(context, 'logIn');
        ScaffoldMessenger.of(context)
            .showSnackBar(sb.unSuccessBar("Session Expired"));
      }
    }
  }
}
