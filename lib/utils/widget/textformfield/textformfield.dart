import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class AppTextformfield extends StatelessWidget {
  final TextEditingController? textfieldcontroller;
  final String? label;
  final Icon? icon;
  final IconButton? suffixicon;
  final bool obscure;
  final Function? validate;
   String? language;
  AppTextformfield({
    Key? key,
    required this.textfieldcontroller,
    this.icon,
    this.suffixicon,
    required this.language,
    required this.label,
    required this.obscure,
    this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      obscuringCharacter: '*',
      controller: textfieldcontroller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        label: AppText(
          txt: label,
          size: 15,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.white,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: HexColor('#000000')),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: HexColor('#000000')),
        ),
        prefixIcon: icon,
        suffixIcon: suffixicon,
      ),
      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else if (value.isEmpty) {
          return language == 'Kiswahili' ? 'Inapaswa kujazwa' : "THis field cannot be empty";;
        }
      },
    );
  }
}
