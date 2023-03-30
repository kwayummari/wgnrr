import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/routes/language.dart';
import 'package:wgnrr/utils/widget/text/text.dart';
import 'package:wgnrr/utils/widget/textformfield/textformfield.dart';

class deactivateAccount extends StatefulWidget {
  const deactivateAccount({super.key});

  @override
  State<deactivateAccount> createState() => _deactivateAccountState();
}

class _deactivateAccountState extends State<deactivateAccount> {
  var username;
  var status;
  var bot;
  var language;
  var oldusername;
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
      oldusername = u;
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

  Future deactivate() async {
    const url = '${murl}user/deactivation.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "id": users[0]['id'].toString(),
    });
    if (response1.statusCode == 200) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.remove('username');
      sharedPreferences.remove('status');
      sharedPreferences.remove('bot');
      sharedPreferences.remove('language');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => Language(),
          ),
          (Route route) => false);
    }
  }

  TextEditingController newphone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        leading: Padding(
          padding: const EdgeInsets.only(top: 25, left: 9),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: AppText(
              txt: 'Cancel',
              size: 15,
              color: Colors.white,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        shape: Border(bottom: BorderSide(color: Colors.orange, width: 0.2)),
        elevation: 4,
        toolbarHeight: 70,
        backgroundColor: HexColor('#742B90'),
        title: AppText(
          txt: 'Account deactivation',
          size: 15,
          weight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  txt: 'This will deactivate your account',
                  size: 15,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  txt:
                      'You’re about to start the process of deactivating your Wgnrr account. Your display name, @username, and public profile will no longer be viewable on wgnrrafrica.org, Wgnrr for iOS, or Wgnrr for Android.',
                  size: 15,
                  weight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  txt: 'What else you should know',
                  size: 15,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: AppText(
                  txt:
                      'You can restore your Wgnrr account if it was accidentally or wrongfully deactivated for up to 30 days after deactivation.',
                  size: 15,
                  color: HexColor('#000000'),
                  weight: FontWeight.normal,
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: AppText(
                  txt:
                      'Some account information may still be available in search engines, such as Google or Bing. \n Learn more',
                  size: 15,
                  color: HexColor('#000000'),
                  weight: FontWeight.normal,
                ),
                subtitle: AppText(
                  txt: 'Learn more',
                  size: 15,
                  color: Colors.blue,
                  weight: FontWeight.normal,
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: AppText(
                  txt:
                      'If you just want to change your @username, you don’t need to deactivate your account — edit it in your settings.',
                  size: 15,
                  color: HexColor('#000000'),
                  weight: FontWeight.normal,
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: AppText(
                  txt:
                      'To use your current @username or email address with a different Wgnrr account, change them before you deactivate this account.',
                  size: 15,
                  color: HexColor('#000000'),
                  weight: FontWeight.normal,
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: AppText(
                  txt:
                      'If you want to download your Wgnrr data, you’ll need to complete both the request and download process before deactivating your account. Links to download your data cannot be sent to deactivated accounts.',
                  size: 15,
                  color: HexColor('#000000'),
                  weight: FontWeight.normal,
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              InkWell(
                onTap: () async {
                  await deactivate();
                },
                child: AppText(
                  txt: 'Deactivate',
                  size: 15,
                  color: Colors.red,
                  weight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
