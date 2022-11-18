import 'package:flutter/material.dart';

class CustomWidgetButton extends StatelessWidget {
  final Function onPress;
  final Widget widget;
  const CustomWidgetButton({
    Key? key,
    required this.onPress,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () => onPress(), child: widget);
  }
}
