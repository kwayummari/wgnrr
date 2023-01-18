import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/splash/splash.dart';
import 'package:wgnrr/utils/routes/language.dart';
import 'package:wgnrr/utils/widget/categories.dart';
import 'package:wgnrr/utils/widget/choices.dart';
import 'package:wgnrr/utils/widget/stats.dart';
import 'package:wgnrr/utils/widget/topcircular.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../quiz/quiz.dart';

enum MenuItem {
  item1,
  item2,
  item3,
  item4,
}

List datas = [];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data = [];
  Future get_datas() async {
    http.Response response;
    const API_URL = '${murl}choices/choice_name.php';
    response = await http.get(Uri.parse(API_URL));
    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          data = json.decode(response.body);
          for (int i = 0; i < data.length; i++) {
            datas.add(data[i]['name']);
            ;
          }
        });
    } //
  }

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
      get_datas();
    });
  }

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
    getValidationData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Platform.isAndroid
              ? IconButton(
                  onPressed: (() => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Splash()))),
                  icon: Icon(Icons.refresh, color: Colors.white))
              : Container()
        ],
        automaticallyImplyLeading: false,
        shape: Border(bottom: BorderSide(color: Colors.orange, width: 0.2)),
        elevation: 4,
        toolbarHeight: 70,
        backgroundColor: HexColor('#742B90'),
        title: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            PopupMenuButton(
                color: HexColor('#742B90'),
                onSelected: (value) async {
                  if (value == MenuItem.item3) {
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
                  } else if (value == MenuItem.item4) {
                    phonecall();
                  } else if (value == MenuItem.item2) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Quiz()));
                  }
                },
                position: PopupMenuPosition.under,
                child: Icon(
                  Icons.menu,
                  color: HexColor('#ffffff'),
                ),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        value: MenuItem.item1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                    username == null
                                        ? ''
                                        : username.toString() +
                                            ' - ' +
                                            status.toString(),
                                    style: GoogleFonts.rajdhani(
                                        fontSize: 15,
                                        color: HexColor('#ffffff'),
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: MenuItem.item2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_box,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text('Suggestion Box',
                                    style: GoogleFonts.rajdhani(
                                        fontSize: 15,
                                        color: HexColor('#ffffff'),
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: MenuItem.item4,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text('Contact us',
                                    style: GoogleFonts.rajdhani(
                                        fontSize: 15,
                                        color: HexColor('#ffffff'),
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: MenuItem.item3,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                    language == 'Kiswahili'
                                        ? 'Toka'
                                        : 'Sign Out!',
                                    style: GoogleFonts.rajdhani(
                                        fontSize: 15,
                                        color: HexColor('#ffffff'),
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ]),
            Spacer(),
            Text('Welcome ${username}',
                style: GoogleFonts.vesperLibre(
                    fontSize: 15,
                    color: HexColor('#ffffff'),
                    fontWeight: FontWeight.w500)),
            Spacer(),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: HexColor('#742B90'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    border: Border.all(color: Colors.black),
                  ),
                  height: size.height,
                  width: size.width,
                ),
                Positioned(
                  child: Topcircular(),
                  right: 0,
                  left: 0,
                  bottom: Platform.isIOS ? 750 : 680,
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: Platform.isIOS ? 510 : 470,
                  child: Categories(),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: Platform.isIOS ? 290 : 260,
                  child: Choices(),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: Platform.isIOS ? 90 : 60,
                  child: Stats(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
