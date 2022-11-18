// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../api/api_links.dart';
import '../constant/model/models.dart';
import '../constant/snackbar.dart';

final MySnackBars sb = MySnackBars();
Future marketWatchList({
  required BuildContext context,
  required int selectedIndex,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    ConstVariable.sessionId = prefs.getString('userSession')!;
    ConstVariable.userId = prefs.getString('userId')!;
    http.Response response = await http.post(Uri.parse(ApiLinks.marketWatch),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body:
            '''jData={"uid":"${ConstVariable.userId}","wlname":"$selectedIndex"}&jKey=${ConstVariable.sessionId}''');

    Map mapRes = json.decode(response.body);
    WatchListModel.watchStat = mapRes['stat'];
    if (WatchListModel.watchStat == "Ok") {
      WatchListModel.watchList = mapRes["values"];

      log("${WatchListModel.watchList}");
    } else {
      if (mapRes['emsg'] == "Session Expired :  Invalid Session Key") {
        Navigator.pushNamed(context, 'logIn');
        ScaffoldMessenger.of(context)
            .showSnackBar(sb.unSuccessBar("Session Expired"));
      }
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
  }
}
