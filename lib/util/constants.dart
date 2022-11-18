const kPlaceholderImageUrl =
    'https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg';

const kIpoLinkUrl = 'https://ipo.zebull.in/';
const kFeedBackUrl = 'https://form.jotform.com/211671660733454';
const kChartUrl = 'https://v2.zebull.in/charts';
const kBnrWebsiteUrl = 'https://www.bnrsecurities.com/';
const kPayInUrl =
    'https://input.zebuetrade.com/PaymentGateway/Main/Hold_Funds.jsp';
const kPayoutUrl = "https://bo.zebull.in/webclient/index.cfm";

const kUpiPaymentUrl = 'https://fund.zebull.in/';

const kCdslUrl = "https://zkyc.zebull.in/edis";

// const kIpoLinkUrl = 'https://flutter.dev/';

//order window validation Messages
const String nullValue = "Value cannot not be empty";
const String qtyZero = "Quantity should not be Zero";
const String priceZero = "Price should not be Zero";
const String qtyNull = "Quantity cannot not be empty";
const String disQtywithQty = "Should be less than qty";
const String qtyErrMsg = "Quantity should be multiple of lots";
const String discqtyErrMsg = "Quantity should be multiple of lots";
const String qtyExeeds = "Quantity should not exceed freeze quantity";
const String disqtyExeeds = "Disc.Quantity should not exceed freeze quantity";
const String disqtyNull = "Qty should not be empty";
const String disqtyErrMsg =
    "Disc.qty should be either 0 or 10% to 100% of quantity";
const String disQtyMCxErr =
    "Disc.qty Should be either 0 or 25% to 100% of quantity";
const String disQtyLQty = "Dis.Qty Should be less than qty";
const String priceNull = "Price cannot be Empty";
const String targetNull = "Target cannot be Empty";
const String stopLossNull = "StopLoss cannot be Empty";
const String triggerPriceZero = "Trig.Price cannot be Zero";
const String triggerPriceEmptyError = "Trig.Price cannot be Empty";
const String priceError = "Should be multiple of Tick size";
const String priceRangeError = "Should be within the DPR range";
const String priceLltp = "Price should be less than LTP";
const String priceCOLltp = "Price should be less than or equal to LTP";
const String priceHltp = "Price should be greater than LTP";
const String priceCOHltp = "Price should be greater than or equal to LTP";
const String trigPriceRange =
    "Trig.price should be less than or equal to Price.";
const String trigHltp =
    "Trigger Price should be greater than or equal to Price and less than LTP";
const String trigPrcLtp =
    "Trigger Price should be less than or equal to Price and greater than LTP";
const String trigPrcCOLtp = "Trigger Price should be less than Price and LTP";
const String trigHLtp = "Trigger Price should be greater than LTP";
const String trigCOHLtp = "Trigger Price should be greater than Price and LTP";
const String trigLLtp = "Trigger Price should be less than LTP";
const String trigPercentage = "Trigger Price should be 3% of the price";
const String odrErr = "Couldn't place order";
const String targetZero = "Target should be greater than 0.";
const String stplossZero = "Stoploss should be greater than 0. ";
const String trigLess = "Trigger Price can't be lesser than Price.";
const String priceLessLtp = "Price cannot be less than ltp";
