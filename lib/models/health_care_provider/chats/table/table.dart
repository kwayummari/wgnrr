// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wgnrr/models/health_care_provider/chats/table/list_chats.dart';

class Chat_table extends StatefulWidget {
  const Chat_table({super.key});

  @override
  State<Chat_table> createState() => _Chat_tableState();
}

class _Chat_tableState extends State<Chat_table> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 90,
          backgroundColor: HexColor('#742B90'),
          title: Row(
            children: [
              Center(
                child: Container(
                    width: size.width / 1.4,
                    child: Text(
                      'Chats',
                      style: GoogleFonts.vesperLibre(color: Colors.white),
                    )),
              ),
              SizedBox(
                width: 35,
              ),
              SizedBox(
                width: 4,
              ),
            ],
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