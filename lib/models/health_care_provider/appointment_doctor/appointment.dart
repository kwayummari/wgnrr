// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/models/health_care_provider/appointment_doctor/list.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';

enum MenuItem { item1, item2, item3, item4, item5 }

class Appointment_table_doctor extends StatefulWidget {
  const Appointment_table_doctor({super.key});

  @override
  State<Appointment_table_doctor> createState() => _Appointment_table_doctorState();
}

class _Appointment_table_doctorState extends State<Appointment_table_doctor> {
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
          automaticallyImplyLeading: true,
          shape: Border(bottom: BorderSide(color: Colors.orange, width: 0.2)),
          elevation: 4,
          toolbarHeight: 70,
          backgroundColor: HexColor('#742B90'),
          title: Text(
              language == 'Kiswahili'
                  ? 'Apointimenti Zako'
                  : 'Your Appointments',
              style: GoogleFonts.vesperLibre(
                  fontSize: 15,
                  color: HexColor('#ffffff'),
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              list_appointment_doctor()
            ],
          ),
        ));
  }
}
