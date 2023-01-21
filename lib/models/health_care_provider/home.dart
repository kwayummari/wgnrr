// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, curly_braces_in_flow_control_structures, depend_on_referenced_packages, library_private_types_in_public_api, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wgnrr/models/health_care_provider/chats/table/table.dart';
import 'package:wgnrr/models/health_care_provider/home/home.dart';

class Homepage_hcp extends StatefulWidget {
  const Homepage_hcp(String text, {Key? key}) : super(key: key);

  @override
  _Homepage_hcpState createState() => _Homepage_hcpState();
}

class _Homepage_hcpState extends State<Homepage_hcp> {
  int index = 1;
  final Screen = [
    Chat_table(),
    Home(),
  ];

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
                      caption: GoogleFonts.vesperLibre(color: HexColor('#cbdd33')))),
              child: BottomNavigationBar(
                selectedItemColor: HexColor('#F5841F'),
                unselectedItemColor: HexColor('#ffffff'),
                backgroundColor: HexColor('#742B90'),
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat_sharp), label: 'Chats'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
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
