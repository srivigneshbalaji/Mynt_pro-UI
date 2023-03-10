import 'package:flutter/material.dart';

class WatchListModel extends ChangeNotifier {
  final String symbolName;
  final String exc;
  final double ltp;
  final double change;
  final double perChange;
  final int tokenValue;
  static bool listOverView = false;
  static bool settingsExp = false;
  static bool isvisible = true;
  static bool onvisible = false;
  static int selectedIndex = 1;
  static String watchStat = "";
  static List mWatchList = [];
  static List mWatchList1 = [];
  static List mWatchList2 = [];
  static List mWatchList3 = [];
  static List mWatchList4 = [];
  static List mWatchList5 = [];
  static Icon actionIcon = const Icon(Icons.search);
  WatchListModel({
    required this.symbolName,
    required this.exc,
    required this.ltp,
    required this.change,
    required this.perChange,
    required this.tokenValue,
  });

  static List<WatchListModel> watchlistDatas = [
    WatchListModel(
        symbolName: 'WIPRO',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: 3.20,
        tokenValue: 3787),
    WatchListModel(
        symbolName: 'TCS',
        exc: 'NSE',
        ltp: 374.40,
        change: -10.00,
        perChange: 9,
        tokenValue: 11536),
    WatchListModel(
        symbolName: 'RELIANCE',
        exc: 'NSE',
        ltp: 993.35,
        change: -10.00,
        perChange: -0.99,
        tokenValue: 2885),
    WatchListModel(
        symbolName: 'GOLDBEES',
        exc: 'NSE',
        ltp: 17294.40,
        change: 108.70,
        perChange: 0.64,
        tokenValue: 14428),
    WatchListModel(
        symbolName: 'TATAMOTORS',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: -10,
        tokenValue: 3456),
    WatchListModel(
        symbolName: 'HCLTECH',
        exc: 'NSE',
        ltp: 3108.50,
        change: 9.35,
        perChange: 0.03,
        tokenValue: 7229),
    WatchListModel(
        symbolName: 'DELTACORP',
        exc: 'NSE',
        ltp: 3434.50,
        change: 36.00,
        perChange: -1.52,
        tokenValue: 15044),
    WatchListModel(
        symbolName: 'JSWSTEEL',
        exc: 'NSE',
        ltp: 9785.50,
        change: 36.00,
        perChange: 1.52,
        tokenValue: 11723),
    WatchListModel(
        symbolName: 'HINDALCO',
        exc: 'NSE',
        ltp: 34465.50,
        change: 36.00,
        perChange: -0.92,
        tokenValue: 1363),
    WatchListModel(
        symbolName: 'TATASTEEL',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: 3,
        tokenValue: 3499),
    WatchListModel(
        symbolName: 'TITAN',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: 6,
        tokenValue: 3506),
    WatchListModel(
        symbolName: 'SUNPHARMA',
        exc: 'NSE',
        ltp: 23356.50,
        change: 36.00,
        perChange: -6,
        tokenValue: 3351),
    WatchListModel(
        symbolName: 'CIPLA',
        exc: 'NSE',
        ltp: 1234.50,
        change: 36.00,
        perChange: -7.9,
        tokenValue: 694),
    WatchListModel(
        symbolName: 'DRREDDY',
        exc: 'NSE',
        ltp: 9876.50,
        change: 36.00,
        perChange: -8,
        tokenValue: 881),
    WatchListModel(
        symbolName: 'KOTAKBANK',
        exc: 'NSE',
        ltp: 456.50,
        change: 36.00,
        perChange: -9.2,
        tokenValue: 1922),
    WatchListModel(
        symbolName: 'BHARTIARTL',
        exc: 'NSE',
        ltp: 654.50,
        change: 36.00,
        perChange: 9.52,
        tokenValue: 10604),
    WatchListModel(
        symbolName: 'AXISBANK',
        exc: 'NSE',
        ltp: 5678,
        change: 36.00,
        perChange: 8.52,
        tokenValue: 5900),
    WatchListModel(
        symbolName: 'BAJFINANCE',
        exc: 'NSE',
        ltp: 2408,
        change: 36.00,
        perChange: -7.52,
        tokenValue: 317),
    WatchListModel(
        symbolName: 'EICHERMOT',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: 6.52,
        tokenValue: 910),
    WatchListModel(
        symbolName: 'BAJAJFINSV',
        exc: 'NSE',
        ltp: 24086,
        change: 36.00,
        perChange: 5.52,
        tokenValue: 16675),
    WatchListModel(
        symbolName: 'MARUTI',
        exc: 'NSE',
        ltp: 6565.50,
        change: 36.00,
        perChange: 4.52,
        tokenValue: 10999),
    WatchListModel(
        symbolName: 'SBILIFE',
        exc: 'NSE',
        ltp: 8675.50,
        change: 36.00,
        perChange: 3.52,
        tokenValue: 21808),
    WatchListModel(
        symbolName: 'HINDUNILVR',
        exc: 'NSE',
        ltp: 5453.50,
        change: 36.00,
        perChange: 2.52,
        tokenValue: 1394),
    WatchListModel(
        symbolName: 'HCLTECH',
        exc: 'NSE',
        ltp: 78575.50,
        change: 36.00,
        perChange: 1.52,
        tokenValue: 7229),
    WatchListModel(
        symbolName: 'HEROMOTOCO',
        exc: 'NSE',
        ltp: 122324.50,
        change: 36.00,
        perChange: 0.52,
        tokenValue: 1348),
    WatchListModel(
        symbolName: 'ITC',
        exc: 'NSE',
        ltp: 1111.0,
        change: 36.00,
        perChange: 9.52,
        tokenValue: 1660),
    WatchListModel(
        symbolName: 'BAJAJ-AUTO',
        exc: 'NSE',
        ltp: 8665,
        change: 36.00,
        perChange: 8.52,
        tokenValue: 16669),
    WatchListModel(
        symbolName: 'ADANIENT',
        exc: 'NSE',
        ltp: 07876.50,
        change: 36.00,
        perChange: 7.52,
        tokenValue: 25),
    WatchListModel(
        symbolName: 'ADANIPORTS',
        exc: 'NSE',
        ltp: 0907.50,
        change: 36.00,
        perChange: 6.52,
        tokenValue: 15083),
    WatchListModel(
        symbolName: 'APOLLOHOSP',
        exc: 'NSE',
        ltp: 00766.50,
        change: 36.00,
        perChange: 2.52,
        tokenValue: 157),
    WatchListModel(
        symbolName: 'ASIANPAINT',
        exc: 'NSE',
        ltp: 0076,
        change: .96,
        perChange: 3.52,
        tokenValue: 236),
    WatchListModel(
        symbolName: 'BPCL',
        exc: 'NSE',
        ltp: 4567.50,
        change: 36.00,
        perChange: 74.52,
        tokenValue: 526),
    WatchListModel(
        symbolName: 'BRITANNIA',
        exc: 'NSE',
        ltp: 43346.50,
        change: 36.00,
        perChange: -20.52,
        tokenValue: 547),
    WatchListModel(
        symbolName: 'COALINDIA',
        exc: 'NSE',
        ltp: 08756.50,
        change: 36.00,
        perChange: 7.2,
        tokenValue: 20374),
    WatchListModel(
        symbolName: 'DIVISLAB',
        exc: 'NSE',
        ltp: -32546.50,
        change: 36.00,
        perChange: -91.52,
        tokenValue: 10940),
    WatchListModel(
        symbolName: 'GRASIM',
        exc: 'NSE',
        ltp: -2408.50,
        change: 36.00,
        perChange: 64,
        tokenValue: 1232),
    WatchListModel(
        symbolName: 'HDFCBANK',
        exc: 'NSE',
        ltp: -434.50,
        change: 36.00,
        perChange: 0.5324,
        tokenValue: 1333),
    WatchListModel(
        symbolName: 'ICICIBANK',
        exc: 'NSE',
        ltp: -2422.50,
        change: 36.00,
        perChange: 1.52,
        tokenValue: 4963),
    WatchListModel(
        symbolName: 'INDUSINDBK',
        exc: 'NSE',
        ltp: -976867,
        change: 36.00,
        perChange: .512,
        tokenValue: 5258),
    WatchListModel(
        symbolName: 'INFY',
        exc: 'NSE',
        ltp: -5435.50,
        change: 36.00,
        perChange: -219,
        tokenValue: 1594),
    WatchListModel(
        symbolName: 'LT',
        exc: 'NSE',
        ltp: -7564.50,
        change: 36.00,
        perChange: 0.4543,
        tokenValue: 11483),
    WatchListModel(
        symbolName: 'M&M',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: 6,
        tokenValue: 2031),
    WatchListModel(
        symbolName: 'NTPC',
        exc: 'NSE',
        ltp: -7657.50,
        change: 36.00,
        perChange: 5,
        tokenValue: 11630),
    WatchListModel(
        symbolName: 'NESTLEIND',
        exc: 'NSE',
        ltp: -54353.50,
        change: 36.00,
        perChange: 0.52,
        tokenValue: 17963),
    WatchListModel(
        symbolName: 'ONGC',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: 2,
        tokenValue: 2475),
    WatchListModel(
        symbolName: 'POWERGRID',
        exc: 'NSE',
        ltp: 44543.50,
        change: 36.00,
        perChange: 5,
        tokenValue: 14977),
    WatchListModel(
        symbolName: 'SBIN',
        exc: 'NSE',
        ltp: 454345.50,
        change: 36.00,
        perChange: 8.52,
        tokenValue: 3045),
    WatchListModel(
        symbolName: 'ULTRACEMCO',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: -16,
        tokenValue: 11532),
    WatchListModel(
        symbolName: 'UPL',
        exc: 'NSE',
        ltp: 966,
        change: 36.00,
        perChange: 4,
        tokenValue: 11287),
    WatchListModel(
        symbolName: 'TECHM',
        exc: 'NSE',
        ltp: 86644.50,
        change: 36.00,
        perChange: 34,
        tokenValue: 13538),
    WatchListModel(
        symbolName: 'INFOBEAN',
        exc: 'NSE',
        ltp: 7674,
        change: 36.00,
        perChange: 56,
        tokenValue: 11027),
  ];
}
