// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

DepthUpdateStream depthUpdateStreamFromJson(String str) =>
    DepthUpdateStream.fromJson(json.decode(str) as Map<String, dynamic>);

String depthUpdateStreamToJson(DepthUpdateStream data) =>
    json.encode(data.toJson());

class DepthUpdateStream {
  DepthUpdateStream({
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

  factory DepthUpdateStream.fromJson(Map<String, dynamic> json) {
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
    final String? lTradeTime =
        json["ltt"].toString() == null || json["ltt"].toString() == "null"
            ? null
            : json["ltt"].toString();
    final String? lTradeQty =
        json["ltq"].toString() == null || json["ltq"].toString() == "null"
            ? null
            : json["ltq"].toString();
    final String? tBuyQty =
        json["lbq"].toString() == null || json["lbq"].toString() == "null"
            ? null
            : json["lbq"].toString();
    final String? tSellQty =
        json["lsq"].toString() == null || json["lsq"].toString() == "null"
            ? null
            : json["lsq"].toString();
    final String? buyQty1 =
        json["bq1"].toString() == null || json["bq1"].toString() == "null"
            ? null
            : json["bq1"].toString();
    final String? buyQty2 =
        json["bq2"].toString() == null || json["bq2"].toString() == "null"
            ? null
            : json["bq2"].toString();
    final String? buyQty3 =
        json["bq3"].toString() == null || json["bq3"].toString() == "null"
            ? null
            : json["bq3"].toString();
    final String? buyQty4 =
        json["bq4"].toString() == null || json["bq4"].toString() == "null"
            ? null
            : json["bq4"].toString();
    final String? buyQty5 =
        json["bq5"].toString() == null || json["bq5"].toString() == "null"
            ? null
            : json["bq5"].toString();
    final String? buyOrd1 =
        json["bo1"].toString() == null || json["bo1"].toString() == "null"
            ? null
            : json["bo1"].toString();
    final String? buyOrd2 =
        json["bo2"].toString() == null || json["bo2"].toString() == "null"
            ? null
            : json["bo2"].toString();
    final String? buyOrd3 =
        json["bo3"].toString() == null || json["bo3"].toString() == "null"
            ? null
            : json["bo3"].toString();
    final String? buyOrd4 =
        json["bo4"].toString() == null || json["bo4"].toString() == "null"
            ? null
            : json["bo4"].toString();
    final String? buyOrd5 =
        json["bo5"].toString() == null || json["bo5"].toString() == "null"
            ? null
            : json["bo5"].toString();
    final String? sellOrd1 =
        json["so1"].toString() == null || json["so1"].toString() == "null"
            ? null
            : json["so1"].toString();
    final String? sellOrd2 =
        json["so2"].toString() == null || json["so2"].toString() == "null"
            ? null
            : json["so2"].toString();
    final String? sellOrd3 =
        json["so3"].toString() == null || json["so3"].toString() == "null"
            ? null
            : json["so3"].toString();
    final String? sellOrd4 =
        json["so4"].toString() == null || json["so4"].toString() == "null"
            ? null
            : json["so4"].toString();
    final String? sellOrd5 =
        json["so5"].toString() == null || json["so5"].toString() == "null"
            ? null
            : json["so5"].toString();
    final String? buyPrice1 =
        json["bp1"].toString() == null || json["bp1"].toString() == "null"
            ? null
            : json["bp1"].toString();
    final String? buyPrice2 =
        json["bp2"].toString() == null || json["bp2"].toString() == "null"
            ? null
            : json["bp2"].toString();
    final String? buyPrice3 =
        json["bp3"].toString() == null || json["bp3"].toString() == "null"
            ? null
            : json["bp3"].toString();
    final String? buyPrice4 =
        json["bp4"].toString() == null || json["bp4"].toString() == "null"
            ? null
            : json["bp4"].toString();
    final String? buyPrice5 =
        json["bp5"].toString() == null || json["bp5"].toString() == "null"
            ? null
            : json["bp5"].toString();
    final String? sellQty1 =
        json["sq1"].toString() == null || json["sq1"].toString() == "null"
            ? null
            : json["sq1"].toString();
    final String? sellQty2 =
        json["sq2"].toString() == null || json["sq2"].toString() == "null"
            ? null
            : json["sq2"].toString();
    final String? sellQty3 =
        json["sq3"].toString() == null || json["sq3"].toString() == "null"
            ? null
            : json["sq3"].toString();
    final String? sellQty4 =
        json["sq4"].toString() == null || json["sq4"].toString() == "null"
            ? null
            : json["sq4"].toString();
    final String? sellQty5 =
        json["sq5"].toString() == null || json["sq5"].toString() == "null"
            ? null
            : json["sq5"].toString();
    final String? sellPrice1 =
        json["sp1"].toString() == null || json["sp1"].toString() == "null"
            ? null
            : json["sp1"].toString();
    final String? sellPrice2 =
        json["sp2"].toString() == null || json["sp2"].toString() == "null"
            ? null
            : json["sp2"].toString();
    final String? sellPrice3 =
        json["sp3"].toString() == null || json["sp3"].toString() == "null"
            ? null
            : json["sp3"].toString();
    final String? sellPrice4 =
        json["bp4"].toString() == null || json["bp4"].toString() == "null"
            ? null
            : json["bp4"].toString();
    final String? sellPrice5 =
        json["bp5"].toString() == null || json["bp5"].toString() == "null"
            ? null
            : json["bp5"].toString();
    final String? lowerCircuit =
        json["lc"].toString() == null || json["lc"].toString() == "null"
            ? null
            : json["lc"].toString();
    final String? upperCircuit =
        json["uc"].toString() == null || json["uc"].toString() == "null"
            ? null
            : json["uc"].toString();
    final String? h52 =
        json["52h"].toString() == null || json["52h"].toString() == "null"
            ? null
            : json["52h"].toString();
    final String? l52 =
        json["52l"].toString() == null || json["52l"].toString() == "null"
            ? null
            : json["52l"].toString();
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

    return DepthUpdateStream(
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
        ltt: lTradeTime,
        ltq: lTradeQty,
        tbq: tBuyQty,
        tsq: tSellQty,
        bq1: buyQty1,
        bq2: buyQty2,
        bq3: buyQty3,
        bq4: buyQty4,
        bq5: buyQty5,
        sq1: sellQty1,
        sq2: sellQty2,
        sq3: sellQty3,
        sq4: sellQty4,
        sq5: sellQty5,
        bp1: buyPrice1,
        bp2: buyPrice2,
        bp3: buyPrice3,
        bp4: buyPrice4,
        bp5: buyPrice5,
        sp1: sellPrice1,
        sp2: sellPrice2,
        sp3: sellPrice3,
        sp4: sellPrice4,
        sp5: sellPrice5,
        bo1: buyOrd1,
        bo2: buyOrd2,
        bo3: buyOrd3,
        bo4: buyOrd4,
        bo5: buyOrd5,
        so1: sellOrd1,
        so2: sellOrd2,
        so3: sellOrd3,
        so4: sellOrd4,
        so5: sellOrd5,
        lc: lowerCircuit,
        uc: upperCircuit,
        h52: h52,
        l52: l52,
        oi: openInterest,
        poi: preOpenInterest,
        toi: totOpenInterest,
        ft: feedTime);
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
        "ltt": ltt,
        "ltq": ltq,
        "tbq": tbq,
        "tsq": tsq,
        "bq1": bq1,
        "bq2": bq2,
        "bq3": bq3,
        "bq4": bq4,
        "bq5": bq5,
        "sq1": sq1,
        "sq2": sq2,
        "sq3": sq3,
        "sq4": sq4,
        "sq5": sq5,
        "bp1": bp1,
        "bp2": bp2,
        'bp3': bp3,
        "bp4": bp4,
        "bp5": bp5,
        "sp1": sp1,
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
        "oi": oi,
        "poi": poi,
        "toi": toi,
        "ft": ft
      };
}
