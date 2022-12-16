import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mynt_pro/constant/constants.dart';
import 'package:provider/provider.dart';
import '../../../../api/api_links.dart';
import '../../../../constant/snackbar.dart';
import '../../../../model/models.dart';
import '../../../../themes/theme_model.dart';

class SellOrder extends StatefulWidget {
  String exch;
  String scriptName;
  String tok;
  double lastPrice;
  SellOrder(
      {super.key,
      required this.exch,
      required this.scriptName,
      required this.tok,
      required this.lastPrice});

  @override
  State<SellOrder> createState() =>
      _SellOrderState(exch, scriptName, tok, lastPrice);
}

class _SellOrderState extends State<SellOrder> {
  final MySnackBars sb = MySnackBars();
  bool isChecked = false;

  bool activeTxtField = false;
  List<bool> eqtProductBtn = [true, false, false, false, false];
  List<bool> futProductBtn = [true, false, false, false];
  List<bool> priceTypeBtn = [true, false, false, false];
  List<bool> validityBtn = [true, false];
  List<String> eqtProduct = ["CNC", "MIS", "MTF", "CO", "BO"];
  List<String> futProduct = ["NRML", "MIS", "CO", "BO"];
  List<String> priceType = ["LIMIT", "MARKET", "SL", "SLM"];
  List<String> validity =
      ScriptInfoModel.exchange == "MCX" ? ["Day", "GTT"] : ["Day", "IOC"];
  String exch;
  String scriptName;
  String tok;
  double lastPrice;
  double changePrice = 0.00;
  double diskQty = 0.00;
  int quantity = 0;
  double target = 0.00;
  double trigger = 0.00;
  double trailingStoploss = 0.00;
  double triggerPrice = 0.00;
  int mktProt = 0;
  double stopLoss = 0.00;
  String validityType = "DAY";
  String amo = "No";
  _SellOrderState(this.exch, this.scriptName, this.tok, this.lastPrice);
  String product = ScriptInfoModel.segment == "EQT"
      ? "${UserDetailModel.product[5]['prd']}"
      : "${UserDetailModel.product[3]['prd']}";
  String priceTyp = UserDetailModel.priceType[0];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$lastPrice",
                style: listTitle(size),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                            children: ScriptInfoModel.segment == "EQT"
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
                      ScriptInfoModel.segment == "EQT"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // CNC || MIS || MTF && LIMIT
                                Visibility(
                                  visible: eqtProductBtn[0] && priceTypeBtn[0],
                                  child: cncLimit(size),
                                ),
                                Visibility(
                                  visible: eqtProductBtn[1] && priceTypeBtn[0],
                                  child: cncLimit(size),
                                ),
                                Visibility(
                                  visible: eqtProductBtn[2] && priceTypeBtn[0],
                                  child: cncLimit(size),
                                ),
                                Visibility(
                                  visible: eqtProductBtn[0] && priceTypeBtn[1],
                                  child: cncMarket(size),
                                ),
                                Visibility(
                                  visible: eqtProductBtn[1] && priceTypeBtn[1],
                                  child: cncMarket(size),
                                ),
                                Visibility(
                                  visible: eqtProductBtn[2] && priceTypeBtn[1],
                                  child: cncMarket(size),
                                ),
                                Visibility(
                                  visible: eqtProductBtn[0] && priceTypeBtn[2],
                                  child: cncSl(size),
                                ),
                                Visibility(
                                  visible: eqtProductBtn[1] && priceTypeBtn[2],
                                  child: cncSl(size),
                                ),
                                Visibility(
                                  visible: eqtProductBtn[2] && priceTypeBtn[2],
                                  child: cncSl(size),
                                ),
                                Visibility(
                                  visible: eqtProductBtn[0] && priceTypeBtn[3],
                                  child: cncSlm(size),
                                ),
                                Visibility(
                                  visible: eqtProductBtn[1] && priceTypeBtn[3],
                                  child: cncSlm(size),
                                ),
                                Visibility(
                                  visible: eqtProductBtn[2] && priceTypeBtn[3],
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // CNC || MIS || MTF && LIMIT
                                Visibility(
                                  visible: futProductBtn[0] && priceTypeBtn[0],
                                  child: cncLimit(size),
                                ),
                                Visibility(
                                  visible: futProductBtn[1] && priceTypeBtn[0],
                                  child: cncLimit(size),
                                ),

                                Visibility(
                                  visible: futProductBtn[0] && priceTypeBtn[1],
                                  child: cncMarket(size),
                                ),
                                Visibility(
                                  visible: futProductBtn[1] && priceTypeBtn[1],
                                  child: cncMarket(size),
                                ),

                                Visibility(
                                  visible: futProductBtn[0] && priceTypeBtn[2],
                                  child: cncSl(size),
                                ),
                                Visibility(
                                  visible: futProductBtn[1] && priceTypeBtn[2],
                                  child: cncSl(size),
                                ),

                                Visibility(
                                  visible: futProductBtn[0] && priceTypeBtn[3],
                                  child: cncSlm(size),
                                ),
                                Visibility(
                                  visible: futProductBtn[1] && priceTypeBtn[3],
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
                                          buildContentText(
                                              "Lot: ${ScriptInfoModel.lotSize}",
                                              size)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      SizedBox(
                                          height: 42,
                                          child: TextFormField(
                                            initialValue:
                                                "${ScriptInfoModel.lotSize}",
                                            onTap: () {
                                              setState(() {
                                                activeTxtField = true;
                                              });
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                quantity = int.parse(value);
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            // controller: qTy,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                          )),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      buildContentText(
                                          "Freeze Qty: ${ScriptInfoModel.frzQty}",
                                          size)
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
                                          buildContentText(
                                              "Tick: ${ScriptInfoModel.tikTik}",
                                              size)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      priceTypeBtn[1] || priceTypeBtn[3]
                                          ? disabledTextField()
                                          : SizedBox(
                                              height: 42,
                                              child: TextFormField(
                                                initialValue:
                                                    lastPrice.toString(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    changePrice =
                                                        double.parse(value);
                                                  });
                                                },
                                                onTap: () {
                                                  setState(() {
                                                    activeTxtField = true;
                                                  });
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                // controller: price,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: activeTxtField,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    // var tick = double.parse(
                                    //     "${ScriptInfoModel.scriptInfoRes['ti']}");
                                    // // price.text = lastPrice +
                                    // //     "${ScriptInfoModel.scriptInfoRes['ti']}";

                                    // ltp = ltp + tick;
                                    // log("$ltp");
                                  });
                                },
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                ))
                          ],
                        )),
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () {
                              log("$product");
                              placeOrder(
                                  exch,
                                  scriptName,
                                  quantity,
                                  changePrice,
                                  product,
                                  priceTyp,
                                  diskQty,
                                  triggerPrice,
                                  stopLoss,
                                  target,
                                  trailingStoploss,
                                  validityType,
                                  amo);
                            },
                            icon: const Icon(
                                Icons.shopping_cart_checkout_outlined),
                            label: Text(
                              "SELL",
                              style: listTitle(size),
                            )),
                      ),
                    ),
                  ],
                )
              ],
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
      mainAxisAlignment: MainAxisAlignment.start,
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
        ScriptInfoModel.segment == "EQT"
            ? discQtyTextField(size)
            : disabledTextField(),
      ],
    );
  }

  Container disabledTextField() {
    return Container(
      height: 42,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      child: const Center(child: Text("0.0")),
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
        ScriptInfoModel.segment == "EQT"
            ? discQtyTextField(size)
            : disabledTextField(),
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
        ScriptInfoModel.segment == "EQT"
            ? discQtyTextField(size)
            : disabledTextField(),
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
        ScriptInfoModel.segment == "EQT"
            ? discQtyTextField(size)
            : disabledTextField(),
      ],
    );
  }

