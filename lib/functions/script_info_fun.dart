import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/api_links.dart';
import '../constant/model/models.dart';
import '../constant/snackbar.dart';

final MySnackBars sb = MySnackBars();
Future scriptInfo(
    {required BuildContext context, required exchange, required token}) async {
  try {
    http.Response response = await http.post(Uri.parse(ApiLinks.getQuotes),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body:
            '''jData={"uid":"${ConstVariable.userId}","exch":"$exchange","token":"$token"}&jKey=${ConstVariable.sessionId}''');

    ScriptInfoModel.scriptInfoRes = json.decode(response.body);
    var stat = ScriptInfoModel.scriptInfoRes['stat'];
    if (stat == "Ok") {
      ScriptInfoModel.ltp = ScriptInfoModel.scriptInfoRes['lp'];
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(sb.unSuccessBar("Session Expired"));
    }
  } catch (e) {}
}
