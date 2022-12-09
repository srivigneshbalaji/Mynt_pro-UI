import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mynt_pro/constant/constants.dart';
import 'package:provider/provider.dart';
import '../../../../api/api_links.dart';
import '../../../../constant/const_var.dart';
import '../../../../functions/script_info_fun.dart';
import '../../../../model/script_info_model.dart';
import '../../../../themes/theme_model.dart';

class BuyOrder extends StatefulWidget {
  String exch;
  String scriptName;
  String tok;
  BuyOrder(
      {super.key,
      required this.exch,
      required this.scriptName,
      required this.tok});

  @override
  State<BuyOrder> createState() => _BuyOrderState(exch, scriptName, tok);
}

class _BuyOrderState extends State<BuyOrder> {
  @override
  void initState() {
    scriptInfo(exch, tok);
    super.initState();
  }

  String segment = "";
  bool isChecked = false;
  final diskQty = TextEditingController();
  final qTy = TextEditingController();
  final price = TextEditingController();
  final stopLoss = TextEditingController();
  final target = TextEditingController();
  final trailingStoploss = TextEditingController();
  final mktProt = TextEditingController();
  final trigger = TextEditingController();
  final triggerPrice = TextEditingController();
  List<bool> eqtProductBtn = [true, false, false, false, false];
  List<bool> futProductBtn = [true, false, false, false];
  List<bool> priceTypeBtn = [true, false, false, false];
  List<bool> validityBtn = [true, false];
  List<String> eqtProduct = ["CNC", "MIS", "MTF", "CO", "BO"];
  List<String> futProduct = ["NRML", "MIS", "CO", "BO"];
  List<String> priceType = ["LIMIT", "MARKET", "SL", "SLM"];
  List<String> validity = ["Day", "IOC"];
  String exch;
  String scriptName;
  String tok;
  _BuyOrderState(this.exch, this.scriptName, this.tok);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 1,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitleText(scriptName, size),
                Text(
                  exch,
                  style: listSubTitle(size),
                )
              ],
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        buildTitleText("Product", size),
                        sizedHeight(size * .1),
                        SizedBox(
                          height: 30,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: segment == "EQT"
                                  ? eqtProductBtns(size)
                                  : futProductBtns(size)),
                        ),
                        sizedHeight(size * .3),
                        const Divider(),
                        sizedHeight(size * .1),
                        buildTitleText("Price Type", size),
                        sizedHeight(size * .1),
                        SizedBox(
                          height: 30,
                          child: Row(
                            children: priceTypeBtns(size),
                          ),
                        ),
                        sizedHeight(size * .3),
                        const Divider(),
                        sizedHeight(size * .1),
                        segment == "EQT"
                            ? Column(
                                children: [
                                  // CNC || MIS || MTF && LIMIT
                                  Visibility(
                                    visible:
                                        eqtProductBtn[0] && priceTypeBtn[0],
                                    child: cncLimit(size),
                                  ),
                                  Visibility(
                                    visible:
                                        eqtProductBtn[1] && priceTypeBtn[0],
                                    child: cncLimit(size),
                                  ),
                                  Visibility(
                                    visible:
                                        eqtProductBtn[2] && priceTypeBtn[0],
                                    child: cncLimit(size),
                                  ),
                                  Visibility(
                                    visible:
                                        eqtProductBtn[0] && priceTypeBtn[1],
                                    child: cncMarket(size),
                                  ),
                                  Visibility(
                                    visible:
                                        eqtProductBtn[1] && priceTypeBtn[1],
                                    child: cncMarket(size),
                                  ),
                                  Visibility(
                                    visible:
                                        eqtProductBtn[2] && priceTypeBtn[1],
                                    child: cncMarket(size),
                                  ),
                                  Visibility(
                                    visible:
                                        eqtProductBtn[0] && priceTypeBtn[2],
                                    child: cncSl(size),
                                  ),
                                  Visibility(
                                    visible:
                                        eqtProductBtn[1] && priceTypeBtn[2],
                                    child: cncSl(size),
                                  ),
                                  Visibility(
                                    visible:
                                        eqtProductBtn[2] && priceTypeBtn[2],
                                    child: cncSl(size),
                                  ),
                                  Visibility(
                                    visible:
                                        eqtProductBtn[0] && priceTypeBtn[3],
                                    child: cncSlm(size),
                                  ),
                                  Visibility(
                                    visible:
                                        eqtProductBtn[1] && priceTypeBtn[3],
                                    child: cncSlm(size),
                                  ),
                                  Visibility(
                                    visible:
                                        eqtProductBtn[2] && priceTypeBtn[3],
                                    child: cncSlm(size),
                                  ),

                                  // CO && LIMIT
                                  Visibility(
                                      visible:
                                          eqtProductBtn[3] && priceTypeBtn[0],
                                      child: coLimit(size)),

                                  // CO && MARKET
                                  Visibility(
                                      visible:
                                          eqtProductBtn[3] && priceTypeBtn[1],
                                      child: coMarket(size)),

                                  // CO && SL
                                  Visibility(
                                      visible:
                                          eqtProductBtn[3] && priceTypeBtn[2],
                                      child: coSl(size)),

                                  // BO && LIMIT
                                  Visibility(
                                      visible:
                                          eqtProductBtn[4] && priceTypeBtn[0],
                                      child: boLimit(size)),

                                  // BO && MARKET
                                  Visibility(
                                      visible:
                                          eqtProductBtn[4] && priceTypeBtn[1],
                                      child: boMarket(size)),

                                  //BO && SL
                                  Visibility(
                                      visible:
                                          eqtProductBtn[4] && priceTypeBtn[2],
                                      child: boSl(size)),
                                ],
                              )
                            : Column(
                                children: [
                                  // CNC || MIS || MTF && LIMIT
                                  Visibility(
                                    visible:
                                        futProductBtn[0] && priceTypeBtn[0],
                                    child: cncLimit(size),
                                  ),
                                  Visibility(
                                    visible:
                                        futProductBtn[1] && priceTypeBtn[0],
                                    child: cncLimit(size),
                                  ),

                                  Visibility(
                                    visible:
                                        futProductBtn[0] && priceTypeBtn[1],
                                    child: cncMarket(size),
                                  ),
                                  Visibility(
                                    visible:
                                        futProductBtn[1] && priceTypeBtn[1],
                                    child: cncMarket(size),
                                  ),

                                  Visibility(
                                    visible:
                                        futProductBtn[0] && priceTypeBtn[2],
                                    child: cncSl(size),
                                  ),
                                  Visibility(
                                    visible:
                                        futProductBtn[1] && priceTypeBtn[2],
                                    child: cncSl(size),
                                  ),

                                  Visibility(
                                    visible:
                                        futProductBtn[0] && priceTypeBtn[3],
                                    child: cncSlm(size),
                                  ),
                                  Visibility(
                                    visible:
                                        futProductBtn[1] && priceTypeBtn[3],
                                    child: cncSlm(size),
                                  ),

                                  // CO && LIMIT
                                  Visibility(
                                      visible:
                                          futProductBtn[2] && priceTypeBtn[0],
                                      child: coLimit(size)),

                                  // CO && MARKET
                                  Visibility(
                                      visible:
                                          futProductBtn[2] && priceTypeBtn[1],
                                      child: coMarket(size)),

                                  // CO && SL
                                  Visibility(
                                      visible:
                                          futProductBtn[2] && priceTypeBtn[2],
                                      child: coSl(size)),

                                  // BO && LIMIT
                                  Visibility(
                                      visible:
                                          futProductBtn[3] && priceTypeBtn[0],
                                      child: boLimit(size)),

                                  // BO && MARKET
                                  Visibility(
                                      visible:
                                          futProductBtn[3] && priceTypeBtn[1],
                                      child: boMarket(size)),

                                  //BO && SL
                                  Visibility(
                                      visible:
                                          futProductBtn[3] && priceTypeBtn[2],
                                      child: boSl(size)),
                                ],
                              ),
                        sizedHeight(size * .3),
                        const Divider(),
                        sizedHeight(size * .1),
                        Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            buildContentText("Quantity", size),
                                            buildContentText("Lot:1", size)
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        SizedBox(
                                            height: 42,
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: qTy,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder()),
                                            )),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        buildContentText(
                                            "Freeze Qty:0987", size)
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 42,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            buildContentText("Price", size),
                                            buildContentText("Tick:1", size)
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        priceTypeBtn[1] || priceTypeBtn[3]
                                            ? Container(
                                                height: 42,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                4))),
                                                child: const Center(
                                                    child: Text("0.0")),
                                              )
                                            : SizedBox(
                                                height: 42,
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: price,
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          color: Colors.lightGreen[50],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Cash: \$0.00",
                                    style: logText(size, Colors.brown)),
                                Text("Margin: \$200.00",
                                    style: logText(size, Colors.brown))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: () {},
                          icon: const Icon(Icons.point_of_sale_outlined),
                          label: Text(
                            "BUY",
                            style: listTitle(size),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

// TEXT

  Widget buildTitleText(String text, Size size) =>
      Text(text, style: listTitle(size));
  Widget buildContentText(String text, Size size) =>
      Text(text, style: orderContentText(size));

// LIST OF BUTTON DATA'S

  Column boSl(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContentText("Stoploss", size),
                sizedHeight(size * .1),
                stopLossTextField(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContentText("Target", size),
                sizedHeight(size * .1),
                targetTextField()
              ],
            )
          ],
        ),
        sizedHeight(size * .1),
        buildContentText("Trailing Stoploss", size),
        sizedHeight(size * .1),
        trailingStopLossTextField(),
        sizedHeight(size * .3),
        const Divider(),
        sizedHeight(size * .1),
        buildContentText("1st Leg Trigger Price", size),
        sizedHeight(size * .1),
        triggerPriceTextField(),
      ],
    );
  }

  Column boMarket(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContentText("Stoploss", size),
                sizedHeight(size * .1),
                stopLossTextField(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContentText("Target", size),
                sizedHeight(size * .1),
                targetTextField()
              ],
            )
          ],
        ),
        sizedHeight(size * .1),
        buildContentText("Trailing Stoploss", size),
        sizedHeight(size * .1),
        trailingStopLossTextField(),
        sizedHeight(size * .3),
        const Divider(),
        sizedHeight(size * .1),
        buildContentText("MKT Prot (%)", size),
        sizedHeight(size * .1),
        mktProtTextField(),
      ],
    );
  }

  Column boLimit(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContentText("Stoploss", size),
                sizedHeight(size * .1),
                stopLossTextField(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContentText("Target", size),
                sizedHeight(size * .1),
                targetTextField(),
              ],
            )
          ],
        ),
        sizedHeight(size * .1),
        buildContentText("Trailing Stoploss", size),
        sizedHeight(size * .1),
        trailingStopLossTextField()
      ],
    );
  }

  Column coSl(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildContentText("Stoploss", size),
        sizedHeight(size * .1),
        stopLossTextField(),
        sizedHeight(size * .3),
        const Divider(),
        sizedHeight(size * .1),
        buildContentText("1st Leg Trigger Price", size),
        sizedHeight(size * .1),
        triggerPriceTextField(),
      ],
    );
  }

  Column coMarket(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildContentText("Stoploss", size),
        sizedHeight(size * .1),
        stopLossTextField(),
        sizedHeight(size * .3),
        const Divider(),
        sizedHeight(size * .1),
        buildContentText("MKT Prot (%)", size),
        sizedHeight(size * .1),
        mktProtTextField(),
      ],
    );
  }

  Column coLimit(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildContentText("Stoploss", size),
        sizedHeight(size * .1),
        stopLossTextField(),
      ],
    );
  }

  Column cncLimit(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitleText("Validity", size),
        sizedHeight(size * .1),
        SizedBox(
          height: 30,
          child: Row(
            children: validityBtns(size),
          ),
        ),
        sizedHeight(size * .3),
        const Divider(),
        sizedHeight(size * .1),
        buildContentText("Disc Qty", size),
        sizedHeight(size * .1),
        discQtyTextField(size),
      ],
    );
  }

  Column cncMarket(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildContentText("MKT Prot (%)", size),
        sizedHeight(size * .2),
        mktProtTextField(),
        sizedHeight(size * .3),
        const Divider(),
        sizedHeight(size * .1),
        buildTitleText("Validity", size),
        sizedHeight(size * .1),
        SizedBox(
          height: 30,
          child: Row(
            children: validityBtns(size),
          ),
        ),
        sizedHeight(size * .3),
        const Divider(),
        sizedHeight(size * .1),
        buildContentText("Disc Qty", size),
        sizedHeight(size * .1),
        discQtyTextField(size),
      ],
    );
  }

  Column cncSl(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildContentText("Trigger", size),
        sizedHeight(size * .1),
        triggerTextField(),
        buildTitleText("Validity", size),
        sizedHeight(size * .1),
        SizedBox(
          height: 30,
          child: Row(
            children: validityBtns(size),
          ),
        ),
        sizedHeight(size * .3),
        const Divider(),
        sizedHeight(size * .1),
        buildContentText("Disc Qty", size),
        sizedHeight(size * .1),
        discQtyTextField(size),
      ],
    );
  }

  Column cncSlm(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContentText("MKT Prot (%)", size),
                sizedHeight(size * .1),
                mktProtTextField(),
              ],
            ),
            Column(
              children: [
                buildContentText("Trigger", size),
                sizedHeight(size * .1),
                triggerTextField()
              ],
            )
          ],
        ),
        buildTitleText("Validity", size),
        sizedHeight(size * .1),
        SizedBox(
          height: 30,
          child: Row(
            children: validityBtns(size),
          ),
        ),
        sizedHeight(size * .3),
        const Divider(),
        sizedHeight(size * .1),
        buildContentText("Disc Qty", size),
        sizedHeight(size * .1),
        discQtyTextField(size),
      ],
    );
  }

