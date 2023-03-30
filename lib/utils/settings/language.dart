import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/splash/splash.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
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
            AppText(
              txt: 'Please select your Language',
              color: Colors.white,
              size: 20,
            ),
            Text(
              'Chagua Lugha yako',
              style: GoogleFonts.vesperLibre(color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setString('language', 'Kiswahili'.toString());
                Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Splash()));
              },
              child: SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  height: 50,
                  width: 340,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/download.png',
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        AppText(
                          size: 15,
                          txt: 'Kiswahili',
                        ),
                        Spacer(),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setString('language', 'English'.toString());
                Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Splash()));
              },
              child: SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor('#F5841F'),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  height: 50,
                  width: 340,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/britain.png',
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        AppText(
                          size: 15,
                          txt: 'English',
                          color: Colors.white,
                        ),
                        Spacer(),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
