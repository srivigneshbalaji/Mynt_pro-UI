import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../api/api_links.dart';
import '../constant/const_var.dart';
import '../constant/snackbar.dart';
import '../model/watchlist_model.dart';
import 'add_script.dart';

final MySnackBars sb = MySnackBars();

Future deleteScript({
  required BuildContext context,
  required delscripts,
  required addscripts,
}) async {
  try {
    http.Response response = await http.post(Uri.parse(ApiLinks.deleteScrip),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body:
            '''jData={"uid":"${ConstVariable.userId}","wlname":"${WatchListModel.selectedIndex}","scrips":"$delscripts"}&jKey=${ConstVariable.sessionId}''');

    Map mapRes = json.decode(response.body);
    log("$mapRes");
    if (mapRes['stat'] == "Ok") {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(sb.unSuccessBar("Script Deleted succesfully"));
      addScript(context: context, addScripts: addscripts);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
  }
}
