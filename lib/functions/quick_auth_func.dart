// ignore_for_file: use_build_context_synchronously, avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_links.dart';
import '../model/models.dart';
import '../constant/snackbar.dart';

final MySnackBars sb = MySnackBars();

class QuickAuth {
  static Future quickAuth({
    required BuildContext context,
    required String uId,
    required String pass,
    required String pan,
  }) async {
    String vendorKey = "|Apikey10112022zebu";
    var enCodePass = utf8.encode(pass);
    var enCodeuId = utf8.encode(uId);
    var enCodeVendorKey = utf8.encode(vendorKey);
    var sha256Pass = sha256.convert(enCodePass);
    var sha256AppKey = sha256.convert(enCodeuId + enCodeVendorKey);
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.quickAuth),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"$uId","pwd":"$sha256Pass","factor2":"$pan","apkversion":"20220921","imei":"${DeviceInfo.imeiNo}","vc":"PRO_MYNT","appkey":"$sha256AppKey","source":"API"}''');

      Map mapRes = json.decode(response.body);
      var sts = mapRes['stat'];

      if (sts == "Ok") {
        ConstVariable.sessionId = mapRes['susertoken'];

        print("USER-SESSION ${ConstVariable.sessionId}");
        ConstVariable.userId = mapRes['uid'];
        ConstVariable.accId = mapRes['actid'];
        ConstVariable.brokerName = mapRes['brkname'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userSession', ConstVariable.sessionId);
        await prefs.setString('userId', ConstVariable.userId);
        await prefs.setString('actid', ConstVariable.accId);
        ConstVariable.sessionId = prefs.getString('userSession')!;
        ConstVariable.accId = prefs.getString('actid')!;

        // marketWatchList(context: context, selectedIndex: 1);
        Navigator.pushNamed(context, 'mobIndex');
        ScaffoldMessenger.of(context).showSnackBar(sb.successBar("Success"));
      } else {
        var errorMsg = mapRes['emsg'];

        if (errorMsg == "Invalid Input : Password Expired") {
          Navigator.pushNamed(context, "changePassword");
        }
        ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(errorMsg));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
    }
  }
}
