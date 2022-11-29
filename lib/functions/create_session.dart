import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/const_var.dart';

Future createSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    ConstVariable.userId = prefs.getString('cc')!;
    ConstVariable.sessionId = prefs.getString('cc')!;
  } catch (e) {}
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var request = http.Request(
      'POST', Uri.parse('http://154.83.3.25:8889/NorenWsHelper/CreateSess'));
  request.bodyFields = {
    'uid': ConstVariable.userId,
    'usession': ConstVariable.sessionId,
    'src': 'MOB',
    'vcode': 'STONE_AGE'
  };

  request.headers.addAll(headers);
  var bytes = utf8.encode(ConstVariable.sessionId);
  final bytes1 = utf8.encode(sha256.convert(bytes).toString());
  ConstVariable.sha556Session = sha256.convert(bytes1).toString();
  http.StreamedResponse response = await request.send();
  print("$response");
}

  // Future closeSession() async {
  //   var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  //   var request = http.Request('POST',
  //       Uri.parse('http://154.83.3.25:8889/NorenWsHelper/InvalidateSess'));
  //   request.bodyFields = {
  //     'uid': Global.ccValue,
  //     'usession': Global.ccValue,
  //     'src': 'MOB'
  //   };
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     // print(await response.stream.bytesToString());
  //     createsession();
  //     _getNiftyData();
  //     marketWatchFetch(selectedValue);
  //     tPosition();
  //   } else {
  //     // print(response.reasonPhrase);
  //   }
  // }