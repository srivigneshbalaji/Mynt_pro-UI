import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import '../../../../constant/constants.dart';
import '../../../../model/portfolio_model.dart';

class PositionScreen extends StatefulWidget {
  final List<PortfolioModel> positions;
  const PositionScreen({super.key, required this.positions});

  @override
  State<PositionScreen> createState() => _PositionScreenState();
}

class _PositionScreenState extends State<PositionScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Portfolio Summary",
            style: watchListTextStyle(size),
          ),
          Container(
            margin: EdgeInsets.only(
                top: size.height * 0.010, bottom: size.height * 0.006),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "\$4,275.28",
                  style: portValTextStyle(size),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: pcUpBackground(),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 1, 5, 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "5.76% ",
                          style: portPerUpTextStyle(size),
                        ),
                        SvgPicture.asset(
                          "assets/arrowUp.svg",
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'You gained ',
              style: pGainTextTextStyle(size),
              children: <TextSpan>[
                TextSpan(
                  text: '\$230.87',
                  style: pGainValTextStyle(size),
                ),
                const TextSpan(
                  text: ' in October 2022',
                ),
              ],
            ),
          ),
          Divider(
            color: const Color(0xffEFEFEF),
            thickness: 1,
            height: size.height * 0.03,
          ),
          Container(
            margin: EdgeInsets.only(
                top: size.height * 0.001, bottom: size.height * 0.006),
            child: Text(
              "Top Movers",
              style: topMoverTextStyle(size),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.positions.length,
              itemBuilder: (context, index) {
                Future<bool> imageCircle(tokenVal, symbolName) async {
                  var request = http.Request(
                      'GET',
                      Uri.parse(
                          'https://besim.zebull.in/static/equity/icons/${tokenVal}_$symbolName.webp'));

                  http.StreamedResponse response = await request.send();

                  if (response.statusCode == 200) {
                    return true;
                  } else {
                    return false;
                  }
                }

                return InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, 'depthWatchList');
                  },
                  onLongPress: () {
                    // Navigator.pushNamed(context, 'editWatchlist');
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: size.height * .0065),
                    height: size.height * .061,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            stcokImg(imageCircle, index, size),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 4.3, 0, 4.3),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.positions[index].symbolName,
                                      style: listTitle(size),
                                    ),
                                    Text(
                                      "${widget.positions[index].ltp}",
                                      style: widget.positions[index].ltp > 0
                                          ? ltpUpTextStyle(size)
                                          : ltpDownTextStyle(size),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.positions[index].exc,
                                      style: listSubTitle(size),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: widget.positions[index]
                                                      .perChange >
                                                  0
                                              ? pcUpBackground()
                                              : pcDownBackground(),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12))),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5.0, 1, 5, 3),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${widget.positions[index].perChange}% ",
                                              style: widget.positions[index]
                                                          .perChange >
                                                      0
                                                  ? pcUpTextStyle(size)
                                                  : pcDownTextStyle(size),
                                            ),
                                            widget.positions[index].perChange >
                                                    0
                                                ? SvgPicture.asset(
                                                    "assets/arrowUp.svg")
                                                : SvgPicture.asset(
                                                    "assets/arrowDown.svg"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<bool> stcokImg(
      Future<bool> Function(dynamic tokenVal, dynamic symbolName) imageCircle,
      int index,
      Size size) {
    return FutureBuilder(
      future: imageCircle(widget.positions[index].tokenValue,
          widget.positions[index].symbolName),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == true) {
          return Container(
            height: size.height * .056,
            width: size.width * .11,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 218, 215, 215),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Container(
              margin: EdgeInsets.all(size.height * .005),
              child: Image.network(
                "https://besim.zebull.in/static/equity/icons/${widget.positions[index].tokenValue}_${widget.positions[index].symbolName}.webp",
                fit: BoxFit.contain,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            height: size.height * .056,
            width: size.width * .11,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 218, 215, 215),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(widget.positions[index].symbolName[0],
                textAlign: TextAlign.center, style: symbolIconTextStyle(size)),
          );
        } else {
          return Container(
            height: size.height * .056,
            width: size.width * .11,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 218, 215, 215),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Center(
              child: Text(widget.positions[index].symbolName[0],
                  textAlign: TextAlign.center,
                  style: symbolIconTextStyle(size)),
            ),
          );
        }
      },
    );
  }
}
