// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:mynt_pro/constant/constants.dart';
import 'package:mynt_pro/model/watchlist_model.dart';
import '../../../../api/api_links.dart';
import '../../../../constant/const_var.dart';
import '../../../../constant/snackbar.dart';

class SearchScreen extends StatefulWidget {
  final Function callFunction;
  const SearchScreen({super.key, required this.callFunction});

  @override
  State<SearchScreen> createState() => _SearchScreenState(this.callFunction);
}

List searchList = [];
String searchText = "";
String eMsg = "";
String stat = "";
List<bool>? isAddedScript;
final MySnackBars sb = MySnackBars();

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchTxt = TextEditingController();
  final Function callFunction;
  _SearchScreenState(this.callFunction);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        bachToWatchList();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                bachToWatchList();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: TextField(
              cursorColor: Colors.black,
              autofocus: true,
              controller: searchTxt,
              onChanged: (_) {
                setState(() {
                  searchText = searchTxt.text;
                  if (searchText.length >= 2) {
                    searchScript(searchText);
                  } else if (searchText.isEmpty) {
                    searchList.clear();
                  }
                });
              },
              style: listSubTitle(size),
              decoration: InputDecoration(
                  // fillColor: Colors.black,
                  filled: true,
                  suffixIcon: searchText.isNotEmpty
                      ? InkWell(
                          child: const Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                          onTap: () {
                            setState(() {
                              searchTxt.clear();
                              searchList.clear();
                            });
                          },
                        )
                      : const SizedBox(
                          width: 1,
                        ),
                  hintText: 'Search Symbol',
                  hintStyle: listSubTitle(size),
                  border: InputBorder.none),
            ),
          ),
          body: searchText.length >= 2
              ? stat == "Ok"
                  ? ListView.separated(
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text(
                            searchList[index]['tsym'],
                            style: listTitle(size),
                          ),
                          subtitle: Text(
                            searchList[index]['exch'],
                            style: listSubTitle(size),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              isAddedScript![index]
                                  ? Icons.check_box_outlined
                                  : Icons.add_box_outlined,
                              color: isAddedScript![index]
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isAddedScript![index]) {
                                  deleteScript(searchList[index]['exch'],
                                      searchList[index]['token']);
                                  isAddedScript![index] = false;
                                  callFunction(WatchListModel.selectedIndex);
                                } else {
                                  addScript(searchList[index]['exch'],
                                      searchList[index]['token']);
                                  isAddedScript![index] = true;
                                  callFunction(WatchListModel.selectedIndex);
                                }
                              });
                            },
                          ),
                        );
                      }),
                      separatorBuilder: ((context, index) {
                        return const Divider();
                      }),
                      itemCount: searchList.length)
                  : Center(
                      child: Text(
                        "No Results Found",
                        style: noDataTextStyle(size),
                      ),
                    )
              : Container()),
    );
  }

  void bachToWatchList() {
    return setState(() {
      searchTxt.clear();
      searchList.clear();
      callFunction(WatchListModel.selectedIndex);
    });
  }

  Future searchScript(searchText) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.searchSCrip),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}","stext":"$searchText"}&jKey=${ConstVariable.sessionId}''');

      Map mapRes = json.decode(response.body);

      setState(() {
        stat = mapRes['stat'];
        if (stat == "Ok") {
          searchList = mapRes['values'];
          isAddedScript = List<bool>.filled(searchList.length, false);
          for (var i = 0; i < searchList.length; i++) {
            for (var j = 0; j < WatchListModel.mWatchList.length; j++) {
              if (searchList[i]['token'] ==
                  WatchListModel.mWatchList[j]['token']) {
                setState(() {
                  isAddedScript![i] = true;
                });
              }
            }
          }
        } else {
          eMsg = mapRes['emsg'];
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
    }
  }

  Future addScript(exchange, token) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.addScrip),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}","wlname":"${WatchListModel.selectedIndex}","scrips":"$exchange|$token"}&jKey=${ConstVariable.sessionId}''');

      Map mapRes = json.decode(response.body);
      log("$mapRes");
      if (mapRes['stat'] == "Ok") {
        ScaffoldMessenger.of(context)
            .showSnackBar(sb.successBar("Script Added succesfully"));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
    }
  }

  Future deleteScript(exchange, token) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.deleteScrip),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}","wlname":"${WatchListModel.selectedIndex}","scrips":"$exchange|$token"}&jKey=${ConstVariable.sessionId}''');

      Map mapRes = json.decode(response.body);
      log("$mapRes");
      if (mapRes['stat'] == "Ok") {
        ScaffoldMessenger.of(context)
            .showSnackBar(sb.unSuccessBar("Script Deleted succesfully"));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
    }
  }
}
