import 'dart:convert';

TouchlineUpdateStream touchlineUpdateStreamFromJson(String str) =>
    TouchlineUpdateStream.fromJson(json.decode(str) as Map<String, dynamic>);

String touchlineUpdateStreamToJson(TouchlineUpdateStream data) =>
    json.encode(data.toJson());

class TouchlineUpdateStream {
  TouchlineUpdateStream({
    required this.ts,
    required this.t,
    required this.e,
    required this.tk,
    required this.lp,
    required this.pc,
    required this.o,
    required this.h,
    required this.l,
    required this.c,
    required this.ap,
    required this.v,
  });

  String? ts;
  String? t;
  String? e;
  String? tk;
  String? lp;
  String? pc;
  String? o;
  String? h;
  String? l;
  String? c;
  String? ap;
  String? v;

  factory TouchlineUpdateStream.fromJson(Map<String, dynamic> json) {
    final String? task =
        // ignore: unnecessary_null_comparison
        json["t"].toString() == null || json["t"].toString() == "null"
            ? null
            : json["t"].toString();
    final String? instrument_name =
        // ignore: unnecessary_null_comparison
        json["ts"].toString() == null || json["ts"].toString() == "null"
            ? null
            : json["ts"].toString();
    final String? exchange =
        // ignore: unnecessary_null_comparison
        json["e"].toString() == null || json["e"].toString() == "null"
            ? null
            : json["e"].toString();
    final String? token =
        // ignore: unnecessary_null_comparison
        json["tk"].toString() == null || json["tk"].toString() == "null"
            ? null
            : json["tk"].toString();
    final String? ltp =
        // ignore: unnecessary_null_comparison
        json["lp"].toString() == null || json["lp"].toString() == "null"
            ? null
            : json["lp"].toString();
    final String? percentageChange =
        // ignore: unnecessary_null_comparison
        json["pc"].toString() == null || json["pc"].toString() == "null"
            ? null
            : json["pc"].toString();
    final String? open =
        // ignore: unnecessary_null_comparison
        json["o"].toString() == null || json["o"].toString() == "null"
            ? null
            : json["o"].toString();
    final String? high =
        // ignore: unnecessary_null_comparison
        json["h"].toString() == null || json["h"].toString() == "null"
            ? null
            : json["h"].toString();
    final String? low =
        // ignore: unnecessary_null_comparison
        json["l"].toString() == null || json["l"].toString() == "null"
            ? null
            : json["l"].toString();
    final String? close =
        // ignore: unnecessary_null_comparison
        json["c"].toString() == null || json["c"].toString() == "null"
            ? null
            : json["c"].toString();
    final String? averageTradePrice =
        // ignore: unnecessary_null_comparison
        json["ap"].toString() == null || json["ap"].toString() == "null"
            ? null
            : json["ap"].toString();
    final String? volume =
        // ignore: unnecessary_null_comparison
        json["v"].toString() == null || json["v"].toString() == "null"
            ? null
            : json["v"].toString();
    return TouchlineUpdateStream(
      ts: instrument_name,
      t: task,
      e: exchange,
      tk: token,
      lp: ltp,
      pc: percentageChange,
      o: open,
      h: high,
      l: low,
      c: close,
      ap: averageTradePrice,
      v: volume,
    );
  }

  Map<String, dynamic> toJson() => {
        "ts": ts,
        "t": t,
        "e": e,
        "tk": tk,
        "lp": lp,
        "pc": pc,
        "o": o,
        "h": h,
        "l": l,
        "c": c,
        "ap": ap,
        "v": v,
      };
}
