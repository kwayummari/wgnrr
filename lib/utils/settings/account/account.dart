import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/widget/IconButton/IconButton.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
      get_userdata();
    });
  }

  var user;
  List users = [];

  Future get_userdata() async {
    const url = '${murl}user/user.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "user": username.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          users = json.decode(response1.body);
        });
    }
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
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        shape: Border(bottom: BorderSide(color: Colors.orange, width: 0.2)),
        elevation: 4,
        toolbarHeight: 70,
        backgroundColor: HexColor('#742B90'),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.white),
            children: <TextSpan>[
              TextSpan(
                text: language == 'Kiswahili' ? 'Akaunti yako' : 'Your account',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
              ),
              TextSpan(
                text: '\n@${username}',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Title(
                color: Colors.white,
                child: AppText(
                    txt:
                        'See information about your account,download an archive of your data, or learn about your account deactivation options.',
                    size: 14)),
            SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Account())),
              leading: Icon(Icons.person),
              title: AppText(
                txt: 'Account information',
                size: 15,
                weight: FontWeight.bold,
              ),
              subtitle: AppText(
                  txt:
                      'See your account information like your phone number and email address.',
                  size: 14),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Account())),
              leading: Icon(Icons.key),
              title: AppText(
                txt: 'Change your password',
                size: 15,
                weight: FontWeight.bold,
              ),
              subtitle:
                  AppText(txt: 'change your password at any time', size: 14),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Account())),
              leading: Icon(Icons.download),
              title: AppText(
                txt: 'Download an archive of your data',
                size: 15,
                weight: FontWeight.bold,
              ),
              subtitle: AppText(
                  txt:
                      'Get insights into the type of information stored for your account.',
                  size: 14),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Account())),
              leading: Icon(Icons.heart_broken),
              title: AppText(
                txt: 'Deactivate your account',
                size: 15,
                weight: FontWeight.bold,
              ),
              subtitle: AppText(
                  txt: 'Find out how you can deactivate your account.',
                  size: 14),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
