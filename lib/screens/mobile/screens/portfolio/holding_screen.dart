import 'package:flutter/material.dart';
import 'package:mynt_pro/constant/constants.dart';

class HoldingScreen extends StatefulWidget {
  const HoldingScreen({super.key});

  @override
  State<HoldingScreen> createState() => _HoldingScreenState();
}

class _HoldingScreenState extends State<HoldingScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Text(
        "NO DATA",
        style: noDataTextStyle(size),
      ),
    );
  }
}
