import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class AppBottombar extends StatelessWidget {
  const AppBottombar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: HexColor('#F5841F'),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
              txt:
                  '\u00a9 ${DateTime.now().year.toString()} - Powered by WGNRR ',
              color: HexColor('#ffffff'),
              size: 16),
          AppText(
            txt: 'AFRICA',
            size: 16,
            color: HexColor('#ffffff'),
            weight: FontWeight.w700,
          )
        ],
      )),
    );
  }
}
