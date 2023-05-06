// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/models/client/pharmacy/list_pharmacy.dart';
import 'package:wgnrr/models/client/pharmacy/pharmacy_map.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

enum MenuItem { item1, item2, item3, item4, item5 }

class Pharmarcy extends StatefulWidget {
  const Pharmarcy({super.key});

  @override
  State<Pharmarcy> createState() => _PharmarcyState();
}

class _PharmarcyState extends State<Pharmarcy> {
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
          actions: [
            CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  color: HexColor('#F5841F'),
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MapSample_pharmacy()));
                  },
                )),
            SizedBox(
              width: 10,
            )
          ],
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
            size: 15,
              txt: language == 'Kiswahili'
                  ? 'Karibu ${username}'
                  : 'Welcome ${username}',color: Colors.white,weight: FontWeight.w500,),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [list_chats_pharmacy()],
          ),
        ));
  }
}
