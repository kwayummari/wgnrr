import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class AppButton extends StatelessWidget {
  final Function onPress;
  final String label;
  final Color? bcolor;
  final double? borderCurve;

  const AppButton(
      {Key? key,
      required this.onPress,
      required this.label,
      required this.bcolor,
      required this.borderCurve,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          foregroundColor: HexColor('#F5841F'),
          backgroundColor: bcolor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderCurve!),
              side: BorderSide(color: Colors.black)),
        ),
        onPressed: () => onPress(),
        child: AppText(
          txt: label,
          color: Colors.white,
          size: 15,
        ));
  }
}
