import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class Alerts {
  static showSnackBar({
    required BuildContext context,
    required IconData icon,
    required String headline,
    Duration duration = const Duration(seconds: 3),
  }) {
    final SnackBar snackBar = SnackBar(
      padding: const EdgeInsets.all(20.0),
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headline,
                  // style:
                  //     textStyles.kTextSubtitle1.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final Function onPostivePressed;
  final Function onNegativePressed;
  final double circularBorderRadius;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.onPostivePressed,
    required this.onNegativePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        // style: textStyles.kTextSubtitle1.copyWith(color: colors.kColorBlack),
      ),
      content: Text(
        message,
        // style: textStyles.kTextTitle.copyWith(color: colors.kColorBlack80),
      ),
      backgroundColor: bgColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: const [
        // ignore: deprecated_member_use
        // FlatButton(
        //   textColor: colors.kColorBlueText,
        //   onPressed: () {
        //     onPostivePressed();
        //   },
        //   child: Text(
        //     positiveBtnText,
        //     style: textStyles.kTextSmallButton,
        //   ),
        // ),
        // // ignore: deprecated_member_use
        // FlatButton(
        //   textColor: colors.kColorBlueText,
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: Text(
        //     negativeBtnText,
        //     style: textStyles.kTextSmallButton,
        //   ),
        // ),
      ],
    );
  }
}
