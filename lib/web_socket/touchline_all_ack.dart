// To parse this JSON data, do
//
//     final touchlineAcknowledgementStream = touchlineAcknowledgementStreamFromJson(jsonString);

import 'dart:convert';

TouchlineAllAcknowledgementStream touchlineAllAcknowledgementStreamFromJson(
        String str) =>
    TouchlineAllAcknowledgementStream.fromJson(
        json.decode(str) as Map<String, dynamic>);

String touchlineAllAcknowledgementStreamToJson(
        TouchlineAllAcknowledgementStream data) =>
    json.encode(data.toJson());

class TouchlineAllAcknowledgementStream {
  TouchlineAllAcknowledgementStream({
    this.t,
    this.e,
    this.tk,
    this.ts,
    this.pp,
    this.ls,
    this.ti,
    this.lp,
    this.pc,
    this.o,
    this.h,
    this.l,
    this.c,
    this.ap,
    this.v,
    this.oi,
  });

  String? t;
  String? e;
  String? tk;
  String? ts;
  String? pp;
  String? ls;
  String? ti;
  String? lp;
  String? pc;
  String? o;
  String? h;
  String? l;
  String? c;
  String? ap;
  String? v;
  String? oi;

  factory TouchlineAllAcknowledgementStream.fromJson(
          Map<String, dynamic> json) =>
      TouchlineAllAcknowledgementStream(
        t: json["t"].toString(),
        e: json["e"].toString(),
        tk: json["tk"].toString(),
        ts: json["ts"].toString(),
        pp: json["pp"].toString(),
        ls: json["ls"].toString(),
        ti: json["ti"].toString(),
        lp: json["lp"].toString(),
        pc: json["pc"].toString(),
        o: json["o"].toString(),
        h: json["h"].toString(),
        l: json["l"].toString(),
        c: json["c"].toString(),
        ap: json["ap"].toString(),
        v: json["v"].toString(),
        oi: json["oi"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "t": t,
        "e": e,
        "tk": tk,
        "pp": pp,
        "ls": ls,
        "ti": ti,
        "lp": lp,
        "pc": pc,
        "o": o,
        "h": h,
        "l": l,
        "c": c,
        "ap": ap,
        "v": v,
        "oi": oi,
      };
}

// To parse this JSON data, do
//
//     final touchlineUpdateStream = touchlineUpdateStreamFromJson(jsonString);

// import 'dart:convert';

