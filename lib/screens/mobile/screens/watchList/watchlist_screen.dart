// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../api/api_links.dart';
import '../../../../constant/constants.dart';
import 'package:http/http.dart' as http;

import '../../../../constant/model/models.dart';
import '../../../../themes/theme_model.dart';
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

class _WatchlistScreenState extends State<WatchlistScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
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
    setState(() {
      marketWatchList(1);
    });
    _tabController.addListener(_getActiveTabIndex);
  }

  void _getActiveTabIndex() {
    setState(() {
      WatchListModel.selectedIndex = _tabController.index + 1;
      marketWatchList(WatchListModel.selectedIndex);
    });
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
      return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
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
                      return WatchListModel.watchList.isEmpty
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
                              itemCount: WatchListModel.watchList.length,
                              itemBuilder: (context, index) {
                                const String find = "-EQ";
                                const String rePlace = "";
                                var symbolName = (WatchListModel
                                    .watchList[index]["tsym"]
                                    .replaceAll(find, rePlace));
                                // .cast<String, dynamic>();

                                var tokenVal =
                                    WatchListModel.watchList[index]["token"];
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
                                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const WatchListInfo(
                                          // symbolName: widget.watchlists[index].symbolName,
                                          // exchange: widget.watchlists[index].exc,
                                          // lTp: widget.watchlists[index].ltp,
                                          // perChange: widget.watchlists[index].perChange,
                                          // token: widget.watchlists[index].tokenValue,
                                          ))),
                                  onLongPress: () => Navigator.pushNamed(
                                      context, 'editWatchlist'),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: size.height * .0065),
                                    height: size.height * .061,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Visibility(
                                        //   visible: hideLogo,
                                        //   child: Column(
                                        //     mainAxisAlignment: MainAxisAlignment.start,
                                        //     crossAxisAlignment: CrossAxisAlignment.start,
                                        //     children: [scriptLogo(imageCircle, tokenVal, symbolName, size)],
                                        //   ),
                                        // ),
                                        Expanded(
                                          child: Container(
                                            margin: hideLogo
                                                ? const EdgeInsets.fromLTRB(
                                                    10, 4.3, 0, 4.3)
                                                : const EdgeInsets.fromLTRB(
                                                    0, 4.6, 0, 4.6),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      WatchListModel
                                                          .watchList[index]
                                                              ["tsym"]
                                                          .toString()
                                                          .replaceAll(
                                                              "-EQ", ""),
                                                      style: listTitle(size),
                                                    ),
                                                    Text(
                                                      WatchListModel
                                                              .watchList[index]
                                                          ["ti"],
                                                      // style: widget.watchlists[index].ltp > 0
                                                      //     ? ltpUpTextStyle(size)
                                                      //     : ltpDownTextStyle(size),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      WatchListModel
                                                              .watchList[index]
                                                          ["exch"],
                                                      style: listSubTitle(size),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              // widget.watchlists[index].perChange > 0
                                                              //     ?
                                                              pcUpBackground(),
                                                          // : pcDownBackground(),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                5.0, 1, 5, 3),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              WatchListModel
                                                                      .watchList[
                                                                  index]["ls"],
                                                              // style: widget.watchlists[index].perChange > 0
                                                              //     ? pcUpTextStyle(size)
                                                              //     : pcDownTextStyle(size),
                                                            ),
                                                            // widget.watchlists[index].perChange > 0
                                                            //     ?
                                                            SvgPicture.asset(
                                                                "assets/arrowUp.svg")
                                                            // : SvgPicture.asset("assets/arrowDown.svg"),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
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
        ),
      );
    });
  }

  PopupMenuButton<int> popMenu(Size size) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        // PopupMenuItem(
        //   value: 1,
        //   child: Row(
        //     children: [
        //       Icon(
        //         hideLogo ? Icons.hide_image_outlined : Icons.image_outlined,
        //         size: 18,
        //       ),
        //       const SizedBox(
        //         width: 10,
        //       ),
        //       Text(
        //         hideLogo ? "Hide Logo" : "Show Logo",
        //         style: txtBtnTextStyle(size),
        //       )
        //     ],
        //   ),
        // ),
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
        // PopupMenuItem(
        //   value: 4,
        //   child: Row(
        //     children: [
        //       const Icon(
        //         Icons.price_change_outlined,
        //         size: 20,
        //       ),
        //       const SizedBox(
        //         width: 10,
        //       ),
        //       Text(
        //         "LTP",
        //         style: txtBtnTextStyle(size),
        //       )
        //     ],
        //   ),
        // ),
        // PopupMenuItem(
        //   value: 5,
        //   child: Row(
        //     children: [
        //       const Icon(
        //         Icons.percent_outlined,
        //         size: 20,
        //       ),
        //       const SizedBox(
        //         width: 10,
        //       ),
        //       Text(
        //         "Percentage",
        //         style: txtBtnTextStyle(size),
        //       )
        //     ],
        //   ),
        // ),
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
            WatchListModel.watchList.sort((a, b) {
              return a['tsym'].toLowerCase().compareTo(b['tsym'].toLowerCase());
            });
          });
        } else if (value == 2) {
          setState(() {
            WatchListModel.watchList.sort((a, b) {
              return b['tsym'].toLowerCase().compareTo(a['tsym'].toLowerCase());
            });
          });
        }
        //else if (value == 4) {
        //   setState(() {
        //     widget.watchlists.sort((a, b) {
        //       return a.ltp.compareTo(b.ltp);
        //     });
        //   });
        // } else if (value == 5) {
        //   setState(() {
        //     widget.watchlists.sort((a, b) {
        //       return a.perChange.compareTo(b.perChange);
        //     });
        //   });
        // }
      },
    );
  }

  Future marketWatchList(selectedIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      ConstVariable.sessionId = prefs.getString('userSession')!;
      ConstVariable.userId = prefs.getString('userId')!;
    } catch (e) {}
    http.Response response = await http.post(Uri.parse(ApiLinks.marketWatch),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body:
            '''jData={"uid":"${ConstVariable.userId}","wlname":"$selectedIndex"}&jKey=${ConstVariable.sessionId}''');

    Map mapRes = json.decode(response.body);

    print(mapRes);
    if (mapRes['stat'] == "Ok") {
      setState(() {
        WatchListModel.watchList = mapRes["values"];
        log("${WatchListModel.watchList}");
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
