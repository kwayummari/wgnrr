import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/open_chat/table.dart';
import 'package:wgnrr/utils/screens/categories.dart';
import 'package:wgnrr/utils/screens/choices.dart';
import 'package:wgnrr/utils/screens/stats.dart';
import 'package:wgnrr/utils/screens/topcircular.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';

enum MenuItem { item1, item2, item3, item4, item5, item6 }

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

  @override
  void initState() {
    super.initState();
    getValidationData();
    update();
  }

  List updates = [];
  Future update() async {
    http.Response response;
    const url = '${murl}version/get.php';
    var response1 = await http.get(Uri.parse(url));
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          updates = json.decode(response1.body);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: updates.isNotEmpty
          ? AppDrawer(
              username: username,
              language: language,
              status: status,
              update: updates[0]['version'],
            )
          : null,
      appBar: AppBar(
        leading: Builder(
            builder: (context) => // Ensure Scaffold is in context
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                )),
        automaticallyImplyLeading: false,
        shape: Border(bottom: BorderSide(color: Colors.orange, width: 0.2)),
        elevation: 4,
        toolbarHeight: 70,
        backgroundColor: HexColor('#742B90'),
        title: Text(
            language == 'Kiswahili'
                ? 'Karibu ${username}'
                : 'Welcome ${username}',
            style: TextStyle(
                fontSize: 15,
                color: HexColor('#ffffff'),
                fontWeight: FontWeight.w500)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Community())),
            icon: Image.asset(
              'assets/community.png',
              height: 40,
            ),
          )
          // : Container()
        ],
      ),
      backgroundColor: HexColor('#742B90'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Platform.isIOS ? 50 : 100,
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
