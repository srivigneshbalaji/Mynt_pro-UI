import 'package:flutter/material.dart';

class PortfolioModel extends ChangeNotifier {
  final String symbolName;
  final String exc;
  final double ltp;
  final double change;
  final double perChange;
  final int tokenValue;
  static Icon actionIcon = const Icon(Icons.search);
  PortfolioModel({
    required this.symbolName,
    required this.exc,
    required this.ltp,
    required this.change,
    required this.perChange,
    required this.tokenValue,
  });

  static List<PortfolioModel> portfolioDatas = [
    PortfolioModel(
        symbolName: 'WIPRO',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: 1.52,
        tokenValue: 3787),
    PortfolioModel(
        symbolName: 'TITAN',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: 1.52,
        tokenValue: 3506),
    PortfolioModel(
        symbolName: 'RELIANCE',
        exc: 'NSE',
        ltp: 993.35,
        change: -10.00,
        perChange: -0.99,
        tokenValue: 2885),
    PortfolioModel(
        symbolName: 'DRREDDY',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: 1.52,
        tokenValue: 881),
    PortfolioModel(
        symbolName: 'KOTAKBANK',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: 1.52,
        tokenValue: 1922),
    PortfolioModel(
        symbolName: 'UPL',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: 1.52,
        tokenValue: 11287),
    PortfolioModel(
        symbolName: 'TATAMOTORS',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: -10,
        tokenValue: 3456),
    PortfolioModel(
        symbolName: 'ICICIBANK',
        exc: 'NSE',
        ltp: 2408.50,
        change: 36.00,
        perChange: 1.52,
        tokenValue: 4963),
  ];
}
