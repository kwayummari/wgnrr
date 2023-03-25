import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  // final Widget child;
  final String? txt;
  var color;
  var weight;
  double size;
  TextDecoration? textdecoration;
  AppText(
      {Key? key,
      required this.txt,
      this.color,
      this.weight,
      this.textdecoration,
      required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt.toString(),
      style: TextStyle(
        decoration: textdecoration,
        color: color,
        fontSize: size,
        fontFamily: 'OpenSans',
        fontWeight: weight,
      ),
    );
  }
}
