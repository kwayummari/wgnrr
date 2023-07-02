import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppInputText extends StatelessWidget {
  final TextEditingController? textfieldcontroller;
  final String? label;
  final Icon? icon;
  final Color? fillcolor;
  final IconButton? suffixicon;
  final bool obscure;
  final Function? validate;
  final Function(String)? onChange;
  final bool isemail;
  final Color? labelColor;
  final TextInputType? textinputtype;
  AppInputText({
    Key? key,
    required this.textfieldcontroller,
    required this.isemail,
    required this.fillcolor,
    this.icon,
    this.suffixicon,
    this.onChange,
    required this.label,
    required this.obscure,
    this.validate,
    this.labelColor,
    this.textinputtype,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
      child: TextFormField(
        keyboardType: textinputtype ?? TextInputType.text,
        onChanged: onChange,
        obscureText: obscure,
        obscuringCharacter: '*',
        controller: textfieldcontroller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          label: Container(
            color: labelColor ?? HexColor('#e7d4d3'),
            child: Text(
              label.toString(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          filled: true,
          fillColor: fillcolor,
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
          RegExp regex = RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$');
          if (isemail) {
            if (value!.isNotEmpty) {
              return null;
            } else if (value.isEmpty) {
              return "THis field cannot be empty";
            } else if (!regex.hasMatch(value)) {
              return 'Password should contain \n -at least one upper case \n -at least one lower case \n -at least one digit \n -at least one Special character \n -Must be at least 8 characters in length';
            }
          } else {
            if (value!.isNotEmpty) {
              return null;
            } else if (value.isEmpty) {
              return "THis field cannot be empty";
            }
          }
        },
      ),
    );
  }
}