// TEXT FIELD'S

  SizedBox targetTextField() {
    return SizedBox(
        width: 150,
        height: 42,
        child: TextField(
          controller: target,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ));
  }

  SizedBox trailingStopLossTextField() {
    return SizedBox(
        width: 150,
        height: 42,
        child: TextField(
          keyboardType: TextInputType.number,
          controller: trailingStoploss,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ));
  }

  SizedBox triggerPriceTextField() {
    return SizedBox(
        width: 150,
        height: 42,
        child: TextField(
          keyboardType: TextInputType.number,
          controller: triggerPrice,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ));
  }

  SizedBox mktProtTextField() {
    return SizedBox(
        width: 150,
        height: 42,
        child: TextField(
          keyboardType: TextInputType.number,
          controller: mktProt,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ));
  }

  SizedBox stopLossTextField() {
    return SizedBox(
        width: 150,
        height: 42,
        child: TextField(
          keyboardType: TextInputType.number,
          controller: stopLoss,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ));
  }

  Row discQtyTextField(Size size) {
    return Row(
      children: [
        SizedBox(
            width: 150,
            height: 42,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: diskQty,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            )),
        const SizedBox(
          width: 20,
        ),
        Checkbox(
            checkColor: Colors.blue,
            activeColor: Colors.black,
            value: isChecked,
            onChanged: (check) {
              setState(() {
                isChecked = check!;
              });
            }),
        buildContentText("AMO", size),
      ],
    );
  }

  SizedBox triggerTextField() {
    return SizedBox(
        width: 150,
        height: 42,
        child: TextField(
          keyboardType: TextInputType.number,
          controller: trigger,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ));
  }

