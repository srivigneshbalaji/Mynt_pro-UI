import 'package:flutter/material.dart';

import '../constant/text_style.dart';
import '../util/sizer.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final Color color;
  final double? width;
  final double? height;
  final bool? loading;
  final TextStyle? textStyle;
  final Icon? prefixIcon;

  const CustomButton(
      {Key? key,
      this.loading,
      required this.color,
      required this.label,
      required this.onPress,
      this.prefixIcon,
      this.textStyle,
      this.height,
      this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading == true ? () {} : () => onPress(),
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          fixedSize: Size(width ?? 30, height ?? 5)),
      child: loading == true
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(visible: prefixIcon != null, child: prefixIcon!),
                Visibility(
                    visible: prefixIcon != null, child: Sizer.halfHorizontal()),
                Text(
                  label,
                  // style: textStyle ?? textStyles.kTextButton,
                ),
              ],
            ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final Color color;
  final double? width;
  final double? height;
  final bool? loading;
  final bool? isSelected;

  const CustomOutlineButton({
    Key? key,
    required this.color,
    this.height,
    required this.label,
    required this.onPress,
    this.width,
    this.loading,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final BoxDecoration decoration = BoxDecoration(
        color: isSelected ?? false ? color : Colors.transparent,
        border: Border.all(
            color: isSelected ?? false ? color : const Color(0xffE5E5E5)),
        borderRadius: const BorderRadius.all(Radius.circular(4)));
    // final normalTextStyle = textStyles.kTextSubtitle2;
    // final selectedTextStyle = textStyles.kTextSubtitle2
    // .copyWith(color: Colors.white, fontWeight: FontWeight.w700);
    return InkWell(
      onTap: loading == true ? () {} : () => onPress(),
      child: Container(
        height: 40,
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
              child: Text(
            label,
            style: listSubTitle(size),
          )
              // style:
              //     isSelected ?? false ? selectedTextStyle : normalTextStyle),
              ),
        ),
      ),
    );
  }
}
