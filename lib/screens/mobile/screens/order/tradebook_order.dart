import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../constant/text_style.dart';
import '../../../../themes/theme_model.dart';

class TradeBookOrder extends StatelessWidget {
  const TradeBookOrder({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        themeNotifier.isDark ? Colors.white12 : Colors.black12,
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
                            backgroundColor: Colors.blue.withOpacity(.1)),
                        child: Text("BUY",
                            style: GoogleFonts.lexend(
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue)),
                      ),
                      Text("25 / 25", style: GoogleFonts.lexend()),
                      Text("12:34:4", style: GoogleFonts.lexend()),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green.withOpacity(.1)),
                        child: Text(
                          "COMPLETE",
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
                      Text("BANK NIFTY", style: listTitle(size)),
                      Text("00.89", style: GoogleFonts.lexend()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "NFO",
                        style: listSubTitle(size),
                      ),
                      Text("MIS   MKT", style: listSubTitle(size)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        themeNotifier.isDark ? Colors.white12 : Colors.black12,
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
                            backgroundColor: Colors.red.withOpacity(.1)),
                        child: Text("SELL",
                            style: GoogleFonts.lexend(
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.w500,
                                color: Colors.red)),
                      ),
                      Text("25 / 25", style: GoogleFonts.lexend()),
                      Text("12:34:4", style: GoogleFonts.lexend()),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red.withOpacity(.1)),
                        child: Text(
                          "REJECTED",
                          style: GoogleFonts.lexend(
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("TATASTEEL", style: listTitle(size)),
                      Text("67.99", style: GoogleFonts.lexend()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("NSE", style: listSubTitle(size)),
                      Text("MIS   MKT", style: listSubTitle(size)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        themeNotifier.isDark ? Colors.white12 : Colors.black12,
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
                            backgroundColor: Colors.blue.withOpacity(.1)),
                        child: Text("BUY",
                            style: GoogleFonts.lexend(
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue)),
                      ),
                      Text("1 / 1", style: GoogleFonts.lexend()),
                      Text("13:65:4", style: GoogleFonts.lexend()),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green.withOpacity(.1)),
                        child: Text(
                          "COMPLETE",
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
                      Text("NIFTY 100", style: listTitle(size)),
                      Text("00.89", style: GoogleFonts.lexend()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("NFO", style: listSubTitle(size)),
                      Text("MIS   MKT", style: listSubTitle(size)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        themeNotifier.isDark ? Colors.white12 : Colors.black12,
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
                            backgroundColor: Colors.blue.withOpacity(.1)),
                        child: Text("BUY",
                            style: GoogleFonts.lexend(
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue)),
                      ),
                      Text("25 / 25", style: GoogleFonts.lexend()),
                      Text("12:34:4", style: GoogleFonts.lexend()),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red.withOpacity(.1)),
                        child: Text(
                          "REJECTED",
                          style: GoogleFonts.lexend(
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("BANK NIFTY", style: listTitle(size)),
                      Text("00.89", style: GoogleFonts.lexend()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("NFO", style: listSubTitle(size)),
                      Text("MIS   MKT", style: listSubTitle(size)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        themeNotifier.isDark ? Colors.white12 : Colors.black12,
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
                            backgroundColor: Colors.red.withOpacity(.1)),
                        child: Text("SELL",
                            style: GoogleFonts.lexend(
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.w500,
                                color: Colors.red)),
                      ),
                      Text("25 / 25", style: GoogleFonts.lexend()),
                      Text("12:34:4", style: GoogleFonts.lexend()),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green.withOpacity(.1)),
                        child: Text(
                          "COMPLETE",
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
                      Text("BANK NIFTY", style: listTitle(size)),
                      Text("00.89", style: GoogleFonts.lexend()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("NFO", style: listSubTitle(size)),
                      Text("MIS   MKT", style: listSubTitle(size)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        themeNotifier.isDark ? Colors.white12 : Colors.black12,
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
                            backgroundColor: Colors.red.withOpacity(.1)),
                        child: Text("SELL",
                            style: GoogleFonts.lexend(
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.w500,
                                color: Colors.red)),
                      ),
                      Text("25 / 25", style: GoogleFonts.lexend()),
                      Text("12:34:4", style: GoogleFonts.lexend()),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.red.withOpacity(.1)),
                        child: Text(
                          "REJECTED",
                          style: GoogleFonts.lexend(
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("TATASTEEL", style: listTitle(size)),
                      Text("67.99", style: GoogleFonts.lexend()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("NSE", style: listSubTitle(size)),
                      Text("MIS   MKT", style: listSubTitle(size)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        themeNotifier.isDark ? Colors.white12 : Colors.black12,
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
                            backgroundColor: Colors.blue.withOpacity(.1)),
                        child: Text("BUY",
                            style: GoogleFonts.lexend(
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue)),
                      ),
                      Text("1 / 1", style: GoogleFonts.lexend()),
                      Text("13:65:4", style: GoogleFonts.lexend()),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green.withOpacity(.1)),
                        child: Text(
                          "COMPLETE",
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
                      Text("NIFTY 50", style: listTitle(size)),
                      Text("00.89", style: GoogleFonts.lexend()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("NFO", style: listSubTitle(size)),
                      Text("MIS   MKT", style: listSubTitle(size)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        themeNotifier.isDark ? Colors.white12 : Colors.black12,
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
                            backgroundColor: Colors.red.withOpacity(.1)),
                        child: Text("SELL",
                            style: GoogleFonts.lexend(
                                fontSize: size.height * 0.015,
                                fontWeight: FontWeight.w500,
                                color: Colors.red)),
                      ),
                      Text("12 / 25", style: GoogleFonts.lexend()),
                      Text("12:34:4", style: GoogleFonts.lexend()),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.green.withOpacity(.1)),
                        child: Text(
                          "COMPLETE",
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
                        "WIPRO",
                        style: listTitle(size),
                      ),
                      Text("00.89", style: GoogleFonts.lexend()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("NSE", style: listSubTitle(size)),
                      Text("MIS   MKT", style: listSubTitle(size)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
