import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import '../../../../constant/text_style.dart';
import '../../../../model/order_book_model.dart';
import '../../../../themes/theme_model.dart';

class ExecutedOrder extends StatelessWidget {
  const ExecutedOrder({super.key});

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
                                                "S"
                                            ? Colors.red
                                            : Colors.blue)),
                              ),
                              Text(
                                  "Qty: ${OrderBookModel.executedOrderBook[index]['dscqty']} / ${OrderBookModel.executedOrderBook[index]['qty']}",
                                  style: GoogleFonts.lexend()),
                              Text(time[0], style: GoogleFonts.lexend()),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Colors.green.withOpacity(.1)),
                                child: Text(
                                  "${OrderBookModel.executedOrderBook[index]['status']}",
                                  style: GoogleFonts.lexend(
                                      fontSize: size.height * 0.015,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green),
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
                              Text(
                                "${OrderBookModel.executedOrderBook[index]['exch']} ${OrderBookModel.executedOrderBook[index]['prctyp']}",
                                style: listSubTitle(size),
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
}
