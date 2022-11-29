import 'dart:convert';

DepthAcknowledgementStream depthAcknowledgementStreamFromJson(String str) =>
    DepthAcknowledgementStream.fromJson(
        json.decode(str) as Map<String, dynamic>);

String depthAcknowledgementStreamToJson(DepthAcknowledgementStream data) =>
    json.encode(data.toJson());

class DepthAcknowledgementStream {
  DepthAcknowledgementStream({
    this.t,
    this.e,
    this.tk,
    this.lp,
    this.pc,
    this.o,
    this.h,
    this.l,
    this.c,
    this.ap,
    this.v,
    this.bo1,
    this.bo2,
    this.bo3,
    this.bo4,
    this.bo5,
    this.bp1,
    this.bp2,
    this.bp3,
    this.bp4,
    this.bp5,
    this.bq1,
    this.bq2,
    this.bq3,
    this.bq4,
    this.bq5,
    this.ft,
    this.h52,
    this.l52,
    this.lc,
    this.ltq,
    this.ltt,
    this.oi,
    this.poi,
    this.so1,
    this.so2,
    this.so3,
    this.so4,
    this.so5,
    this.sp1,
    this.sp2,
    this.sp3,
    this.sp4,
    this.sp5,
    this.sq1,
    this.sq2,
    this.sq3,
    this.sq4,
    this.sq5,
    this.tbq,
    this.toi,
    this.tsq,
    this.uc,
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
  String? ltt;
  String? ltq;
  String? tbq;
  String? tsq;
  String? bq1;
  String? bq2;
  String? bq3;
  String? bq4;
  String? bq5;
  String? sq1;
  String? sq2;
  String? sq3;
  String? sq4;
  String? sq5;
  String? bp1;
  String? bp2;
  String? bp3;
  String? bp4;
  String? bp5;
  String? sp1;
  String? sp2;
  String? sp3;
  String? sp4;
  String? sp5;
  String? bo1;
  String? bo2;
  String? bo3;
  String? bo4;
  String? bo5;
  String? so1;
  String? so2;
  String? so3;
  String? so4;
  String? so5;
  String? lc;
  String? uc;
  String? h52;
  String? l52;
  String? oi;
  String? poi;
  String? toi;
  String? ft;

  factory DepthAcknowledgementStream.fromJson(Map<String, dynamic> json) =>
      DepthAcknowledgementStream(
        t: json["t"].toString(),
        e: json["e"].toString(),
        tk: json["tk"].toString(),
        o: json["o"].toString(),
        h: json["h"].toString(),
        l: json["l"].toString(),
        c: json["c"].toString(),
        lp: json["lp"].toString(),
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
        ltt: json["ltt"].toString(),
        ltq: json["ltq"].toString(),
        tbq: json["tbq"].toString(),
        tsq: json["tsq"].toString(),
        bq2: json["bq2"].toString(),
        bq3: json["bq3"].toString(),
        bq4: json["bq4"].toString(),
        bq5: json["bq5"].toString(),
        sq2: json["sq2"].toString(),
        sq3: json["sq3"].toString(),
        sq4: json["sq4"].toString(),
        sq5: json["sq5"].toString(),
        bp2: json["bp2"].toString(),
        bp3: json["bp3"].toString(),
        bp4: json["bp4"].toString(),
        bp5: json["bp5"].toString(),
        sp2: json["sp2"].toString(),
        sp3: json["sp3"].toString(),
        sp4: json["sp4"].toString(),
        sp5: json["sp5"].toString(),
        bo1: json["bo1"].toString(),
        bo2: json["bo2"].toString(),
        bo3: json["bo3"].toString(),
        bo4: json["bo4"].toString(),
        bo5: json["bo5"].toString(),
        so1: json["so1"].toString(),
        so2: json["so2"].toString(),
        so3: json["so3"].toString(),
        so4: json["so4"].toString(),
        so5: json["so5"].toString(),
        lc: json["lc"].toString(),
        uc: json["uc"].toString(),
        h52: json["52h"].toString(),
        l52: json["52l"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "t": t,
        "e": e,
        "tk": tk,
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
        "lp": lp,
        "ltt": ltt,
        "ltq": ltq,
        "tbq": tbq,
        "tsq": tsq,
        "bq2": bq2,
        "bq3": bq3,
        "bq4": bq4,
        "bq5": bq5,
        "sq2": sq2,
        "sq3": sq3,
        "sq4": sq4,
        "sq5": sq5,
        "bp2": bp2,
        'bp3': bp3,
        "bp4": bp4,
        "bp5": bp5,
        "sp2": sp2,
        "sp3": sp3,
        "sp4": sp4,
        "sp5": sp5,
        "bo1": bo1,
        "bo2": bo2,
        "bo3": bo3,
        "bo4": bo4,
        "bo5": bo5,
        "so1": so1,
        "so2": so2,
        "so3": so3,
        "so4": so4,
        "so5": so5,
        "lc": lc,
        "uc": uc,
        "52h": h52,
        "52l": l52,
      };
}
