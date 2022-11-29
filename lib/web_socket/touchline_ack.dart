import 'dart:convert';

TouchlineAcknowledgementStream touchlineAcknowledgementStreamFromJson(
        String str) =>
    TouchlineAcknowledgementStream.fromJson(
        json.decode(str) as Map<String, dynamic>);

String touchlineAcknowledgementStreamToJson(
        TouchlineAcknowledgementStream data) =>
    json.encode(data.toJson());

class TouchlineAcknowledgementStream {
  TouchlineAcknowledgementStream({
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
    this.poi,
    this.toi,
    this.bq1,
    this.sq1,
    this.bp1,
    this.sp1,
    this.ft,
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
  String? poi;
  String? toi;
  String? bq1;
  String? bp1;
  String? sq1;
  String? sp1;
  String? ft;

  factory TouchlineAcknowledgementStream.fromJson(Map<String, dynamic> json) =>
      TouchlineAcknowledgementStream(
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
        poi: json["poi"].toString(),
        toi: json["toi"].toString(),
        oi: json["oi"].toString(),
        bq1: json["bq1"].toString(),
        sq1: json["sq1"].toString(),
        sp1: json["sp1"].toString(),
        bp1: json["bp1"].toString(),
        ft: json["ft"].toString(),
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
        "poi": poi,
        "toi": toi,
        "sp1": sp1,
        "sq1": sq1,
        "bq1": bq1,
        "bp1": bp1,
        "ft": ft,
      };
}
