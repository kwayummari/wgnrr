// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/open_chat/list_community.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';
import 'package:http/http.dart' as http;
enum MenuItem { item1, item2, item3, item4, item5 }

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
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
        drawer: AppDrawer(
          username: username,
          language: language,
          status: status, update: updates[0]['version'],
        ),
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
          title: AppText(
              txt: language == 'Kiswahili'
                  ? 'Karibu ${username}'
                  : 'Welcome ${username}',
                  size: 15,
                  weight: FontWeight.w500,),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [list_community()],
          ),
        ));
  }
}
