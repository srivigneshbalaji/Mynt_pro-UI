import 'package:flutter/material.dart';
import '../../../../constant/constants.dart';

class PendingOrder extends StatelessWidget {
  const PendingOrder({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Center(
      child: Text(
        "NO PENDING ORDERS",
        style: noDataTextStyle(size),
      ),
    );
  }
}
