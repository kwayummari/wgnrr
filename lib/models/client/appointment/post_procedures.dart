import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/appointment/surgical.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';
import 'package:http/http.dart' as http;

class postProcedures extends StatefulWidget {
  var doctor;
  var client;
  var reason;
  var date_attended;
  postProcedures({
    super.key,
    required this.client,
    required this.doctor,
    required this.reason,
    required this.date_attended,
  });

  @override
  State<postProcedures> createState() => _postProceduresState();
}

class _postProceduresState extends State<postProcedures> {
  var username;
  var status;
  var bot;
  var language;
  Duration? datedifference;
  String? difference;
  Future getValidationData() async {
    DateTime date1 = DateTime.now();
    DateTime date2 = DateTime.parse(widget.date_attended);

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
      datedifference = date1.difference(date2);
      difference = datedifference!.inHours.toString();
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
      print(updates);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Surgical(
              client: widget.client,
              date_difference: difference,
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
