// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/models/client/chats/table/facility_maping.dart';
import 'package:wgnrr/models/client/chats/table/list_chats.dart';
import 'package:wgnrr/models/client/open_chat/list_community.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawerEnableOpenDragGesture: false,
        drawer: AppDrawer(
          username: username,
          language: language,
          status: status,
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
          title: Text(
              language == 'Kiswahili'
                  ? 'Karibu ${username}'
                  : 'Welcome ${username}',
              style: GoogleFonts.vesperLibre(
                  fontSize: 15,
                  color: HexColor('#ffffff'),
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [list_community()],
          ),
        ));
  }
}
