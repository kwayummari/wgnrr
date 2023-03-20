import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/widget/text/text.dart';
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

  var type;
  List types = [
    'FAQ\'s',
    'COMPLAINTS',
    'COMPLEMENTS',
  ];

  Future send() async {
    const url = '${murl}question/question.php';
    var response = await http.post(Uri.parse(url), body: {
      "question": question.text,
      "username": username.toString(),
      "type": type.toString()
    });
    if (response.statusCode == 200) {
      print(type);
      Fluttertoast.showToast(
        msg: language == 'Kiswahili'
            ? 'Asante Kwa Maoni'
            : 'Thankyou for the feedback',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
      Navigator.pop(context);
    }
  }

  bool isLoading = false;

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
                                    username == null
                                        ? ''
                                        : username.toString() +
                                            ' - ' +
                                            status.toString(),
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
            AppText(
              txt: 'Feedback SECTION'.toUpperCase(),
              weight: FontWeight.w700,
              color: Colors.white,
              size: 20,
            ),
            Spacer()
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 35, right: 35, top: 8, bottom: 8),
                  child: Center(
                    child: AppText(
                      txt:
                          'Your Ideas, Questions and Feedback are Greatly Appreciated',
                      size: 15,
                      color: Colors.black,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 27, right: 27),
                  child: DropdownButtonFormField(
                    elevation: 10,
                    menuMaxHeight: 350,
                    isExpanded: true,
                    focusColor: Colors.white,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hoverColor: HexColor('#742B90'),
                      focusColor: HexColor('#742B90'),
                      hintText: 'Message',
                      hintStyle: GoogleFonts.vesperLibre(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                      contentPadding: EdgeInsets.only(
                          top: 5.0, left: 15.0, right: 15.0, bottom: 5.0),
                    ),
                    hint: Text(
                      language == 'Kiswahili'
                          ? 'Aina ya Maoni'
                          : 'Feedback type',
                      style: GoogleFonts.vesperLibre(
                          fontSize: 15, color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return language == 'Kiswahili'
                            ? 'Chagua'
                            : "Please select";
                      } else {
                        return null;
                      }
                    },
                    value: type,
                    onChanged: (newValue1) {
                      setState(() {
                        type = newValue1;
                      });
                    },
                    items: types.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(
                          valueItem != null ? valueItem : 'default value',
                          style: GoogleFonts.vesperLibre(
                              color: Colors.black, fontSize: 15),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  width: 340,
                  child: TextFormField(
                    style: GoogleFonts.vesperLibre(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: question,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hoverColor: HexColor('#742B90'),
                      focusColor: HexColor('#742B90'),
                      hintText: 'Message',
                      hintStyle: GoogleFonts.vesperLibre(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                      contentPadding: EdgeInsets.only(
                          top: 5.0, left: 15.0, right: 15.0, bottom: 5.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                isLoading
                    ? SpinKitCircle(
                        color: HexColor('#742B90'),
                      )
                    : SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          height: 50,
                          width: 340,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: HexColor('#742B90'),
                              backgroundColor: HexColor('#742B90'),
                              textStyle:
                                  GoogleFonts.vesperLibre(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  side: BorderSide(color: Colors.black)),
                            ),
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              setState(() {
                                isLoading = true;
                              });
                              send();
                            },
                            child: AppText(
                              txt: language == 'Kiswahili' ? 'Tuma' : 'Send',
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
