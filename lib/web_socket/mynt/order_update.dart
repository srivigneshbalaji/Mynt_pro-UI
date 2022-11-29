// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

OrderUpdateStream orderUpdateStreamFromJson(String str) =>
    OrderUpdateStream.fromJson(json.decode(str) as Map<String, dynamic>);

String orderUpdateStreamToJson(OrderUpdateStream data) =>
    json.encode(data.toJson());

class OrderUpdateStream {
  OrderUpdateStream({
    required this.t,
    required this.norenordno,
    required this.uid,
    required this.actid,
    required this.exch,
    required this.tsym,
    required this.qty,
    required this.prc,
    required this.prd,
    required this.status,
    required this.reporttype,
    required this.trantype,
    required this.prctyp,
    required this.ret,
    required this.fillshares,
    required this.avgprc,
    required this.fltm,
    required this.flid,
    required this.flqty,
    required this.flprc,
    required this.rejreason,
    required this.exchordid,
    required this.cancelqty,
    required this.remarks,
    required this.dscqty,
    required this.trgprc,
    required this.snonum,
    required this.snoordt,
    required this.blprc,
    required this.bpprc,
    required this.trailprc,
    required this.exch_tm,
  });

  String? t;
  String? norenordno;
  String? uid;
  String? actid;
  String? exch;
  String? tsym;
  String? qty;
  String? prc;
  String? prd;
  String? status;
  String? reporttype;
  String? trantype;
  String? prctyp;
  String? ret;
  String? fillshares;
  String? avgprc;
  String? fltm;
  String? flid;
  String? flqty;
  String? flprc;
  String? rejreason;
  String? exchordid;
  String? cancelqty;
  String? remarks;
  String? dscqty;
  String? trgprc;
  String? snonum;
  String? snoordt;
  String? blprc;
  String? bpprc;
  String? trailprc;
  String? exch_tm;

