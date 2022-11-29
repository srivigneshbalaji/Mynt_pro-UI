class MarketDepthScrips {
  String stat;
  List<MarketDepth> mdpdata;

  MarketDepthScrips({
    required this.stat,
    required this.mdpdata,
  });

  factory MarketDepthScrips.fromJson(Map<String, dynamic> json) {
    final List<MarketDepth> mdpdata = [];
    if (json['values'] != null) {
      json['values'].forEach((v) {
        mdpdata.add(MarketDepth.fromJson(v as Map<String, dynamic>));
      });
    }
    return MarketDepthScrips(
      stat: json['stat'].toString(),
      mdpdata: mdpdata,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stat'] = stat;
    data['values'] = mdpdata.map((v) => v.toJson()).toList();
    return data;
  }
}

class MarketDepth {
  String? openinterest;
  String? trend;
  String? sQty3;
  String? sQty4;
  String? sQty5;
  String? sQty1;
  String? sQty2;
  String? bOrders2;
  String? open;
  String? close;
  String? exc;
  String? low;
  String? symbolname;
  String? high;
  String? change;
  String? highrate;
  String? bOrders1;
  String? sPrice1;
  String? sPrice2;
  String? sPrice3;
  String? tradingSymbol;
  String? bOrders5;
  String? triggerpercent;
  String? sPrice4;
  String? bOrders4;
  String? sPrice5;
  String? bOrders3;
  String? totalsellqty;
  String? lowercircuitlimit;
  String? volume;
  String? corporateaction;
  String? companyname;
  String? bPrice5;
  String? bPrice3;
  String? bPrice4;
  String? yearlylowprice;
  String? bPrice1;
  String? bPrice2;
  String? abschange;
  String? symbol;
  String? symbolName;
  String? ltp;
  String? openrate;
  String? lasttradedtime;
  String? bQty1;
  String? bQty2;
  String? bQty3;
  String? yearlyhighprice;
  String? sOrders5;
  String? sOrders4;
  String? sOrders3;
  String? value;
  String? sOrders2;
  String? sOrders1;
  String? spotprice;
  String? lasttradedqty;
  String? stat;
  String? previouscloserate;
  String? totalbuyqty;
  String? bQty4;
  String? bQty5;
  String? exchg;
  String? weightedavg;
  String? highercircuitlimit;
  String? series;
  String? perChange;
  String? lowrate;
  String? token;
  String? tickSize;
  String? lotSize;
  String? averagePrice;

  MarketDepth({
    this.openinterest,
    this.trend,
    this.sQty3,
    this.sQty4,
    this.sQty5,
    this.sQty1,
    this.sQty2,
    this.bOrders2,
    this.high,
    this.open,
    this.low,
    this.symbolname,
    this.exc,
    this.highrate,
    this.bOrders1,
    this.sPrice1,
    this.sPrice2,
    this.sPrice3,
    this.tradingSymbol,
    this.bOrders5,
    this.triggerpercent,
    this.sPrice4,
    this.bOrders4,
    this.sPrice5,
    this.bOrders3,
    this.totalsellqty,
    this.lowercircuitlimit,
    this.volume,
    this.corporateaction,
    this.companyname,
    this.bPrice5,
    this.bPrice3,
    this.bPrice4,
    this.yearlylowprice,
    this.bPrice1,
    this.bPrice2,
    this.abschange,
    this.symbol,
    this.symbolName,
    this.ltp,
    this.openrate,
    this.lasttradedtime,
    this.bQty1,
    this.bQty2,
    this.bQty3,
    this.yearlyhighprice,
    this.sOrders5,
    this.sOrders4,
    this.sOrders3,
    this.value,
    this.sOrders2,
    this.sOrders1,
    this.spotprice,
    this.lasttradedqty,
    this.stat,
    this.previouscloserate,
    this.totalbuyqty,
    this.bQty4,
    this.bQty5,
    this.exchg,
    this.weightedavg,
    this.highercircuitlimit,
    this.series,
    this.perChange,
    this.lotSize,
    this.tickSize,
    this.lowrate,
    this.averagePrice,
    this.close,
    this.token,
  });

  factory MarketDepth.fromJson(Map<String, dynamic> json) {
    String tickSizeVal = "0.0";
    String lotSizeVal = "0";
    String averagePriceVal = "0";
    try {
      tickSizeVal = (json['tickSize'] ?? "0.0").toString();
    } catch (e) {
      tickSizeVal = "0.0";
    }
    try {
      lotSizeVal = (json['lotSize'] ?? "0").toString();
    } catch (e) {
      lotSizeVal = "0";
    }

    return MarketDepth(
      openinterest: json['openinterest']?.toString().replaceAll(",", ""),
      trend: json['trend']?.toString().replaceAll(",", ""),
      sQty3: json['SQty3']?.toString().replaceAll(",", ""),
      sQty4: json['SQty4']?.toString().replaceAll(",", ""),
      sQty5: json['SQty5']?.toString().replaceAll(",", ""),
      sQty1: json['SQty1']?.toString().replaceAll(",", ""),
      sQty2: json['SQty2']?.toString().replaceAll(",", ""),
      token: json['token'].toString(),
      high: json['high'].toString(),
      low: json['low'].toString(),
      close: json['close'].toString(),
      open: json['open'].toString(),
      symbolname: json['symbol'].toString(),
      bOrders2: json['BOrders2']?.toString().replaceAll(",", ""),
      highrate: json['highrate']?.toString().replaceAll(",", ""),
      bOrders1: json['BOrders1']?.toString().replaceAll(",", ""),
      sPrice1: json['SPrice1']?.toString().replaceAll(",", ""),
      sPrice2: json['SPrice2']?.toString().replaceAll(",", ""),
      sPrice3: json['SPrice3']?.toString().replaceAll(",", ""),
      tradingSymbol: json['TradingSymbol']?.toString().replaceAll(",", ""),
      bOrders5: json['BOrders5']?.toString().replaceAll(",", ""),
      triggerpercent: json['triggerpercent']?.toString().replaceAll(",", ""),
      sPrice4: json['SPrice4']?.toString().replaceAll(",", ""),
      bOrders4: json['BOrders4']?.toString().replaceAll(",", ""),
      sPrice5: json['SPrice5']?.toString().replaceAll(",", ""),
      bOrders3: json['BOrders3']?.toString().replaceAll(",", ""),
      totalsellqty: json['totalsellqty']?.toString().replaceAll(",", ""),
      lowercircuitlimit:
          json['lowercircuitlimit']?.toString().replaceAll(",", ""),
      volume: json['volume']?.toString().replaceAll(",", ""),
      corporateaction: json['corporateaction']?.toString().replaceAll(",", ""),
      companyname: json['companyname']?.toString().replaceAll(",", ""),
      bPrice5: json['BPrice5']?.toString().replaceAll(",", ""),
      bPrice3: json['BPrice3']?.toString().replaceAll(",", ""),
      bPrice4: json['BPrice4']?.toString().replaceAll(",", ""),
      yearlylowprice: json['yearlylowprice']?.toString().replaceAll(",", ""),
      bPrice1: json['BPrice1']?.toString().replaceAll(",", ""),
      bPrice2: json['BPrice2']?.toString().replaceAll(",", ""),
      abschange: json['abschange']?.toString().replaceAll(",", ""),
      symbol: json['Symbol']?.toString().replaceAll(",", ""),
      symbolName: json['SymbolName']?.toString().replaceAll(",", ""),
      ltp: json['Ltp']?.toString().replaceAll(",", ""),
      openrate: json['openrate']?.toString().replaceAll(",", ""),
      lasttradedtime: json['lasttradedtime']?.toString().replaceAll(",", ""),
      bQty1: json['BQty1']?.toString().replaceAll(",", ""),
      bQty2: json['BQty2']?.toString().replaceAll(",", ""),
      bQty3: json['BQty3']?.toString().replaceAll(",", ""),
      yearlyhighprice: json['yearlyhighprice']?.toString().replaceAll(",", ""),
      sOrders5: json['SOrders5']?.toString().replaceAll(",", ""),
      sOrders4: json['SOrders4']?.toString().replaceAll(",", ""),
      sOrders3: json['SOrders3']?.toString().replaceAll(",", ""),
      value: json['value']?.toString().replaceAll(",", ""),
      sOrders2: json['SOrders2']?.toString().replaceAll(",", ""),
      sOrders1: json['SOrders1']?.toString().replaceAll(",", ""),
      spotprice: json['spotprice']?.toString().replaceAll(",", ""),
      lasttradedqty: json['lasttradedqty']?.toString().replaceAll(",", ""),
      stat: json['stat']?.toString().replaceAll(",", ""),
      previouscloserate:
          json['previouscloserate']?.toString().replaceAll(",", ""),
      totalbuyqty: json['totalbuyqty']?.toString().replaceAll(",", ""),
      bQty4: json['BQty4']?.toString().replaceAll(",", ""),
      bQty5: json['BQty5']?.toString().replaceAll(",", ""),
      exchg: json['Exchg']?.toString().replaceAll(",", ""),
      exc: json['exc']?.toString().replaceAll(",", ""),
      weightedavg: json['weightedavg']?.toString().replaceAll(",", ""),
      highercircuitlimit:
          json['highercircuitlimit']?.toString().replaceAll(",", ""),
      series: json['series']?.toString().replaceAll(",", ""),
      perChange: json['PerChange']?.toString().replaceAll(",", ""),
      lowrate: json['lowrate']?.toString().replaceAll(",", ""),
      lotSize: lotSizeVal,
      tickSize: tickSizeVal,
      averagePrice: averagePriceVal,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String, dynamic>{};
    data['openinterest'] = openinterest;
    data['trend'] = trend;
    data['SQty3'] = sQty3;
    data['SQty4'] = sQty4;
    data['SQty5'] = sQty5;
    data['SQty1'] = sQty1;
    data['SQty2'] = sQty2;
    data['token'] = token;
    data['BOrders2'] = bOrders2;
    data['high'] = high;
    data['symbolname'] = symbolname;
    data['Change'] = change;
    data['low'] = low;
    data['highrate'] = highrate;
    data['BOrders1'] = bOrders1;
    data['SPrice1'] = sPrice1;
    data['SPrice2'] = sPrice2;
    data['SPrice3'] = sPrice3;
    data['TradingSymbol'] = tradingSymbol;
    data['BOrders5'] = bOrders5;
    data['triggerpercent'] = triggerpercent;
    data['SPrice4'] = sPrice4;
    data['BOrders4'] = bOrders4;
    data['SPrice5'] = sPrice5;
    data['BOrders3'] = bOrders3;
    data['totalsellqty'] = totalsellqty;
    data['lowercircuitlimit'] = lowercircuitlimit;
    data['volume'] = volume;
    data['corporateaction'] = corporateaction;
    data['companyname'] = companyname;
    data['BPrice5'] = bPrice5;
    data['BPrice3'] = bPrice3;
    data['BPrice4'] = bPrice4;
    data['yearlylowprice'] = yearlylowprice;
    data['BPrice1'] = bPrice1;
    data['BPrice2'] = bPrice2;
    data['abschange'] = abschange;
    data['Symbol'] = symbol;
    data['SymbolName'] = symbolName;
    data['Ltp'] = ltp;
    data['openrate'] = openrate;
    data['lasttradedtime'] = lasttradedtime;
    data['BQty1'] = bQty1;
    data['BQty2'] = bQty2;
    data['BQty3'] = bQty3;
    data['yearlyhighprice'] = yearlyhighprice;
    data['SOrders5'] = sOrders5;
    data['SOrders4'] = sOrders4;
    data['SOrders3'] = sOrders3;
    data['value'] = value;
    data['SOrders2'] = sOrders2;
    data['SOrders1'] = sOrders1;
    data['spotprice'] = spotprice;
    data['lasttradedqty'] = lasttradedqty;
    data['stat'] = stat;
    data['previouscloserate'] = previouscloserate;
    data['totalbuyqty'] = totalbuyqty;
    data['BQty4'] = bQty4;
    data['BQty5'] = bQty5;
    data['Exchg'] = exchg;
    data['exc'] = exc;
    data['weightedavg'] = weightedavg;
    data['highercircuitlimit'] = highercircuitlimit;
    data['series'] = series;
    data['PerChange'] = perChange;
    data['lowrate'] = lowrate;
    return data;
  }
}

class DepthArguments {
  String exchange;
  String token;
  String instrument;
  String instrumentType;
  bool isAddExit;
  DepthArguments(
      {required this.exchange,
      required this.token,
      required this.instrument,
      required this.isAddExit,
      required this.instrumentType});
}
