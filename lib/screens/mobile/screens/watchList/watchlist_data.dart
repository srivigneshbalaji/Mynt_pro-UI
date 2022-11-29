import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mynt_pro/web_socket/web_sockts.dart';

import '../../../../constant/text_style.dart';

class WatchListData extends StatelessWidget {
  final Values data;
  WatchListData({
    Key? key,
    required this.data,
  }) : super(key: key);

  String stockName = "";
  var pChange;

  var che;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: WebSocketConnection.touchAcknowledgementStream.stream
            .where((event) => event.tk == data.token),
        builder: (_,
            AsyncSnapshot<TouchlineAcknowledgementStream>
                snapshotAcknowledgement) {
          data.change = "0.00";
          data.perChange = "0.00";
          data.open = "0.00";
          data.close = "0.00";
          data.ltp = "0.00";
          che = 0;
          pChange = 0;
          if (snapshotAcknowledgement.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshotAcknowledgement.connectionState ==
                  ConnectionState.active &&
              snapshotAcknowledgement.hasData) {
            if (snapshotAcknowledgement.data!.tk == data.token) {
              data.symbolname = snapshotAcknowledgement.data!.ts == null ||
                      snapshotAcknowledgement.data!.ts! == 'null'
                  ? data.symbolname
                  : snapshotAcknowledgement.data!.ts!;
              data.exc = snapshotAcknowledgement.data!.e == null ||
                      snapshotAcknowledgement.data!.e! == 'null'
                  ? data.exc
                  : snapshotAcknowledgement.data!.e!;
              data.close = snapshotAcknowledgement.data!.c == null ||
                      snapshotAcknowledgement.data!.c! == 'null'
                  ? data.close
                  : snapshotAcknowledgement.data!.c!;

              data.ltp = snapshotAcknowledgement.data!.lp == null ||
                      snapshotAcknowledgement.data!.lp! == 'null'
                  ? data.ltp
                  : snapshotAcknowledgement.data!.lp!;
              data.perChange = snapshotAcknowledgement.data!.pc == null ||
                      snapshotAcknowledgement.data!.pc! == 'null'
                  ? data.perChange
                  : snapshotAcknowledgement.data!.pc!;
              data.change = data.change == null || data.change == "null"
                  ? data.change
                  : (double.parse(data.ltp!) - double.parse(data.close!))
                      .toStringAsFixed(2);
              pChange = num.tryParse("${data.perChange}")?.toDouble();

              che = num.tryParse("${data.change}")?.toDouble();
              // const String find = "-EQ";
              // const String rePlace = "";
              // stockName = (data.symbolname!.replaceAll(find, rePlace));
            }
          }
          // if (snapshotAcknowledgement.data == null) {
          //   return Container();
          // }
          // if (snapshotAcknowledgement.data != null) {
          //   if (snapshotAcknowledgement.data!.tk == data.token) {
          //     data.symbolname = snapshotAcknowledgement.data!.ts == null ||
          //             snapshotAcknowledgement.data!.ts! == 'null'
          //         ? data.symbolname
          //         : snapshotAcknowledgement.data!.ts!;
          //     data.exc = snapshotAcknowledgement.data!.e == null ||
          //             snapshotAcknowledgement.data!.e! == 'null'
          //         ? data.exc
          //         : snapshotAcknowledgement.data!.e!;
          //     data.close = snapshotAcknowledgement.data!.c == null ||
          //             snapshotAcknowledgement.data!.c! == 'null'
          //         ? data.close
          //         : snapshotAcknowledgement.data!.c!;

          //     data.ltp = snapshotAcknowledgement.data!.lp == null ||
          //             snapshotAcknowledgement.data!.lp! == 'null'
          //         ? data.ltp
          //         : snapshotAcknowledgement.data!.lp!;
          //     data.perChange = snapshotAcknowledgement.data!.pc == null ||
          //             snapshotAcknowledgement.data!.pc! == 'null'
          //         ? data.perChange
          //         : snapshotAcknowledgement.data!.pc!;
          //     data.change = data.change == null || data.change == "null"
          //         ? data.change
          //         : (double.parse(data.ltp!) - double.parse(data.close!))
          //             .toStringAsFixed(2);
          //     pChange = num.tryParse("${data.perChange}")?.toDouble();

          //     che = num.tryParse("${data.change}")?.toDouble();
          //     final String find = "-EQ";
          //     final String rePlace = "";
          //     stockName = (data.symbolname!.replaceAll(find, rePlace));
          //   } else {
          //     return Container();
          //   }
          // }

          return StreamBuilder(
            stream: WebSocketConnection.mwStream.stream
                .where((event) => event.tk == data.token),
            builder: (_, AsyncSnapshot<TouchlineUpdateStream> snapshot) {
              if (snapshot.data != null) {
                if (snapshot.data!.tk == data.token) {
                  data.ltp =
                      snapshot.data!.lp == null || snapshot.data!.lp! == 'null'
                          ? data.ltp
                          : snapshot.data!.lp!;

                  data.perChange =
                      snapshot.data!.pc == null || snapshot.data!.pc! == 'null'
                          ? data.perChange
                          : snapshot.data!.pc!;
                  data.close =
                      snapshot.data!.c == null || snapshot.data!.c! == 'null'
                          ? data.close
                          : snapshot.data!.c!;
                  data.change = data.change == null ||
                          data.change == "0.00" ||
                          data.change == "00.00"
                      ? data.change
                      : (double.parse(data.ltp!) - double.parse(data.close!))
                          .toStringAsFixed(2);
                  pChange = num.tryParse("${data.perChange}")?.toDouble();

                  che = num.tryParse("${data.change}")?.toDouble();
                }
                return watchListDataList(size);
              } else {
                return watchListDataList(size);
              }
            },
          );
        });
  }

  Container watchListDataList(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * .0012),
      height: size.height * .062,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 4.6, 0, 4.6),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.symbolname.toString().toUpperCase(),
                  style: listTitle(size),
                ),
                Text(data.ltp!, style: ltpUpTextStyle(size)
                    // : ltpDownTextStyle(size),
                    )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.exc!.toUpperCase(),
                  style: listSubTitle(size),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: che > 0 || pChange > 0
                          ? pcUpBackground()
                          : pcDownBackground(),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 1, 5, 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${che.toStringAsFixed(2)} ($pChange%)",
                          style: che > 0 || pChange > 0
                              ? pcUpTextStyle(size)
                              : pcDownTextStyle(size),
                        ),
                        che > 0 || pChange > 0
                            ? SvgPicture.asset("assets/arrowUp.svg")
                            : SvgPicture.asset("assets/arrowDown.svg"),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
