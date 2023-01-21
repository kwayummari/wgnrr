import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/authentication/login.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  var language;
  List languages = [
    'English',
    'Kiswahili',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor('#742B90'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: size.width,
                child: Image.asset(
                  'assets/language.png',
                  // height: 200,
                )),
            Text(
              'Please select Language',
              style: GoogleFonts.vesperLibre(color: Colors.white),
            ),
            Text(
              'Chagua Lugha',
              style: GoogleFonts.vesperLibre(color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Container(
                padding: EdgeInsets.only(left: 1, right: 16),
                decoration: BoxDecoration(
                    color: HexColor('#ffffff'),
                    border: Border.all(color: HexColor("#000000"), width: 1),
                    borderRadius: BorderRadius.circular(0)),
                child: DropdownButtonFormField(
                  elevation: 10,
                  menuMaxHeight: 300,
                  isExpanded: true,
                  focusColor: Colors.white,
                  style: GoogleFonts.vesperLibre(color: Colors.black, fontSize: 22),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.language,
                      color: Colors.black,
                    ),
                    hoverColor: null,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                  // underline: SizedBox(),
                  hint: Text(
                    'User Language',
                    style:
                        GoogleFonts.vesperLibre(fontSize: 15, color: Colors.black),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "This field cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  value: language,
                  onChanged: (newValue1) async{
                    final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('language', newValue1.toString());
      Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                    setState(() {
                      language = newValue1;
                    });
                  },
                  items: languages.map((valueItem1) {
                    return DropdownMenuItem(
                      value: valueItem1,
                      child: Text(
                        valueItem1 != null ? valueItem1 : 'default value',
                        style: GoogleFonts.vesperLibre(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
