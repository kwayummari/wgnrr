// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/health_care_provider/chats/table/list_chats.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';
import 'package:http/http.dart' as http;

class Chat_table extends StatefulWidget {
  const Chat_table({super.key});

  @override
  State<Chat_table> createState() => _Chat_tableState();
}

class _Chat_tableState extends State<Chat_table> {
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
    get_notification();
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

  List notifications = [];
  Future get_notification() async {
    http.Response response;
    const API_URL = '${murl}notification/get_doctor.php';
    response = await http.get(Uri.parse(API_URL));
    notifications = json.decode(response.body);
    if (response.statusCode == 200 && notifications.isNotEmpty) {
      if (notifications[0]['type'] == '1') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Alert! \n\n ${notifications[0]['description']}',
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red,
            elevation: 6.0,
            action: SnackBarAction(
              textColor: Colors.white,
              label: 'OK',
              onPressed: () =>
                  ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            ),
          ),
        );
      } else if (notifications[0]['type'] == '2') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Message'),
            content: Text(notifications[0]['description']),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else if (notifications[0]['type'] == '3') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.red,
            title: Text(
              'Important!',
              style: (TextStyle(color: Colors.white)),
            ),
            content: Text(
              notifications[0]['description'],
              style: (TextStyle(color: Colors.white)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      }
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
          title: AppText(
            txt: language == 'Kiswahili'
                ? 'Karibu ${username}'
                : 'Welcome ${username}',
            size: 15,
            color: Colors.white,
            weight: FontWeight.w500,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [list_chats()],
          ),
        ));
  }
}
