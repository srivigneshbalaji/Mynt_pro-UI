import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import '../../../../api/api_links.dart';
import '../../../../constant/const_var.dart';
import '../../../../constant/snackbar.dart';
import '../../../../constant/text_style.dart';
import '../../../../model/order_book_model.dart';
import '../../../../themes/theme_model.dart';

class ExecutedOrder extends StatefulWidget {
  const ExecutedOrder({super.key});

  @override
  State<ExecutedOrder> createState() => _ExecutedOrderState();
}

class _ExecutedOrderState extends State<ExecutedOrder> {
  @override
  void initState() {
    orderBook();
    super.initState();
  }

  final MySnackBars sb = MySnackBars();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: OrderBookModel.executedOrderBook.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    var time = OrderBookModel.executedOrderBook[index]
                            ['norentm']
                        .toString()
                        .split(" ");
                    String orderStatus =
                        OrderBookModel.executedOrderBook[index]['status'];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: themeNotifier.isDark
                                ? Colors.white12
                                : Colors.black12,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        OrderBookModel.executedOrderBook[index]
                                                    ['trantype'] ==
                                                "B"
                                            ? Colors.blue.withOpacity(.1)
                                            : Colors.red.withOpacity(.1)),
                                child: Text(
                                    OrderBookModel.executedOrderBook[index]
                                                ['trantype'] ==
                                            "S"
                                        ? "SELL"
                                        : "BUY",
                                    style: GoogleFonts.lexend(
                                        fontSize: size.height * 0.015,
                                        fontWeight: FontWeight.w500,
                                        color: OrderBookModel.executedOrderBook[
                                                    index]['trantype'] ==
                                                "B"
                                            ? Colors.blue
                                            : Colors.red)),
                              ),
                              Text(
                                  "Qty: ${OrderBookModel.executedOrderBook[index]['qty']}",
                                  style: GoogleFonts.lexend()),
                              Text(time[0], style: GoogleFonts.lexend()),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    backgroundColor: orderStatus == "REJECTED"
                                        ? Colors.red.withOpacity(.1)
                                        : Colors.green.withOpacity(.1)),
                                child: Text(
                                  orderStatus,
                                  style: GoogleFonts.lexend(
                                      fontSize: size.height * 0.015,
                                      fontWeight: FontWeight.w500,
                                      color: orderStatus == "REJECTED"
                                          ? Colors.red
                                          : Colors.green),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${OrderBookModel.executedOrderBook[index]['tsym']}",
                                  style: listTitle(size)),
                              Text(
                                  "${OrderBookModel.executedOrderBook[index]['prc']}",
                                  style: GoogleFonts.lexend()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${OrderBookModel.executedOrderBook[index]['exch']} / ${OrderBookModel.executedOrderBook[index]['prctyp']} /",
                                    style: listSubTitle(size),
                                  ),
                                  if (OrderBookModel.executedOrderBook[index]
                                          ['prd'] ==
                                      "I") ...[
                                    Text(
                                      " MIS",
                                      style: listSubTitle(size),
                                    ),
                                  ] else if (OrderBookModel
                                          .executedOrderBook[index]['prd'] ==
                                      "C") ...[
                                    Text(
                                      " CNC",
                                      style: listSubTitle(size),
                                    ),
                                  ] else if (OrderBookModel
                                          .executedOrderBook[index]['prd'] ==
                                      "M") ...[
                                    Text(
                                      " NRML",
                                      style: listSubTitle(size),
                                    ),
                                  ] else if (OrderBookModel
                                          .executedOrderBook[index]['prd'] ==
                                      "F") ...[
                                    Text(
                                      " MTF",
                                      style: listSubTitle(size),
                                    ),
                                  ] else if (OrderBookModel
                                          .executedOrderBook[index]['prd'] ==
                                      "B") ...[
                                    Text(
                                      " BO",
                                      style: listSubTitle(size),
                                    ),
                                  ] else if (OrderBookModel
                                          .executedOrderBook[index]['prd'] ==
                                      "H") ...[
                                    Text(
                                      " CO",
                                      style: listSubTitle(size),
                                    ),
                                  ]
                                ],
                              ),
                              Text(
                                  "LTP ${OrderBookModel.executedOrderBook[index]['exch']}",
                                  style: listSubTitle(size)),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: OrderBookModel.executedOrderBook.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                )
              : Center(
                  child: Text(
                  "NO DATA",
                  style: noDataTextStyle(size),
                )));
    });
  }

  Future orderBook() async {
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.orderBook),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}"}&jKey=${ConstVariable.sessionId}''');

      var mapRes = json.decode(response.body);
      List newMapRes = mapRes;
      String stat = newMapRes[0]['stat'];
      if (stat == "Ok") {
        setState(() {
          OrderBookModel.orderBook = json.decode(response.body);
          OrderBookModel.executedOrderBook = [];
          OrderBookModel.pendingOrderBook = [];
          for (var i = 0; i < OrderBookModel.orderBook.length; i++) {
            if (OrderBookModel.orderBook[i]['status'] == "REJECTED" ||
                OrderBookModel.orderBook[i]['status'] == "CANCELED" ||
                OrderBookModel.orderBook[i]['status'] == "COMPLETE" ||
                OrderBookModel.orderBook[i]['status'] ==
                    "INVALID_STATUS_TYPE") {
              OrderBookModel.executedOrderBook.add(OrderBookModel.orderBook[i]);
            } else {
              OrderBookModel.pendingOrderBook.add(OrderBookModel.orderBook[i]);
            }
          }
        });
      } else {
        var errorMsg = mapRes['emsg'];

        if (errorMsg == "Invalid Input : Password Expired") {
          Navigator.pushNamed(context, "changePassword");
          ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(errorMsg));
        }
      }
    } catch (e) {}
  }
}
