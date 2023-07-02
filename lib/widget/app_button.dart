import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function onPress;
  final String label;
  final Color bcolor;
  final double borderRadius;
  final Color textColor;

  const AppButton(
      {Key? key,
      required this.onPress,
      required this.label,
      required this.borderRadius,
      required this.textColor,
      required this.bcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(bcolor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: () => onPress(),
        child: Text(
           label,
          style: TextStyle(color: textColor,
          fontSize: 15,),
        ));
  }
}
