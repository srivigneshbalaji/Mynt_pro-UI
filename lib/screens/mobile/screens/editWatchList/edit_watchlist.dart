// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import '../../../../api/api_links.dart';
// import '../../../../constant/constants.dart';
// import '../../../../constant/snackbar.dart';
// import '../../../../model/models.dart';
// import '../../../../themes/theme_model.dart';

// class EditWatchList extends StatefulWidget {
//   final Function fetchMWList;

//   const EditWatchList({super.key, required this.fetchMWList});

//   @override
//   State<EditWatchList> createState() => _EditWatchListState(this.fetchMWList);
//   // static const String routeName = 'editWatchlist';
//   // static Route route() {
//   //   return MaterialPageRoute(
//   //     settings: const RouteSettings(name: routeName),
//   //     builder: (_) => EditWatchList(
//   //       watchlists: WatchListModel.watchlistDatas,
//   //     ),
//   //   );
//   // }

// }

// final MySnackBars sb = MySnackBars();
// // String addExchange = "";
// // String addToken = "";
// // String addScripts = "";
// // String delExchange = "";
// // String delToken = "";
// // String delScripts = "";

// class _EditWatchListState extends State<EditWatchList> {
//   final Function fetchMWList;
//   _EditWatchListState(this.fetchMWList);
//   String addExchange = "";
//   String addToken = "";
//   String addScripts = "";
//   String delExchange = "";
//   String delToken = "";
//   String delScripts = "";
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return WillPopScope(
//       onWillPop: () async {
//         setState(() {
//           fetchMWList(WatchListModel.selectedIndex);
//         });

//         return true;
//       },
//       child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
//         return Scaffold(
//           backgroundColor: themeNotifier.isDark ? Colors.black : Colors.white,
//           appBar: AppBar(
//             centerTitle: true,
//             elevation: .4,
//             title: Text(
//               "Edit Watchlist",
//               style: watchListTextStyle(size),
//             ),
//           ),
//           body: ReorderableListView.builder(
//             shrinkWrap: true,
//             // reverse: true,
//             onReorder: (int oldIndex, int newIndex) {
//               setState(() {
//                 if (newIndex > oldIndex) {
//                   newIndex = newIndex - 1;
//                 }

//                 for (var i = 0; i < WatchListModel.mWatchList.length; i++) {
//                   delExchange = WatchListModel.mWatchList[i]['exch'];
//                   delToken = WatchListModel.mWatchList[i]['token'];
//                   delScripts += "$delExchange|$delToken#";
//                 }
//                 final element = WatchListModel.mWatchList.removeAt(oldIndex);
//                 WatchListModel.mWatchList.insert(newIndex, element);

//                 for (var i = 0; i < WatchListModel.mWatchList.length; i++) {
//                   addExchange = WatchListModel.mWatchList[i]['exch'];
//                   addToken = WatchListModel.mWatchList[i]['token'];
//                   addScripts += "$addExchange|$addToken#";
//                 }
//                 deleteScript(delScripts);
//               });
//             },
//             itemCount: WatchListModel.mWatchList.length,
//             itemBuilder: (BuildContext context, int index) {
//               return ListTile(
//                   key: ValueKey(WatchListModel.mWatchList[index]),
//                   leading: IconButton(
//                     icon: const Icon(
//                       Icons.delete_outline,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         var tok = WatchListModel.mWatchList[index]['token'];
//                         var exc = WatchListModel.mWatchList[index]['exch'];
//                         String delscript = "$exc|$tok#";
//                         deleteScript(delscript);
//                         fetchMWList(WatchListModel.selectedIndex);
//                       });
//                     },
//                   ),
//                   title: Text(
//                     WatchListModel.mWatchList[index]['tsym'],
//                     style: listTitle(size),
//                   ),
//                   subtitle: Text(
//                     WatchListModel.mWatchList[index]['exch'],
//                     style: listSubTitle(size),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(
//                       Icons.drag_handle,
//                     ),
//                     tooltip: null,
//                     onPressed: () {},
//                   ));
//             },
//           ),
//         );
//       }),
//     );
//   }

//   Future addScript(addScripts) async {
//     try {
//       http.Response response = await http.post(Uri.parse(ApiLinks.addScrip),
//           headers: <String, String>{
//             'Content-Type': 'application/json',
//           },
//           body:
//               '''jData={"uid":"${ConstVariable.userId}","wlname":"${WatchListModel.selectedIndex}","scrips":"$addScripts"}&jKey=${ConstVariable.sessionId}''');

//       Map mapRes = json.decode(response.body);
//       log("$mapRes");
//       if (mapRes['stat'] == "Ok") {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(sb.successBar("Script Added succesfully"));
//         fetchMWList(WatchListModel.selectedIndex);
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
//     }
//   }

//   Future deleteScript(script) async {
//     try {
//       http.Response response = await http.post(Uri.parse(ApiLinks.deleteScrip),
//           headers: <String, String>{
//             'Content-Type': 'application/json',
//           },
//           body:
//               '''jData={"uid":"${ConstVariable.userId}","wlname":"${WatchListModel.selectedIndex}","scrips":"$script"}&jKey=${ConstVariable.sessionId}''');

//       Map mapRes = json.decode(response.body);
//       log("$mapRes");
//       if (mapRes['stat'] == "Ok") {
//         // ScaffoldMessenger.of(context)
//         //     .showSnackBar(sb.unSuccessBar("Script Deleted succesfully"));
//         addScript(addScripts);
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
//     }
//   }
// }
