import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

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
  update();
  }
  List updates = [];
  Future update() async {
    http.Response response;
    const url = '${murl}version/get.php';
    var response1 = await http.get(Uri.parse(url));
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          updates = json.decode(response1.body);
        });
    }
  }

  TextEditingController question = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: updates.isNotEmpty ? AppDrawer(
        username: username,
        language: language,
        status: status, update: updates[0]['version'],
      ) : null,
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
        title: AppText(
            txt: language == 'Kiswahili'
                ? 'Karibu ${username}'
                : 'Welcome ${username}',
                size: 15,
                color: Colors.white,
                weight: FontWeight.w500,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppText(
                  txt: 'SUGGESTION SECTION',
                  size: 20,
                  weight: FontWeight.w700,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 35, right: 35, top: 8, bottom: 8),
                  child: Center(
                    child: AppText(
                      txt: 'Your Ideas, Questions and Feedback are Greatly Appreciated',
                      color: Colors.black,
                      size: 15,
                      weight: FontWeight.w400,
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
                      style: TextStyle(
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
                        hintStyle: TextStyle(
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
