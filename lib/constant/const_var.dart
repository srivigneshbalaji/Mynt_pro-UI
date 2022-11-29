import 'package:mynt_pro/web_socket/market_depth.dart';

import '../web_socket/values.dart';

class ConstVariable {
  static String sessionId = "";
  static String sha556Session = "";
  static String stat = "";
  static String userId = "";
  static String accId = "";
  static String brokerName = "";
  static bool authStatus = false;
  static List<Values>? data;
  static List<MarketDepth>? mdpdata;
}
