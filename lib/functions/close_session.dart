import 'package:http/http.dart' as http;
import 'package:mynt_pro/functions/create_session.dart';

import '../constant/const_var.dart';

Future closeSession() async {
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var request = http.Request('POST',
      Uri.parse('http://154.83.3.25:8889/NorenWsHelper/InvalidateSess'));
  request.bodyFields = {
    'uid': ConstVariable.userId,
    'usession': ConstVariable.sessionId,
    'src': 'MOB'
  };
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    createSession();
  } else {
    // print(response.reasonPhrase);
  }
}
