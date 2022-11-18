// class DraggableIndexList {
//   final List<IndexListItem> items;

//   const DraggableIndexList({
//     required this.items,
//   });
// }

class IndexListItem {
  final String symbolName;
  final double ltp;
  final double change;
  final double perChange;
  final int tokenValue;

  IndexListItem({
    required this.symbolName,
    required this.ltp,
    required this.change,
    required this.perChange,
    required this.tokenValue,
  });

  static List<IndexListItem> indexDatas = [
    IndexListItem(
        symbolName: 'NIFTY 50',
        ltp: 2408,
        change: 36.00,
        perChange: 23.52,
        tokenValue: 3434),
    IndexListItem(
        symbolName: 'NIFTY 100',
        ltp: 543.50,
        change: 36.00,
        perChange: 75.52,
        tokenValue: 654),
    IndexListItem(
        symbolName: 'BANK NIFTY',
        ltp: 323.5,
        change: 36.00,
        perChange: 11.52,
        tokenValue: 231),
    IndexListItem(
        symbolName: 'SENSEX',
        ltp: 898,
        change: 36.00,
        perChange: 1.52,
        tokenValue: 9089),
    IndexListItem(
        symbolName: 'INDIA VIX',
        ltp: 656,
        change: 36.00,
        perChange: 43.52,
        tokenValue: 654),
    IndexListItem(
        symbolName: 'NIFTY 50',
        ltp: 2408,
        change: 36.00,
        perChange: 23.52,
        tokenValue: 3434),
    IndexListItem(
        symbolName: 'NIFTY 100',
        ltp: 543.50,
        change: 36.00,
        perChange: 75.52,
        tokenValue: 654),
    IndexListItem(
        symbolName: 'BANK NIFTY',
        ltp: 323.5,
        change: 36.00,
        perChange: 11.52,
        tokenValue: 231),
    IndexListItem(
        symbolName: 'SENSEX',
        ltp: 898,
        change: 36.00,
        perChange: 1.52,
        tokenValue: 9089),
    IndexListItem(
        symbolName: 'INDIA VIX',
        ltp: 656,
        change: 36.00,
        perChange: 43.52,
        tokenValue: 654),
    IndexListItem(
        symbolName: 'NIFTY 50',
        ltp: 2408,
        change: 36.00,
        perChange: 23.52,
        tokenValue: 3434),
    IndexListItem(
        symbolName: 'NIFTY 100',
        ltp: 543.50,
        change: 36.00,
        perChange: 75.52,
        tokenValue: 654),
    IndexListItem(
        symbolName: 'BANK NIFTY',
        ltp: 323.5,
        change: 36.00,
        perChange: 11.52,
        tokenValue: 231),
    IndexListItem(
        symbolName: 'SENSEX',
        ltp: 898,
        change: 36.00,
        perChange: 1.52,
        tokenValue: 9089),
    IndexListItem(
        symbolName: 'INDIA VIX',
        ltp: 656,
        change: 36.00,
        perChange: 43.52,
        tokenValue: 654),
  ];
}
