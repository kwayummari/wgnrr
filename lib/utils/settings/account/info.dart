import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/utils/animation/shimmer.dart';
import 'package:wgnrr/utils/settings/account/changephonenumber.dart';
import 'package:wgnrr/utils/settings/account/usernamechange.dart';
import 'package:wgnrr/utils/settings/language.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class accountInfo extends StatefulWidget {
  const accountInfo({super.key});

  @override
  State<accountInfo> createState() => _accountInfoState();
}

class _accountInfoState extends State<accountInfo> {
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
    await get_userdata();
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
      body: users.isEmpty
          ? ShimmerLoading(
              width: 200.0,
              height: 50.0,
              borderRadius: 10.0,
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => usernameChange())),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 20, top: 20),
                      child: Row(
                        children: [
                          AppText(
                            txt: 'Username',
                            size: 15,
                            weight: FontWeight.bold,
                          ),
                          Spacer(),
                          AppText(
                            txt: '@${username}',
                            size: 15,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => changePhonenumber(
                              phone: users[0]['phone'],
                            ))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 20,
                      ),
                      child: Row(
                        children: [
                          AppText(
                            txt: 'Phone',
                            size: 15,
                            weight: FontWeight.bold,
                          ),
                          Spacer(),
                          AppText(
                            txt: users[0]['phone'],
                            size: 15,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 20,
                    ),
                    child: Row(
                      children: [
                        AppText(
                          txt: 'Role',
                          size: 15,
                          weight: FontWeight.bold,
                        ),
                        Spacer(),
                        AppText(
                          txt: users[0]['role'],
                          size: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 20,
                    ),
                    child: Row(
                      children: [
                        AppText(
                          txt: 'Date of Birth',
                          size: 15,
                          weight: FontWeight.bold,
                        ),
                        Spacer(),
                        AppText(
                          txt: users[0]['age'],
                          size: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 10,
                    ),
                    child: Row(
                      children: [
                        AppText(
                          txt: 'Country',
                          size: 15,
                          weight: FontWeight.bold,
                        ),
                        Spacer(),
                        AppText(
                          txt: 'Tanzania',
                          size: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Uri.parse('https://flutter.dev'),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 20,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Select the country you live in. ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              TextSpan(
                                text: 'Learn more',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
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
                    },
                    child: AppText(
                      txt: 'Log out',
                      size: 15,
                      color: Colors.red,
                      weight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
