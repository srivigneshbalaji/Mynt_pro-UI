// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

TouchlineUpdateStream touchlineUpdateStreamFromJson(String str) =>
    TouchlineUpdateStream.fromJson(json.decode(str) as Map<String, dynamic>);

String touchlineUpdateStreamToJson(TouchlineUpdateStream data) =>
    json.encode(data.toJson());

class TouchlineUpdateStream {
  TouchlineUpdateStream({
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
    required this.oi,
    required this.poi,
    required this.toi,
    required this.bq1,
    required this.sq1,
    required this.bp1,
    required this.sp1,
    required this.ft,
  });

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
  String? oi;
  String? poi;
  String? toi;
  String? bq1;
  String? bp1;
  String? sq1;
  String? sp1;
  String? ft;

  factory TouchlineUpdateStream.fromJson(Map<String, dynamic> json) {
    final String? task =
        json["t"].toString() == null || json["t"].toString() == "null"
            ? null
            : json["t"].toString();

    final String? exchange =
        json["e"].toString() == null || json["e"].toString() == "null"
            ? null
            : json["e"].toString();
    final String? token =
        json["tk"].toString() == null || json["tk"].toString() == "null"
            ? null
            : json["tk"].toString();
    final String? ltp =
        json["lp"].toString() == null || json["lp"].toString() == "null"
            ? null
            : json["lp"].toString();
    final String? percentageChange =
        json["pc"].toString() == null || json["pc"].toString() == "null"
            ? null
            : json["pc"].toString();
    final String? open =
        json["o"].toString() == null || json["o"].toString() == "null"
            ? null
            : json["o"].toString();
    final String? high =
        json["h"].toString() == null || json["h"].toString() == "null"
            ? null
            : json["h"].toString();
    final String? low =
        json["l"].toString() == null || json["l"].toString() == "null"
            ? null
            : json["l"].toString();
    final String? close =
        json["c"].toString() == null || json["c"].toString() == "null"
            ? null
            : json["c"].toString();
    final String? averageTradePrice =
        json["ap"].toString() == null || json["ap"].toString() == "null"
            ? null
            : json["ap"].toString();
    final String? volume =
        json["v"].toString() == null || json["v"].toString() == "null"
            ? null
            : json["v"].toString();
    final String? openInterest =
        json["oi"].toString() == null || json["oi"].toString() == "null"
            ? null
            : json["oi"].toString();
    final String? preOpenInterest =
        json["poi"].toString() == null || json["poi"].toString() == "null"
            ? null
            : json["poi"].toString();
    final String? totOpenInterest =
        json["toi"].toString() == null || json["toi"].toString() == "null"
            ? null
            : json["toi"].toString();
    final String? feedTime =
        json["ft"].toString() == null || json["ft"].toString() == "null"
            ? null
            : json["ft"].toString();
    final String? sellQty1 =
        json["sq1"].toString() == null || json["sq1"].toString() == "null"
            ? null
            : json["sq1"].toString();
    final String? buyPrice1 =
        json["bp1"].toString() == null || json["bp1"].toString() == "null"
            ? null
            : json["bp1"].toString();
    final String? buyQty1 =
        json["bq1"].toString() == null || json["bq1"].toString() == "null"
            ? null
            : json["bq1"].toString();
    final String? sellPrice1 =
        json["sp1"].toString() == null || json["sp1"].toString() == "null"
            ? null
            : json["sp1"].toString();
    return TouchlineUpdateStream(
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
      poi: preOpenInterest,
      toi: totOpenInterest,
      oi: openInterest,
      bq1: buyQty1,
      sq1: sellQty1,
      sp1: sellPrice1,
      bp1: buyPrice1,
      ft: feedTime,
    );
  }

  Map<String, dynamic> toJson() => {
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
        "oi": oi,
        "poi": poi,
        "toi": toi,
        "sp1": sp1,
        "sq1": sq1,
        "bq1": bq1,
        "bp1": bp1,
        "ft": ft,
      };
}
