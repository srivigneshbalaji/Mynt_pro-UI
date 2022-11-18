import 'package:flutter/material.dart';

class CustomLongButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final Color color;
  final bool? loading;

  const CustomLongButton({
    Key? key,
    this.loading,
    required this.color,
    required this.label,
    required this.onPress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading == true ? () {} : () => onPress(),
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          fixedSize: Size(MediaQuery.of(context).size.width, 52)),
      child: loading == true
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Text(
              label,
              // style: textStyles.kTextButton,
            ),
    );
  }
}
