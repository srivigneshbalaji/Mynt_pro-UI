// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_links.dart';
import '../constant/const_var.dart';
import '../constant/snackbar.dart';

final MySnackBars sb = MySnackBars();
Future logout({
  required BuildContext context,
}) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    http.Response response = await http.post(Uri.parse(ApiLinks.logout),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body:
            '''jData={"uid":"${ConstVariable.userId}"}&jKey=${ConstVariable.sessionId}''');

    Map mapRes = json.decode(response.body);

    ConstVariable.stat = mapRes['stat'];

    if (ConstVariable.stat == "Ok") {
      ScaffoldMessenger.of(context)
          .showSnackBar(sb.successBar("User succesfully logged out"));
      ConstVariable.userId = prefs.getString('userId')!;
      await prefs.remove('userSession');

      Navigator.of(context)
          .pushNamedAndRemoveUntil('logIn', (Route<dynamic> route) => false);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
  }
}