//  LIST OF BUTTONS

  List<Widget> eqtProductBtns(Size size) {
    List<Widget> listButtons = List.generate(eqtProduct.length, (i) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            // foregroundColor: Colors.amberAccent,
            backgroundColor:
                eqtProductBtn[i] ? Colors.blueAccent : Colors.white,
          ),
          onPressed: () {
            setState(() {
              eqtProductBtn[0] = false;
              eqtProductBtn[1] = false;
              eqtProductBtn[2] = false;
              eqtProductBtn[3] = false;
              eqtProductBtn[4] = false;
              eqtProductBtn[i] = true;
              if (eqtProductBtn[3] || eqtProductBtn[4]) {
                priceType.remove("SLM");
                // priceTypeBtn[0] = true;
              } else {
                priceType.remove("SLM");
                priceType.add("SLM");
                // priceTypeBtn[0] = true;
                // priceTypeBtn[1] = false;
                // priceTypeBtn[2] = false;
              }
            });
          },
          child: Text(
            eqtProduct[i],
            style: orderBtnText(size),
          ),
        ),
      );
    });
    return listButtons;
  }

  List<Widget> futProductBtns(Size size) {
    List<Widget> listButtons = List.generate(futProduct.length, (i) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            // foregroundColor: Colors.amberAccent,
            backgroundColor:
                futProductBtn[i] ? Colors.blueAccent : Colors.white,
          ),
          onPressed: () {
            setState(() {
              futProductBtn[0] = false;
              futProductBtn[1] = false;
              futProductBtn[2] = false;
              futProductBtn[3] = false;
              futProductBtn[i] = true;
              if (futProductBtn[2] || futProductBtn[3]) {
                priceType.remove("SLM");
                // priceTypeBtn[0] = true;
              } else {
                priceType.remove("SLM");
                priceType.add("SLM");
                // priceTypeBtn[0] = true;
                // priceTypeBtn[1] = false;
                // priceTypeBtn[2] = false;
              }
            });
          },
          child: Text(
            futProduct[i],
            style: orderBtnText(size),
          ),
        ),
      );
    });
    return listButtons;
  }

  List<Widget> priceTypeBtns(Size size) {
    List<Widget> listButtons = List.generate(priceType.length, (i) {
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            // foregroundColor: Colors.amberAccent,
            backgroundColor: priceTypeBtn[i] ? Colors.blueAccent : Colors.white,
          ),
          onPressed: () {
            setState(() {
              priceTypeBtn[0] = false;
              priceTypeBtn[1] = false;
              priceTypeBtn[2] = false;
              priceTypeBtn[3] = false;
              priceTypeBtn[i] = true;
            });
          },
          child: Text(priceType[i], style: orderBtnText(size)),
        ),
      );
    });
    return listButtons;
  }

  List<Widget> validityBtns(Size size) {
    List<Widget> listButtons = List.generate(validity.length, (i) {
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            // foregroundColor: Colors.amberAccent,
            backgroundColor: validityBtn[i] ? Colors.blueAccent : Colors.white,
          ),
          onPressed: () {
            setState(() {
              validityBtn[0] = false;
              validityBtn[1] = false;
              validityBtn[i] = true;
            });
          },
          child: Text(validity[i], style: orderBtnText(size)),
        ),
      );
    });
    return listButtons;
  }

  Future scriptInfo(exchange, token) async {
    try {
      http.Response response = await http.post(Uri.parse(ApiLinks.secInfo),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}","exch":"$exchange","token":"$token"}&jKey=${ConstVariable.sessionId}''');

      setState(() {
        ScriptInfoModel.scriptInfoRes = json.decode(response.body);
        var stat = ScriptInfoModel.scriptInfoRes['stat'];
        if (stat == "Ok") {
          segment = ScriptInfoModel.scriptInfoRes['seg'];
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(sb.unSuccessBar("Session Expired"));
        }
      });
    } catch (e) {}
  }
}
