import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api_links.dart';
import '../constant/const_var.dart';
import '../constant/snackbar.dart';
import '../model/watchlist_model.dart';

final MySnackBars sb = MySnackBars();

Future addScript({required BuildContext context, required addScripts}) async {
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
          .showSnackBar(sb.successBar("Script Reorderd succesfully"));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
  }
}