// TEXT FIELD'S

  SizedBox targetTextField() {
    return SizedBox(
        width: 150,
        height: 42,
        child: TextFormField(
          initialValue: "0.00",
          onChanged: (value) {
            setState(() {
              target = double.parse(value);
            });
          },
          onTap: () => inActiveTxtField(),
          // controller: target,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ));
  }

  SizedBox trailingStopLossTextField() {
    return SizedBox(
        width: 150,
        height: 42,
        child: TextFormField(
          initialValue: "0.00",
          onChanged: (value) {
            setState(() {
              trailingStoploss = double.parse(value);
            });
          },
          onTap: () => inActiveTxtField(),
          keyboardType: TextInputType.number,
          // controller: trailingStoploss,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ));
  }

  SizedBox triggerPriceTextField() {
    return SizedBox(
        width: 150,
        height: 42,
        child: TextFormField(
          initialValue: "0.00",
          onChanged: ((value) {
            setState(() {
              triggerPrice = double.parse(value);
            });
          }),
          onTap: () => inActiveTxtField(),
          keyboardType: TextInputType.number,
          // controller: triggerPrice,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ));
  }

  SizedBox mktProtTextField() {
    return SizedBox(
        width: 150,
        height: 42,
        child: TextFormField(
          initialValue: '5',
          onChanged: (value) {
            setState(() {
              mktProt = int.parse(value);
            });
          },
          onTap: () => inActiveTxtField(),
          keyboardType: TextInputType.number,
          // controller: mktProt,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ));
  }

  SizedBox stopLossTextField() {
    return SizedBox(
        width: 150,
        height: 42,
        child: TextFormField(
          onChanged: (value) {
            setState(() {
              stopLoss = double.parse(value);
            });
          },
          initialValue: "0.00",
          onTap: () => inActiveTxtField(),
          keyboardType: TextInputType.number,
          // controller: stopLoss,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ));
  }

  Row discQtyTextField(Size size) {
    return Row(
      children: [
        SizedBox(
            width: 150,
            height: 42,
            child: TextFormField(
              initialValue: "0.00",
              onChanged: ((value) {
                setState(() {
                  diskQty = double.parse(value);
                });
              }),
              onTap: () => inActiveTxtField(),
              keyboardType: TextInputType.number,
              // controller: diskQty,
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
                if (isChecked) {
                  amo = "Yes";
                }
              });
            }),
        buildContentText("AMO", size),
      ],
    );
  }

  void inActiveTxtField() {
    return setState(() {
      activeTxtField = false;
    });
  }

  SizedBox triggerTextField() {
    return SizedBox(
        width: 150,
        height: 42,
        child: TextFormField(
          onChanged: ((value) {
            setState(() {
              trigger = double.parse(value);
            });
          }),
          onTap: () => inActiveTxtField(),
          keyboardType: TextInputType.number,
          // controller: trigger,
          decoration: const InputDecoration(border: OutlineInputBorder()),
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
            backgroundColor: eqtProductBtn[i] ? Colors.redAccent : Colors.white,
          ),
          onPressed: () {
            setState(() {
              eqtProductBtn[0] = false;
              eqtProductBtn[1] = false;
              eqtProductBtn[2] = false;
              eqtProductBtn[3] = false;
              eqtProductBtn[4] = false;
              eqtProductBtn[i] = true;
            });
            if (eqtProductBtn[0] == true) {
              product = UserDetailModel.product[5]['prd'];
              print(product);
            } else if (eqtProductBtn[1] == true) {
              product = UserDetailModel.product[4]['prd'];
              print(product);
            } else if (eqtProductBtn[2] == true) {
              product = UserDetailModel.product[0]['prd'];
              print(product);
            } else if (eqtProductBtn[3] == true) {
              product = UserDetailModel.product[2]['prd'];
              print(product);
            } else if (eqtProductBtn[4] == true) {
              product = UserDetailModel.product[1]['prd'];
              print(product);
            }

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
            backgroundColor: futProductBtn[i] ? Colors.redAccent : Colors.white,
          ),
          onPressed: () {
            setState(() {
              futProductBtn[0] = false;
              futProductBtn[1] = false;
              futProductBtn[2] = false;
              futProductBtn[3] = false;
              futProductBtn[i] = true;
              if (futProductBtn[0]) {
                product = UserDetailModel.product[3]['prd'];
                print(product);
              } else if (futProductBtn[1]) {
                product = UserDetailModel.product[4]['prd'];
                print(product);
              } else if (futProductBtn[2] == true) {
                product = UserDetailModel.product[2]['prd'];
                print(product);
              } else if (futProductBtn[3] == true) {
                product = UserDetailModel.product[1]['prd'];
                print(product);
              }

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
            backgroundColor: priceTypeBtn[i] ? Colors.redAccent : Colors.white,
          ),
          onPressed: () {
            setState(() {
              priceTypeBtn[0] = false;
              priceTypeBtn[1] = false;
              priceTypeBtn[2] = false;
              priceTypeBtn[3] = false;
              priceTypeBtn[i] = true;

              if (priceTypeBtn[0]) {
                priceTyp = UserDetailModel.priceType[0];
                print(priceTyp);
              } else if (priceTypeBtn[1]) {
                priceTyp = UserDetailModel.priceType[1];
                print(priceTyp);
              } else if (priceTypeBtn[2]) {
                priceTyp = UserDetailModel.priceType[2];
                print(priceTyp);
              } else if (priceTypeBtn[3]) {
                priceTyp = UserDetailModel.priceType[3];
                print(priceTyp);
              }
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
            backgroundColor: validityBtn[i] ? Colors.redAccent : Colors.white,
          ),
          onPressed: () {
            setState(() {
              validityBtn[0] = false;
              validityBtn[1] = false;
              validityBtn[i] = true;
              if (validityBtn[0]) {
                validityType = validity[0];
                print("AAA $validityType");
              } else {
                validityType = validity[1];
                print("AAA $validityType");
              }
            });
          },
          child: Text(validity[i], style: orderBtnText(size)),
        ),
      );
    });
    return listButtons;
  }

  Future placeOrder(
      exchange,
      scriptName,
      quantity,
      price,
      product,
      priceTyp,
      diskQty,
      triggerPrice,
      stopLoss,
      target,
      trailingStoploss,
      validityType,
      amo) async {
    print(
        "placeOrder Values :: $lastPrice :: $changePrice  :  $quantity  :   $diskQty   :  $product  :  $priceTyp : ${scriptName.toString().replaceAll("&", "%26")} : $validityType");
    try {
      String symName = scriptName.toString().replaceAll("&", "%26");
      http.Response response = await http.post(Uri.parse(ApiLinks.placeOrder),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body:
              '''jData={"uid":"${ConstVariable.userId}","actid":"${ConstVariable.accId}","exch":"$exchange","tsym":"$symName","qty":"$quantity","prc":"$price","dscqty":"$diskQty","prd":"$product","trantype":"B","trgprc":"$triggerPrice","prctyp":"$priceTyp","bpprc":"$target","trailprc":"$trailingStoploss","ret":"$validityType","amo":"$amo","blprc":"$stopLoss","ordersource":"MOB"}&jKey=${ConstVariable.sessionId}''');

      Map mapRes = json.decode(response.body);
      log("$mapRes");
      if (mapRes['stat'] == "Ok") {
        ScaffoldMessenger.of(context)
            .showSnackBar(sb.successBar("Order Placed"));
        setState(() {
          ConstVariable.bottomIndex = 1;
        });

        Navigator.pushNamed(context, 'mobIndex');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(sb.successBar(mapRes['emsg']));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(sb.unSuccessBar(e.toString()));
    }
  }
}
