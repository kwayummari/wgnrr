import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wgnrr/models/health_care_provider/feedback/feedback.dart';
import 'package:wgnrr/splash/splash.dart';
import 'package:wgnrr/utils/routes/language.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class AppDrawer extends StatefulWidget {
  var language;
  var status;
  var username;
  AppDrawer(
      {Key? key,
      required this.language,
      required this.status,
      required this.username});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Future<void> phonecall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '0762996305',
    );
    await launchUrl(launchUri);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 3;
    return Drawer(
      backgroundColor: HexColor('#ffffff'),
      child: Column(
        children: [
          Container(
              color: Colors.white,
              child: Image.asset(
                'assets/full_logo.png',
                height: 300,
              )),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(
              Icons.person_2,
              color: Colors.black,
            ),
            title: AppText(
              txt: widget.username!,
              size: 15,
              color: HexColor('#000000'),
              weight: FontWeight.w500,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(
              Icons.newspaper,
              color: Colors.black,
              size: 15,
            ),
            title: AppText(
              txt: widget.status!,
              size: 15,
              color: HexColor('#000000'),
              weight: FontWeight.w500,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Quiz())),
            leading: Icon(
              Icons.account_box,
              color: Colors.black,
              size: 15,
            ),
            title: AppText(
              txt: widget.language == 'Kiswahili' ? 'Marejesho' : 'Feedback',
              size: 15,
              color: HexColor('#000000'),
              weight: FontWeight.w500,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () => phonecall(),
            leading: Icon(
              Icons.phone,
              color: Colors.black,
              size: 15,
            ),
            title: AppText(
              txt: widget.language == 'Kiswahili'
                  ? 'Wasiliana nasi'
                  : 'Contact us',
              size: 15,
              color: HexColor('#000000'),
              weight: FontWeight.w500,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              widget.language == 'Kiswahili'
                  ? sharedPreferences.setString(
                      'language', 'English'.toString())
                  : sharedPreferences.setString(
                      'language', 'Kiswahili'.toString());
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Splash()));
            },
            leading: Icon(
              Icons.language,
              color: Colors.black,
              size: 15,
            ),
            title: AppText(
              txt: widget.language == 'Kiswahili' ? 'English' : 'Kiswahili',
              size: 15,
              color: HexColor('#000000'),
              weight: FontWeight.w500,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.remove('username');
              sharedPreferences.remove('status');
              sharedPreferences.remove('bot');
              sharedPreferences.remove('language');
              Navigator.of(context).pushAndRemoveUntil(
                  // the new route
                  MaterialPageRoute(
                    builder: (BuildContext context) => Language(),
                  ),
                  (Route route) => false);
            },
            leading: Icon(
              Icons.logout,
              color: Colors.black,
              size: 15,
            ),
            title: AppText(
              txt: widget.language == 'Kiswahili' ? 'Toka' : 'Sign Out!',
              size: 15,
              color: HexColor('#000000'),
              weight: FontWeight.w500,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
