// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/models/client/chats/bot/bot.dart';
import 'package:wgnrr/models/client/chats/table/list_chats.dart';
import 'package:wgnrr/models/client/home.dart';

import '../../../../utils/routes/language.dart';

enum MenuItem {
  item1,
  item2,
  item3,
  item4,
  item5
}

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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 90,
          backgroundColor: HexColor('#742B90'),
          title: Row(
            children: [
              PopupMenuButton(
                  color: HexColor('#742B90'),
                  onSelected: (value) async {
                    if (value == MenuItem.item3) {
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.remove('username');
                      sharedPreferences.remove('status');
                      sharedPreferences.remove('bot');
                      sharedPreferences.remove('language');
                      Navigator.of(context).pushAndRemoveUntil(
                          // the new route
                          MaterialPageRoute(
                            builder: (BuildContext context) => Language(),
                          ),
                          (Route route) => false);
                    } else if (value == MenuItem.item5) {
                      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Homepage('')));
                    }
                  },
                  position: PopupMenuPosition.under,
                  child: Icon(
                    Icons.menu,
                    color: HexColor('#ffffff'),
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: MenuItem.item1,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                      username == null
                                          ? ''
                                          : username.toString(),
                                      style: GoogleFonts.rajdhani(
                                          fontSize: 15,
                                          color: HexColor('#ffffff'),
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: 30,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: MenuItem.item2,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.library_books,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(status.toString(),
                                      style: GoogleFonts.rajdhani(
                                          fontSize: 15,
                                          color: HexColor('#ffffff'),
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: 30,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: MenuItem.item3,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                      language == 'Kiswahili'
                                          ? 'Toka'
                                          : 'Sign Out!',
                                      style: GoogleFonts.rajdhani(
                                          fontSize: 15,
                                          color: HexColor('#ffffff'),
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: 30,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: MenuItem.item5,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.home,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text('Home',
                                      style: GoogleFonts.rajdhani(
                                          fontSize: 15,
                                          color: HexColor('#ffffff'),
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: 30,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ]),
              Spacer(),
              Center(
                child: Container(
                    width: size.width / 1.4,
                    child: Text(
                      language == 'Kiswahili' ? 'Mazungumzo' : 'Chats',
                      style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    )),
              ),
              Spacer(),
              CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    color: HexColor('#F5841F'),
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => Bot()));
                    },
                  )),
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
