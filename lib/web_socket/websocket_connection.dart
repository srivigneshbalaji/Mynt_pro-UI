import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../model/models.dart';
import 'web_sockts.dart';

class WebSocketConnection {
  static bool wsConnected = false;
  static String sub = "";
  static String url = "wss://ws.zebull.in/NorenWS/";
  static late WebSocketChannel channel;
  static List<TouchlineAcknowledgementStream>? touchAcknowledgementData;
  static List<TouchlineAcknowledgementStream>?
      get getTouchAcknowledgementData => touchAcknowledgementData;

  static List<TouchlineAllAcknowledgementStream>? touchallAcknowledgementData;
  static List<TouchlineAllAcknowledgementStream>?
      get getTouchAllAcknowledgementData => touchallAcknowledgementData;

  static StreamController<TouchlineUpdateStream> mwStream =
      StreamController<TouchlineUpdateStream>.broadcast();
  static StreamController<TouchlineAcknowledgementStream>
      touchAcknowledgementStream =
      StreamController<TouchlineAcknowledgementStream>.broadcast();

  static StreamController<TouchlineAllUpdateStream> mwallStream =
      StreamController<TouchlineAllUpdateStream>.broadcast();
  static StreamController<TouchlineAllAcknowledgementStream>
      touchallAcknowledgementStream =
      StreamController<TouchlineAllAcknowledgementStream>.broadcast();

  static StreamController<DepthWSResponse> dpStream =
      StreamController<DepthWSResponse>.broadcast();
  static StreamController<DepthAckWSResponse> dpAckStream =
      StreamController<DepthAckWSResponse>.broadcast();

  static StreamController<double> controller = StreamController<double>();
  static Stream stream = controller.stream.asBroadcastStream();

  static StreamController<dynamic> datacontroller = StreamController<dynamic>();
  static Stream datastream = datacontroller.stream.asBroadcastStream();

  static Future estcon(task, scripts, wsConnected) async {
    String exc;
    String tok;

    Map<String, String>? stock1;
    Map<String, String>? stock2;

    if (task == 't') {
      stock2 = {"t": "u", "k": sub};
      sub = "";
      for (int i = 0; i < scripts.length; i++) {
        exc = scripts[i]['exch'];
        tok = scripts[i]['token'];
        sub += "$exc|$tok#";
      }
      // print(sub);
      stock1 = {"t": task, "k": sub};
    } else if (task == 'd' || task == 'ud') {
      sub = "";
      for (int i = 0; i < scripts.length; i++) {
        exc = scripts['exch'];
        tok = scripts['token'];
        sub += "$exc|$tok#";
      }
    } else if (task == 'p' || task == 'up') {
      sub = '';
      if (task == 'p') {
        for (int i = 0; i < scripts.length; i++) {
          exc = scripts[i]['exch'];
          tok = scripts[i]['token'];
          sub += "$exc|$tok#";
        }
      } else {
        sub = "";
        for (int i = 0; i < scripts.length; i++) {
          exc = scripts[i]['exch'];
          tok = scripts[i]['token'];
          sub += "$exc|$tok#";
        }
      }
      stock2 = {"t": "u", "k": sub};
      stock1 = {"t": "t", "k": sub};
    } else if (task == 'u') {
      for (int i = 0; i < scripts.length; i++) {
        exc = scripts[i]['exch'];
        tok = scripts[i]['token'];
        sub += "$exc|$tok#";
      }
      stock2 = {"t": "u", "k": sub};
    }

    if (!WebSocketConnection.wsConnected) {
      channel = IOWebSocketChannel.connect("wss://ws.zebull.in/NorenWS/");
      log(":: Connecting ::");
      dynamic response;
      final data = {
        "t": "c",
        "uid": ConstVariable.userId,
        "actid": ConstVariable.accId,
        "source": "MOB",
        "susertoken": ConstVariable.sha556Session
      };
      // print(data);
      channel.sink.add(jsonEncode(data));
      channel.stream.listen((res) {
        response = jsonDecode(res);

        print(response);
        final conn = jsonDecode(res.toString());
        if (conn['t'] == 'ck' || conn['t'] == 'tf') {
          WebSocketConnection.wsConnected = true;
          if (conn['t'] != 'tf') {
            channel.sink.add(jsonEncode(stock1));
          }
        }
        switch (response['t'].toString().toLowerCase()) {
          case "tf":
            mwStream.add(
              TouchlineUpdateStream.fromJson(response as Map<String, dynamic>),
            );
            mwallStream.add(TouchlineAllUpdateStream.fromJson(
                response as Map<String, dynamic>));
            break;
          case "tk":
            touchAcknowledgementStream.add(
              TouchlineAcknowledgementStream.fromJson(
                  response as Map<String, dynamic>),
            );
            touchallAcknowledgementStream.add(
              TouchlineAllAcknowledgementStream.fromJson(
                  response as Map<String, dynamic>),
            );
            break;
          case "dk":
            dpAckStream.add(
                DepthAckWSResponse.fromJson(response as Map<String, dynamic>));
            break;
          case "df":
            dpStream.add(
                DepthWSResponse.fromJson(response as Map<String, dynamic>));
            break;
        }
        Map mapRes = response;
      })
        ..onDone(() async {
          WebSocketConnection.wsConnected = false;
          log(":: DONE ERR :::: Connection Closed onDone");
          try {
            estcon(task, WatchListModel.mWatchList, false);
          } catch (e) {
            log(":: DONE ERR :::: Connection Closed, $e");
          }
        })
        ..onError((handleError) async {
          WebSocketConnection.wsConnected = false;
          log(":: ERROR ERR :::: Connection Closed");
          try {
            estcon(task, WatchListModel.mWatchList, false);
          } catch (e) {
            log(":: ERROR ERR :::: Connection Closed, $e");
          }
        });
    } else {
      channel.sink.add(jsonEncode(stock2));
      touchAcknowledgementData = [];
      touchallAcknowledgementData = [];
      log("Unsubscribed: $stock2");
      if (task == 'd' || task == 't' || task == 'p') {
        connectTouchLine(task: task, input: sub);
      }
    }
    return url;
  }

  static void connectTouchLine({required String task, required String input}) {
    final data;
    if (task == 'p') {
      data = {
        "t": "t",
        "k": input,
      };
    } else {
      data = {
        "t": task,
        "k": input,
      };
    }
    log('Subscription ws:: $data');
    log('Status ws::${WebSocketConnection.wsConnected}');
    channel.sink.add(jsonEncode(data));
  }
}
