enum AuthViews { password, twoFA, mpin }

enum SecurityViews { password, twoFA, mpin }

enum StockType { nse, bse }

enum OrderSwipeType { buy, sell, add, exit }

enum OrderWindowTabRadio { regular, bracket, cover, amo }

enum OrderWindowTextFieldTypes { quantity, price, triggerPrice, disclosedQuantity, slTriggerPrice, stoploss, target, trailingStoploss }

enum OrderType { market, limit, sl, slm }

Map<OrderSwipeType, String> orderSwipeTypeToStringMap = {
  OrderSwipeType.buy: 'Buy',
  OrderSwipeType.sell: 'Sell',
  OrderSwipeType.add: 'Add',
  OrderSwipeType.exit: 'Exit',
};

Map<StockType, String> stockTypeToStringMap = {
  StockType.nse: 'NSE',
  StockType.bse: 'BSE',
};

Map<OrderWindowTabRadio, String> orderWindowTabToStringMap = {
  OrderWindowTabRadio.regular: 'REGULAR',
  OrderWindowTabRadio.bracket: 'BRACKET',
  OrderWindowTabRadio.cover: 'COVER',
  OrderWindowTabRadio.amo: 'AMO',
};

Map<OrderWindowTabRadio, int> orderWindowTabToIntMap = {
  OrderWindowTabRadio.regular: 1,
  OrderWindowTabRadio.bracket: 2,
  OrderWindowTabRadio.cover: 3,
  OrderWindowTabRadio.amo: 4,
};

Map<OrderType, String> orderTypeToStringMap = {
  OrderType.market: 'MARKET',
  OrderType.limit: 'LIMIT',
  OrderType.sl: 'SL',
  OrderType.slm: 'SL-M',
};

Map<OrderType, int> orderTypeToIntMap = {
  OrderType.market: 1,
  OrderType.limit: 2,
  OrderType.sl: 3,
  OrderType.slm: 4,
};

Map<OrderWindowTextFieldTypes, String> orderWindowTextFieldToStringMap = {
  OrderWindowTextFieldTypes.quantity: 'Quantity',
  OrderWindowTextFieldTypes.price: 'Price',
  OrderWindowTextFieldTypes.triggerPrice: 'Trigger Price',
  OrderWindowTextFieldTypes.disclosedQuantity: 'Disclosed Quantity',
  OrderWindowTextFieldTypes.slTriggerPrice: 'SL Trigger Price',
  OrderWindowTextFieldTypes.stoploss: 'Stoploss',
  OrderWindowTextFieldTypes.target: 'Target',
  OrderWindowTextFieldTypes.trailingStoploss: 'Trailing Stoploss',
};