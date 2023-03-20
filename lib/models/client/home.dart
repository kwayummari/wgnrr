// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, curly_braces_in_flow_control_structures, depend_on_referenced_packages, library_private_types_in_public_api, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/models/client/chats/table/table.dart';
import 'package:wgnrr/models/client/home/home.dart';
import 'package:wgnrr/models/client/pharmacy/pharmacy_chats.dart';

class Homepage extends StatefulWidget {
  const Homepage(String text, {Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int index = 1;
  final Screen = [
    Chat_table(),
    Home(),
    Pharmarcy(),
  ];

  var language;
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var l = sharedPreferences.get('language');
    setState(() {
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
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            body: Screen[index],
            extendBody: true,
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: HexColor('#742B90'),
                  primaryColor: HexColor('#742B90'),
                  textTheme: Theme.of(context).textTheme.copyWith(
                      bodySmall:
                          GoogleFonts.vesperLibre(color: HexColor('#cbdd33')))),
              child: BottomNavigationBar(
                selectedItemColor: HexColor('#F5841F'),
                unselectedItemColor: HexColor('#ffffff'),
                backgroundColor: HexColor('#742B90'),
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat_sharp),
                      label: language == 'Kiswahili' ? 'Mazungumzo' : 'Chats'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: language == 'Kiswahili' ? 'Nyumbani' : 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.medication),
                      label: language == 'Kiswahili'
                          ? 'Duka la dawa'
                          : 'Pharmacy'),
                ],
                currentIndex: index,
                onTap: (index) {
                  if (mounted) setState(() => this.index = index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
