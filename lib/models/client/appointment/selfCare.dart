import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/appointment/selfCareSurgical.dart';
import 'package:wgnrr/models/client/appointment/surgical.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';
import 'package:http/http.dart' as http;

class selfCare extends StatefulWidget {
  var doctor;
  var client;
  var reason;
  selfCare({
    super.key,
    required this.client,
    required this.doctor,
    required this.reason,
  });

  @override
  State<selfCare> createState() => _selfCareState();
}

class _selfCareState extends State<selfCare> {
  var username;
  var status;
  var bot;
  var language;
  String? difference = '0';
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
            builder: (context) =>
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                )),
        automaticallyImplyLeading: true,
        shape: Border(bottom: BorderSide(color: Colors.orange, width: 0.2)),
        elevation: 4,
        toolbarHeight: 70,
        backgroundColor: HexColor('#742B90'),
        title: AppText(
          txt: language == 'Kiswahili'
              ? 'Apointimenti Zako'
              : 'Your Appointments was ${difference} hours ago',
          size: 15,
          color: HexColor('#ffffff'),
          weight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SurgicalSelfCare(
              client: widget.client,
              doctor: widget.doctor,
              language: language,
              reason: widget.reason,
            )
          ],
        ),
      ),
    );
  }
}
