import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wgnrr/splash/splash.dart';
import 'package:wgnrr/utils/settings/account/account.dart';
import 'package:wgnrr/utils/settings/language.dart';
import 'package:wgnrr/utils/widget/IconButton/IconButton.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var username;
  var status;
  var bot;
  var language;
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var u = sharedPreferences.get('username');
    var s = sharedPreferences.get('status');
    var b = sharedPreferences.get('bot');
    var l = sharedPreferences.get('language');
    setState(() {
      username = u;
      status = s;
      bot = b;
      language = l;
    });
  }

  Future<void> phonecall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '0743469680',
    );
    await launchUrl(launchUri);
  }

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        shape: Border(bottom: BorderSide(color: Colors.orange, width: 0.2)),
        elevation: 4,
        toolbarHeight: 70,
        backgroundColor: HexColor('#742B90'),
        title: AppText(
          txt: language == 'Kiswahili'
              ? 'Mpangilio \n@${username}'
              : 'Settings \n@${username}',
          size: 15,
          color: HexColor('#ffffff'),
          weight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Account())),
              leading: Icon(Icons.person),
              title: AppText(
                txt: 'Your Account',
                size: 15,
                weight: FontWeight.bold,
              ),
              subtitle: AppText(
                  txt:
                      'See information about your account,download an archive of your data, or learn about your account deactivation options.',
                  size: 14),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Language())),
              leading: Icon(Icons.language),
              title: AppText(
                txt: 'Language',
                size: 15,
                weight: FontWeight.bold,
              ),
              subtitle: AppText(
                  txt:
                      'Choose the language you prefer to use in the application. The language chosen will affect all content of the app.',
                  size: 14),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () => phonecall(),
              leading: Icon(Icons.phone),
              title: AppText(
                txt: 'Contact us',
                size: 15,
                weight: FontWeight.bold,
              ),
              subtitle: AppText(
                  txt:
                      'Communicate through our office phone number incase of any emergency.',
                  size: 14),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
