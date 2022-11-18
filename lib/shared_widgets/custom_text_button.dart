import 'package:flutter/material.dart';

import '../constant/constants.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final TextStyle? textStyle;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color color = const Color(0xFF42A5F5);
    return InkWell(
        onTap: () => onPress(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: logText(size, color),
          ),
        ));
  }
}
