import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/routes/language.dart';

enum MenuItem {
  item1,
  item2,
  item3,
  item4,
}

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
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
      // get_datas();
    });
  }

  @override
  void initState() {
    super.initState();
    getValidationData();
  }
  TextEditingController question = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: Border(bottom: BorderSide(color: Colors.orange, width: 0.2)),
        elevation: 4,
        toolbarHeight: 70,
        backgroundColor: HexColor('#742B90'),
        title: Row(
          children: [
            SizedBox(
              width: 15,
            ),
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
                  } else if (value == MenuItem.item4) {
                    // _callNumber();
                  } else if (value == MenuItem.item2) {
                    Navigator.pop(context);
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
                                username == null ? '' : username.toString() + ' - ' + status.toString(),
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
                              Icons.home_filled,
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
                  PopupMenuItem(
                    value: MenuItem.item4,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 15,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text('Contact us',
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
                ]),
            Spacer(),
            Text(username == null ? '' : username,
                style: GoogleFonts.rajdhani(
                    fontSize: 15,
                    color: HexColor('#ffffff'),
                    fontWeight: FontWeight.w500)),
            Spacer(),
          ],
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Card(
            // borderOnForeground: ,
            color: Colors.white,
            shadowColor: Colors.grey,
            elevation: 3,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: 55,
                    width: 340,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: question,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: language == 'Kiswahili' ? 'Swali' : 'Question',
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: BorderSide(color: HexColor('#000000')),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: BorderSide(color: HexColor('#000000')),
                        ),
                        prefixIconColor: Colors.black,
                      ),
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        } else if (value.isEmpty) {
                          return 'Username is Empty';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
