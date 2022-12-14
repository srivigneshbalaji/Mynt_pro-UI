// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
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

enum Options {
  symbolAsc,
  symbolDesc,
  ltp,
  perChange,
}

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({
    super.key,
  });

  static const String routeName = 'watchList';
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
  bool _isLoaderVisible = false;
  late TabController _tabController;
  final MySnackBars sb = MySnackBars();
  final List<Tab> mWLTabs = <Tab>[
    const Tab(text: 'WL 1'),
    const Tab(text: 'WL 2'),
    const Tab(text: 'WL 3'),
    const Tab(text: 'WL 4'),
    const Tab(text: 'WL 5'),
  ];
  var popupMenuItemIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: mWLTabs.length, vsync: this);
    super.initState();
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
    _tabController.dispose();
    super.dispose();
  }

  String addExchange = "";
  String addToken = "";
  String addScripts = "";
  String delExchange = "";
  String delToken = "";
  String delScripts = "";

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
                                      fetchMWList: marketWatchList)),
                              (route) => true),
                          icon: const Icon(
                            Icons.search,
                            color: Color(0xff7B7B7B),
                          ),
                        ),
                        PopupMenuButton(
                          icon: Icon(Icons.sort),
                          onSelected: (value) {
                            _onMenuItemSelected(value as int);
                          },
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          itemBuilder: (ctx) => [
                            _buildPopupMenuItem(
                                'SYMBOL ASC', Options.symbolAsc.index, size),
                            _buildPopupMenuItem(
                                'SYMBOL DESC', Options.symbolDesc.index, size),
                            _buildPopupMenuItem('LTP', Options.ltp.index, size),
                            _buildPopupMenuItem(
                                'PER.CHANGE', Options.perChange.index, size),
                          ],
                        )
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
                  child: LoaderOverlay(
                    useDefaultLoading: true,
                    overlayColor: Colors.white,
                    overlayOpacity: 1,
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
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchScreen(
                                                          fetchMWList:
                                                              marketWatchList)),
                                              (route) => true);
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
                            : ReorderableListView.builder(
                                itemCount: WatchListModel.mWatchList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    key: ValueKey(index),
                                    onTap: () {
                                      var exc = WatchListModel.mWatchList[index]
                                              ["exch"]
                                          .toString();
                                      var token = WatchListModel
                                          .mWatchList[index]["token"]
                                          .toString();
                                      Map watchlistDepth = {
                                        "exch": exc,
                                        "token": token
                                      };
                                      WebSocketConnection.estcon(
                                          "u", WatchListModel.mWatchList, true);
                                      WebSocketConnection.estcon(
                                          "d", watchlistDepth, false);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WatchListInfo(
                                                    scriptName: WatchListModel
                                                            .mWatchList[index]
                                                        ["tsym"],
                                                    marketDepth: ConstVariable
                                                        .mdpdata![index],
                                                    token: WatchListModel
                                                            .mWatchList[index]
                                                        ["token"],
                                                    exchange: WatchListModel
                                                            .mWatchList[index]
                                                        ["exch"],
                                                  )));
                                    },
                                    child: WatchListData(
                                        data: ConstVariable.data![index]),
                                  );
                                },
                                onReorder: (int oldIndex, int newIndex) {
                                  delScripts = "";
                                  for (var i = 0;
                                      i < WatchListModel.mWatchList.length;
                                      i++) {
                                    setState(() {
                                      delExchange =
                                          WatchListModel.mWatchList[i]['exch'];
                                      delToken =
                                          WatchListModel.mWatchList[i]['token'];

                                      delScripts += "$delExchange|$delToken#";
                                    });
                                  }

                                  setState(() {
                                    if (newIndex > oldIndex) {
                                      newIndex = newIndex - 1;
                                    }

                                    final element = WatchListModel.mWatchList
                                        .removeAt(oldIndex);
                                    WatchListModel.mWatchList
                                        .insert(newIndex, element);
                                  });
                                  log("AFTER REORDER ::: ${WatchListModel.mWatchList}");
                                  addScripts = "";
                                  for (var i = 0;
                                      i < WatchListModel.mWatchList.length;
                                      i++) {
                                    setState(() {
                                      addExchange =
                                          WatchListModel.mWatchList[i]['exch'];
                                      addToken =
                                          WatchListModel.mWatchList[i]['token'];
                                      addScripts += "$addExchange|$addToken#";
                                    });
                                  }
                                  deleteScript(delScripts);
                                },
                              );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, int position, Size size) {
    return PopupMenuItem(
      value: position,
      child: Text(
        title,
        style: txtBtnTextStyle(size),
      ),
    );
  }

  _onMenuItemSelected(int value) {
    setState(() {
      popupMenuItemIndex = value;
    });
    delScripts = "";
    for (var i = 0; i < WatchListModel.mWatchList.length; i++) {
      setState(() {
        delExchange = WatchListModel.mWatchList[i]['exch'];
        delToken = WatchListModel.mWatchList[i]['token'];

        delScripts += "$delExchange|$delToken#";
      });
    }
    deleteScript(delScripts);
    if (value == Options.symbolAsc.index) {
      WatchListModel.mWatchList.sort((a, b) {
        return a['tsym'].toLowerCase().compareTo(b['tsym'].toLowerCase());
      });
      addScripts = "";
      for (var i = 0; i < WatchListModel.mWatchList.length; i++) {
        setState(() {
          addExchange = WatchListModel.mWatchList[i]['exch'];
          addToken = WatchListModel.mWatchList[i]['token'];
          addScripts += "$addExchange|$addToken#";
        });
      }
    } else if (value == Options.symbolDesc.index) {
      WatchListModel.mWatchList.sort((a, b) {
        return b['tsym'].toLowerCase().compareTo(a['tsym'].toLowerCase());
      });
      addScripts = "";
      for (var i = 0; i < WatchListModel.mWatchList.length; i++) {
        setState(() {
          addExchange = WatchListModel.mWatchList[i]['exch'];
          addToken = WatchListModel.mWatchList[i]['token'];
          addScripts += "$addExchange|$addToken#";
        });
      }
    } else if (value == Options.ltp.index) {
      WatchListModel.mWatchList.sort((a, b) {
        return a['ltp'].compareTo(b['ltp']);
      });
      addScripts = "";
      for (var i = 0; i < WatchListModel.mWatchList.length; i++) {
        setState(() {
          addExchange = WatchListModel.mWatchList[i]['exch'];
          addToken = WatchListModel.mWatchList[i]['token'];
          addScripts += "$addExchange|$addToken#";
        });
      }
    } else if (value == Options.perChange.index) {
      WatchListModel.mWatchList.sort((a, b) {
        return a['perChange'].compareTo(b['perChange']);
      });
      addScripts = "";
      for (var i = 0; i < WatchListModel.mWatchList.length; i++) {
        setState(() {
          addExchange = WatchListModel.mWatchList[i]['exch'];
          addToken = WatchListModel.mWatchList[i]['token'];
          addScripts += "$addExchange|$addToken#";
        });
      }
    }
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
      createSession();
      marketWatchList(1);
    } else {}
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
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.marketWatch),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}","wlname":"$selectedIndex"}&jKey=${ConstVariable.sessionId}''');

      Map mapRes = json.decode(response.body);
      if (mapRes['stat'] == "Ok") {
        if (mounted) {
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
        }

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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          sb.unSuccessBar("Connection issue, Please Try again later"));
    }
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
  }

  Future addScript(addScripts) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.addScrip),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}","wlname":"${WatchListModel.selectedIndex}","scrips":"$addScripts"}&jKey=${ConstVariable.sessionId}''');

      Map mapRes = json.decode(response.body);
      log("$mapRes");
      if (mapRes['stat'] == "Ok") {
        ScaffoldMessenger.of(context)
            .showSnackBar(sb.successBar("Script Sorted"));
        marketWatchList(WatchListModel.selectedIndex);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
    }
  }

  Future deleteScript(script) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.deleteScrip),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}","wlname":"${WatchListModel.selectedIndex}","scrips":"$script"}&jKey=${ConstVariable.sessionId}''');

      Map mapRes = json.decode(response.body);
      log("$mapRes");
      if (mapRes['stat'] == "Ok") {
        // marketWatchList(WatchListModel.selectedIndex);
        addScript(addScripts);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
    }
  }
}
