// ignore_for_file: use_build_context_synchronously, avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../api/api_links.dart';
import '../model/models.dart';
import '../constant/snackbar.dart';

final MySnackBars sb = MySnackBars();

Future clientDetail({
  required BuildContext context,
}) async {
  try {
    http.Response response = await http.post(Uri.parse(ApiLinks.clientDetail),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body:
            '''jData={"uid":"${ConstVariable.userId}","actid":"${ConstVariable.accId}","brkname":"${ConstVariable.brokerName}"}&jKey=${ConstVariable.sessionId}''');

    Map mapRes = json.decode(response.body);
    var sts = mapRes['stat'];

    if (sts == "Ok") {
      ClientDetailModel.clientName = mapRes['cliname'];
      ClientDetailModel.mobileNum = mapRes['m_num'];
      ClientDetailModel.accId = mapRes['actid'];
      ClientDetailModel.eMail = mapRes['email'];
      ClientDetailModel.pan = mapRes['pan'];
      ClientDetailModel.segment = mapRes['exarr'];
      ClientDetailModel.dpAcctNum = mapRes['bankdetails'];
      ClientDetailModel.bankDetail = mapRes['dp_acct_num'];
    } else {
      Navigator.pushNamed(context, 'logIn');
      ScaffoldMessenger.of(context)
          .showSnackBar(sb.unSuccessBar("Session Expired"));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        sb.unSuccessBar("Connection issue, Please Try again later"));
  }
}
