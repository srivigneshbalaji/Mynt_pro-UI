// ignore_for_file: use_build_context_synchronously, avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../api/api_links.dart';
import '../model/models.dart';
import '../constant/snackbar.dart';

final MySnackBars sb = MySnackBars();

Future userDetail({
  required BuildContext context,
}) async {
  try {
    http.Response response = await http.post(Uri.parse(ApiLinks.userDetail),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body:
            '''jData={"uid":"${ConstVariable.userId}"}&jKey=${ConstVariable.sessionId}''');

    Map mapRes = json.decode(response.body);
    var sts = mapRes['stat'];

    if (sts == "Ok") {
      UserDetailModel.userName = mapRes['uname'];
      UserDetailModel.mobileNum = mapRes['m_num'];
      UserDetailModel.eMail = mapRes['email'];
      UserDetailModel.product = mapRes['prarr'];
      UserDetailModel.segment = mapRes['exarr'];
      UserDetailModel.priceType = mapRes['orarr'];
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