  factory OrderUpdateStream.fromJson(Map<String, dynamic> json) {
    final String? task =
        json["t"].toString() == null || json["t"].toString() == "null"
            ? null
            : json["t"].toString();
    final String? uid =
        json["uid"].toString() == null || json["uid"].toString() == "null"
            ? null
            : json["uid"].toString();
    final String? norenOrdNo = json["norenordno"].toString() == null ||
            json["norenordno"].toString() == "null"
        ? null
        : json["norenordno"].toString();

    final String? exch =
        json["exch"].toString() == null || json["exch"].toString() == "null"
            ? null
            : json["exch"].toString();
    final String? tsym =
        json["tsym"].toString() == null || json["tsym"].toString() == "null"
            ? null
            : json["tsym"].toString();
    final String? qty =
        json["qty"].toString() == null || json["qty"].toString() == "null"
            ? null
            : json["qty"].toString();
    final String? prc =
        json["prc"].toString() == null || json["prc"].toString() == "null"
            ? null
            : json["prc"].toString();
    final String? prd =
        json["prd"].toString() == null || json["prd"].toString() == "null"
            ? null
            : json["prd"].toString();
    final String? status =
        json["status"].toString() == null || json["status"].toString() == "null"
            ? null
            : json["status"].toString();
    final String? reporttype = json["reporttype"].toString() == null ||
            json["reporttype"].toString() == "null"
        ? null
        : json["reporttype"].toString();
    final String? prcTyp =
        json["prctyp"].toString() == null || json["prctyp"].toString() == "null"
            ? null
            : json["prctyp"].toString();
    final String? actId =
        json["actid"].toString() == null || json["actid"].toString() == "null"
            ? null
            : json["actid"].toString();
    final String? ret =
        json["ret"].toString() == null || json["ret"].toString() == "null"
            ? null
            : json["ret"].toString();
    final String? fillShares = json["fillshares"].toString() == null ||
            json["fillshares"].toString() == "null"
        ? null
        : json["fillshares"].toString();
    final String? avgPrc =
        json["avgprc"].toString() == null || json["avgprc"].toString() == "null"
            ? null
            : json["avgprc"].toString();
    final String? fltm =
        json["fltm"].toString() == null || json["fltm"].toString() == "null"
            ? null
            : json["fltm"].toString();
    final String? flid =
        json["flid"].toString() == null || json["flid"].toString() == "null"
            ? null
            : json["flid"].toString();
    final String? flqty =
        json["flqty"].toString() == null || json["flqty"].toString() == "null"
            ? null
            : json["flqty"].toString();
    final String? flprc =
        json["flprc"].toString() == null || json["flprc"].toString() == "null"
            ? null
            : json["flprc"].toString();
    final String? rejReason = json["rejreason"].toString() == null ||
            json["rejreason"].toString() == "null"
        ? null
        : json["rejreason"].toString();
    final String? exchordid = json["exchordid"].toString() == null ||
            json["exchordid"].toString() == "null"
        ? null
        : json["exchordid"].toString();
    final String? cancelQty = json["cancelqty"].toString() == null ||
            json["cancelqty"].toString() == "null"
        ? null
        : json["cancelqty"].toString();
    final String? remarks = json["remarks"].toString() == null ||
            json["remarks"].toString() == "null"
        ? null
        : json["remarks"].toString();
    final String? dscQty =
        json["dscqty"].toString() == null || json["dscqty"].toString() == "null"
            ? null
            : json["dscqty"].toString();
    final String? trgprc =
        json["trgprc"].toString() == null || json["trgprc"].toString() == "null"
            ? null
            : json["trgprc"].toString();

    final String? trantype = json["trantype"].toString() == null ||
            json["trantype"].toString() == "null"
        ? null
        : json["trantype"].toString();
    final String? snonum =
        json["snonum"].toString() == null || json["snonum"].toString() == "null"
            ? null
            : json["snonum"].toString();
    final String? snoordt = json["snoordt"].toString() == null ||
            json["snoordt"].toString() == "null"
        ? null
        : json["snoordt"].toString();
    final String? blprc =
        json["blprc"].toString() == null || json["blprc"].toString() == "null"
            ? null
            : json["blprc"].toString();
    final String? bpprc =
        json["bpprc"].toString() == null || json["bpprc"].toString() == "null"
            ? null
            : json["bpprc"].toString();
    final String? trailPrc = json["trailprc"].toString() == null ||
            json["trailprc"].toString() == "null"
        ? null
        : json["trailprc"].toString();
    final String? exchTm = json["exch_tm"].toString() == null ||
            json["exch_tm"].toString() == "null"
        ? null
        : json["exch_tm"].toString();
    return OrderUpdateStream(
      t: task,
      norenordno: norenOrdNo,
      uid: uid,
      actid: actId,
      exch: exch,
      tsym: tsym,
      qty: qty,
      prc: prc,
      prd: prd,
      status: status,
      reporttype: reporttype,
      trantype: trantype,
      prctyp: prcTyp,
      ret: ret,
      fillshares: fillShares,
      avgprc: avgPrc,
      fltm: fltm,
      flid: flid,
      flqty: flqty,
      flprc: flprc,
      rejreason: rejReason,
      exchordid: exchordid,
      cancelqty: cancelQty,
      remarks: remarks,
      dscqty: dscQty,
      trgprc: trgprc,
      snonum: snonum,
      snoordt: snoordt,
      blprc: blprc,
      bpprc: bpprc,
      trailprc: trailPrc,
      exch_tm: exchTm,
    );
  }

  Map<String, dynamic> toJson() => {
        "t": t,
        "norenordno": norenordno,
        "uid": uid,
        "actid": actid,
        "exch": exch,
        "tsym": tsym,
        "qty": qty,
        "prc": prc,
        "prd": prd,
        "status": status,
        "reporttype": reporttype,
        "trantype": trantype,
        "prctyp": prctyp,
        "ret": ret,
        "fillshares": fillshares,
        "avgprc": avgprc,
        "fltm": fltm,
        "flid": flid,
        "flqty": flqty,
        "flprc": flprc,
        "rejreason": rejreason,
        "exchordid": exchordid,
        "cancelqty": cancelqty,
        "remarks": remarks,
        "dscqty": dscqty,
        "trgprc": trgprc,
        "snonum": snonum,
        "snoordt": snoordt,
        "blprc": blprc,
        "bpprc": bpprc,
        "trailprc": trailprc,
        "exch_tm": exch_tm
      };
}
