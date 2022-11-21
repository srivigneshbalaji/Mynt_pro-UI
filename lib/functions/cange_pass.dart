// ignore_for_file: use_build_context_synchronously, avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../api/api_links.dart';
import '../constant/model/models.dart';
import '../constant/snackbar.dart';

final MySnackBars sb = MySnackBars();

Future changePass({
  required BuildContext context,
  required oldPass,
  required newPass,
}) async {
  var enCodeOldPass = utf8.encode(oldPass);
  var sha256OldPass = sha256.convert(enCodeOldPass);
  try {
    http.Response response = await http.post(Uri.parse(ApiLinks.changePass),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body:
            '''jData={"uid":"${ConstVariable.userId}","oldpwd":"$sha256OldPass","pwd":"$newPass"}''');

    Map mapRes = json.decode(response.body);
    var sts = mapRes['stat'];

    print(sts);

    if (sts == "Ok") {
      var msg = mapRes['dmsg'];
      ScaffoldMessenger.of(context).showSnackBar(sb.successBar(msg));
      Navigator.pushNamed(context, 'logIn');
    } else {
      var eMsg = mapRes['emsg'];
      print(eMsg);
      ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(eMsg));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
  }
}
