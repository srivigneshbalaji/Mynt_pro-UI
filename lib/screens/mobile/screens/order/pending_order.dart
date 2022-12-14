import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../constant/text_style.dart';
import '../../../../model/order_book_model.dart';
import '../../../../themes/theme_model.dart';

class PendingOrder extends StatelessWidget {
  const PendingOrder({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: OrderBookModel.pendingOrderBook.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    var time = OrderBookModel.pendingOrderBook[index]['norentm']
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
                                        OrderBookModel.pendingOrderBook[index]
                                                    ['trantype'] ==
                                                "B"
                                            ? Colors.blue.withOpacity(.1)
                                            : Colors.red.withOpacity(.1)),
                                child: Text(
                                    OrderBookModel.pendingOrderBook[index]
                                                ['trantype'] ==
                                            "S"
                                        ? "SELL"
                                        : "BUY",
                                    style: GoogleFonts.lexend(
                                        fontSize: size.height * 0.015,
                                        fontWeight: FontWeight.w500,
                                        color: OrderBookModel
                                                        .pendingOrderBook[index]
                                                    ['trantype'] ==
                                                "S"
                                            ? Colors.red
                                            : Colors.blue)),
                              ),
                              Text(
                                  "Qty: ${OrderBookModel.pendingOrderBook[index]['dscqty']} / ${OrderBookModel.pendingOrderBook[index]['qty']}",
                                  style: GoogleFonts.lexend()),
                              Text(time[0], style: GoogleFonts.lexend()),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Colors.green.withOpacity(.1)),
                                child: Text(
                                  "${OrderBookModel.pendingOrderBook[index]['status']}",
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
                                  "${OrderBookModel.pendingOrderBook[index]['tsym']}",
                                  style: listTitle(size)),
                              Text(
                                  "${OrderBookModel.pendingOrderBook[index]['prc']}",
                                  style: GoogleFonts.lexend()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${OrderBookModel.pendingOrderBook[index]['exch']} ${OrderBookModel.pendingOrderBook[index]['prctyp']}",
                                style: listSubTitle(size),
                              ),
                              Text(
                                  "LTP ${OrderBookModel.pendingOrderBook[index]['exch']}",
                                  style: listSubTitle(size)),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: OrderBookModel.pendingOrderBook.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
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
