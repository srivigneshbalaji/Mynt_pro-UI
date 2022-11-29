class MarketWatchScrips {
  String stat;
  List<Values> values;

  MarketWatchScrips({
    required this.stat,
    required this.values,
  });

  factory MarketWatchScrips.fromJson(Map<String, dynamic> json) {
    final List<Values> values = [];
    if (json['values'] != null) {
      json['values'].forEach((v) {
        values.add(Values.fromJson(v as Map<String, dynamic>));
      });
    }
    return MarketWatchScrips(
      stat: json['stat'].toString(),
      values: values,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stat'] = stat;
    data['values'] = values.map((v) => v.toJson()).toList();
    return data;
  }
}

class Values {
  String? tcksize;
  String? openinterest;
  String? optiontype;
  String? bestSellPrice;
  String? exchSeg;
  String? defmktproval;
  String? combinedSymbol;
  String? symbolname;
  String? bestBuySize;
  String? noMktPro;
  String? mktpro;
  String? high;
  String? lasttradedtime;
  String? bestSellSize;
  String? low;
  String? averageprice;
  String? lasttradedquantity;
  String? strikeprice;
  String? close;
  String? expiry;
  String? tradSym;
  String? spotprice;
  String? bestBuyPrice;
  String? scripRemarks;
  String? totalbuyqty;
  int? multiplier;
  String? totalsellqty;
  String? ltp;
  String? change;
  int? decimalPrecision;
  String? token;
  String? exc;
  String? series;
  String? corporateaction;
  String? uniqueKey;
  String? perChange;
  String? instrument_name;
  String? instrument;
  String? tradeVolume;
  int? bodlot;
  int? maxQty;
  String? open;
  String? expdate;
  String? discQty;
  int? minQty;
  String? lcl;
  String? ucl;
  String? instrumentName;
  bool? isAlive;
  bool? isFundamentalAvailable;

  Values(
      {this.tcksize,
      this.openinterest,
      this.optiontype,
      this.bestSellPrice,
      this.exchSeg,
      this.defmktproval,
      this.combinedSymbol,
      this.symbolname,
      this.bestBuySize,
      this.noMktPro,
      this.mktpro,
      this.high,
      this.lasttradedtime,
      this.bestSellSize,
      this.low,
      this.averageprice,
      this.lasttradedquantity,
      this.strikeprice,
      this.close,
      this.expiry,
      this.tradSym,
      this.spotprice,
      this.bestBuyPrice,
      this.scripRemarks,
      this.totalbuyqty,
      this.multiplier,
      this.totalsellqty,
      this.ltp,
      this.change,
      this.decimalPrecision,
      this.token,
      this.exc,
      this.series,
      this.corporateaction,
      this.uniqueKey,
      this.perChange,
      this.instrument_name,
      this.instrument,
      this.tradeVolume,
      this.bodlot,
      this.maxQty,
      this.open,
      this.expdate,
      this.discQty,
      this.minQty,
      this.lcl = "00",
      this.ucl = "00",
      this.instrumentName,
      this.isAlive,
      this.isFundamentalAvailable});

  factory Values.fromJson(Map<String, dynamic> json) {
    String instName = "";
    bool fundamentalAliveCheck = false;
    const bool isAliveStatus = true;
    return Values(
        tcksize: json['tcksize'].toString(),
        openinterest: json['openinterest'].toString(),
        optiontype: json['optiontype'].toString(),
        bestSellPrice: json['BestSellPrice'].toString(),
        exchSeg: json['ExchSeg'].toString(),
        defmktproval: json['defmktproval'].toString(),
        combinedSymbol: json['CombinedSymbol'].toString(),
        symbolname: json['tysm'].toString(),
        bestBuySize: json['BestBuySize'].toString(),
        noMktPro: json['noMktPro'].toString(),
        mktpro: json['mktpro'].toString(),
        high: json['high'].toString(),
        lasttradedtime: json['lasttradedtime'].toString(),
        bestSellSize: json['BestSellSize'].toString(),
        low: json['low'].toString(),
        averageprice: json['averageprice'].toString(),
        lasttradedquantity: json['lasttradedquantity'].toString(),
        strikeprice: json['strikeprice'].toString(),
        close: json['close'].toString(),
        expiry: json['Expiry'].toString(),
        tradSym: json['TradSym'].toString(),
        spotprice: json['spotprice'].toString(),
        bestBuyPrice: json['BestBuyPrice'].toString(),
        scripRemarks: json['scripRemarks'].toString(),
        totalbuyqty: json['totalbuyqty'].toString(),
        multiplier: json['multiplier'],
        totalsellqty: json['totalsellqty'].toString(),
        ltp: json['ltp'].toString(),
        change: json['Change'].toString(),
        decimalPrecision: json['decimalPrecision'],
        token: json['token'].toString(),
        exc: json['exch'].toString(),
        series: json['Series'].toString(),
        corporateaction: json['corporateaction'].toString(),
        uniqueKey: json['UniqueKey'].toString(),
        perChange: json['PerChange'].toString(),
        instrument_name: json['instrument_name'].toString(),
        instrument: json['Instrument'].toString(),
        tradeVolume: json['TradeVolume'].toString(),
        bodlot: json['bodlot'],
        maxQty: json['maxQty'],
        open: json['open'].toString(),
        expdate: json['expdate'].toString(),
        discQty: json['discQty'].toString(),
        minQty: json['minQty'],
        instrumentName: instName,
        isAlive: isAliveStatus,
        isFundamentalAvailable: fundamentalAliveCheck);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tcksize'] = tcksize;
    data['openinterest'] = openinterest;
    data['optiontype'] = optiontype;
    data['BestSellPrice'] = bestSellPrice;
    data['ExchSeg'] = exchSeg;
    data['defmktproval'] = defmktproval;
    data['CombinedSymbol'] = combinedSymbol;
    data['symbolname'] = symbolname;
    data['BestBuySize'] = bestBuySize;
    data['noMktPro'] = noMktPro;
    data['mktpro'] = mktpro;
    data['high'] = high;
    data['lasttradedtime'] = lasttradedtime;
    data['BestSellSize'] = bestSellSize;
    data['low'] = low;
    data['averageprice'] = averageprice;
    data['lasttradedquantity'] = lasttradedquantity;
    data['strikeprice'] = strikeprice;
    data['close'] = close;
    data['Expiry'] = expiry;
    data['TradSym'] = tradSym;
    data['spotprice'] = spotprice;
    data['BestBuyPrice'] = bestBuyPrice;
    data['scripRemarks'] = scripRemarks;
    data['totalbuyqty'] = totalbuyqty;
    data['multiplier'] = multiplier;
    data['totalsellqty'] = totalsellqty;
    data['ltp'] = ltp;
    data['Change'] = change;
    data['decimalPrecision'] = decimalPrecision;
    data['token'] = token;
    data['Exchange'] = exc;
    data['Series'] = series;
    data['corporateaction'] = corporateaction;
    data['UniqueKey'] = uniqueKey;
    data['PerChange'] = perChange;
    data['instrument_name'] = instrument_name;
    data['Instrument'] = instrument;
    data['TradeVolume'] = tradeVolume;
    data['bodlot'] = bodlot;
    data['maxQty'] = maxQty;
    data['open'] = open;
    data['expdate'] = expdate;
    data['discQty'] = discQty;
    data['minQty'] = minQty;
    return data;
  }
}
