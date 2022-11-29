import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import '../../../../api/api_links.dart';
import '../../../../constant/const_var.dart';
import '../../../../constant/text_style.dart';
import '../../../../themes/theme_model.dart';

class ExecutedOrder extends StatefulWidget {
  const ExecutedOrder({super.key});

  @override
  State<ExecutedOrder> createState() => _ExecutedOrderState();
}

class _ExecutedOrderState extends State<ExecutedOrder> {
  @override
  void initState() {
    executedOrderBook();
    super.initState();
  }

  Map orderBookData = {};
  List executedOrderBooks = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              if (executedOrderBooks[index]['status'] == "REJECTED" ||
                  executedOrderBooks[index]['status'] == "CANCELED" ||
                  executedOrderBooks[index]['status'] == "COMPLETE" ||
                  executedOrderBooks[index]['status'] ==
                      "INVALID_STATUS_TYPE") {
                var time =
                    executedOrderBooks[index]['norentm'].toString().split(" ");
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
                                    executedOrderBooks[index]['trantype'] == "B"
                                        ? Colors.blue.withOpacity(.1)
                                        : Colors.red.withOpacity(.1)),
                            child: Text(
                                executedOrderBooks[index]['trantype'] == "S"
                                    ? "SELL"
                                    : "BUY",
                                style: GoogleFonts.lexend(
                                    fontSize: size.height * 0.015,
                                    fontWeight: FontWeight.w500,
                                    color: executedOrderBooks[index]
                                                ['trantype'] ==
                                            "S"
                                        ? Colors.red
                                        : Colors.blue)),
                          ),
                          Text(
                              "Qty: ${executedOrderBooks[index]['dscqty']} / ${executedOrderBooks[index]['qty']}",
                              style: GoogleFonts.lexend()),
                          Text(time[0], style: GoogleFonts.lexend()),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.green.withOpacity(.1)),
                            child: Text(
                              "${executedOrderBooks[index]['status']}",
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
                          Text("${executedOrderBooks[index]['tsym']}",
                              style: listTitle(size)),
                          Text("${executedOrderBooks[index]['prc']}",
                              style: GoogleFonts.lexend()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${executedOrderBooks[index]['exch']} ${executedOrderBooks[index]['prctyp']}",
                            style: listSubTitle(size),
                          ),
                          Text("LTP ${executedOrderBooks[index]['exch']}",
                              style: listSubTitle(size)),
                        ],
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
            itemCount: executedOrderBooks.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ));
    });
  }

  Future executedOrderBook() async {
    http.Response response = await http.post(Uri.parse(ApiLinks.orderBook),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body:
            '''jData={"uid":"${ConstVariable.userId}"}&jKey=${ConstVariable.sessionId}''');
    setState(() {
      executedOrderBooks = json.decode(response.body);
    });
  }
}
