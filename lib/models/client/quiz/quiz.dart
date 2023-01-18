import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
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

  Future send() async {
    const url = '${murl}question/question.php';
    var response = await http.post(Uri.parse(url), body: {
      "question": question.text,
      "username": username.toString(),
    });
    if (response.statusCode == 200) {
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'SUGGESTION SECTION',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 35, right: 35, top: 8, bottom: 8),
                  child: Center(
                    child: Text(
                      'Your Ideas, Questions and Feedback are Greatly Appreciated',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Scrollbar(
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    elevation: 3,
                    child: TextFormField(
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: question,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('#742B90')),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        fillColor: Colors.white,
                        hoverColor: HexColor('#742B90'),
                        focusColor: HexColor('#742B90'),
                        hintText: 'Message',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 5.0, left: 15.0, right: 15.0, bottom: 5.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                isLoading
                    ? SpinKitCircle(
                        // duration: const Duration(seconds: 3),
                        // size: 100,
                        color: HexColor('#F5841F'),
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
                              elevation: 5,
                              foregroundColor: HexColor('#F5841F'),
                              backgroundColor: HexColor('#F5841F'),
                              textStyle: TextStyle(color: Colors.white),
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
                            child: Text(
                              language == 'Kiswahili' ? 'Ingia' : 'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
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
