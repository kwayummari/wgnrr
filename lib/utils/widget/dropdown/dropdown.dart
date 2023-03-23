import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class AppDropdownformfield extends StatelessWidget {
  final String? label;
  final Icon? icon;
  final IconButton? suffixicon;
  final String? value;
  final Function onchange;
  final List? values;
  final String? language;
  AppDropdownformfield({
    Key? key,
    required this.icon,
    required this.values,
    required this.onchange,
    required this.value,
    required this.label,
    required this.language,
    this.suffixicon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      elevation: 10,
      menuMaxHeight: 330,
      isExpanded: true,
      focusColor: Colors.white,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
          borderSide: BorderSide(color: HexColor('#000000')),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
          borderSide: BorderSide(color: HexColor('#000000')),
        ),
        prefixIcon: icon,
        prefixIconColor: Colors.black,
        label: AppText(
          txt: label,
          size: 15,
          color: Colors.black,
        ),
      ),
      validator: (value) {
        if (value == null) {
          language == 'Kiswahili' ? 'Inapaswa kujazwa' : "THis field cannot be empty";
        } else {
          return null;
        }
      },
      value: value,
      onChanged: (newValue) => onchange(),
      items: values!.map((valueItem) {
        return DropdownMenuItem(
          value: valueItem,
          child: AppText(
            txt: valueItem != null ? valueItem : 'default value',
            color: Colors.black,
            size: 15,
          ),
        );
      }).toList(),
    );
  }
}
