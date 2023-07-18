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
  List types1 = ['MASWALI YA KAWAIDA', 'Malalamiko', 'Sifa'];

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
      drawer: updates.isNotEmpty
          ? AppDrawer(
              username: username,
              language: language,
              status: status,
              update: updates[0]['version'],
            )
          : null,
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
          weight: FontWeight.w500,
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
                      txt: language == 'Kiswahili'
                          ? 'Mawazo yako, Maswali na Maoni yako yanathaminiwa sana.'
                          : 'Your Ideas, Questions and Feedback are Greatly Appreciated',
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
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                      contentPadding: EdgeInsets.only(
                          top: 5.0, left: 15.0, right: 15.0, bottom: 5.0),
                    ),
                    hint: AppText(
                      txt: language == 'Kiswahili'
                          ? 'Aina ya Maoni'
                          : 'Feedback type',
                      size: 15,
                      color: Colors.black,
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
                    items: language == 'Kiswahili'
                        ? types1.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: AppText(
                                txt: valueItem != null
                                    ? valueItem
                                    : 'default value',
                                color: Colors.black,
                                size: 15,
                              ),
                            );
                          }).toList()
                        : types.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: AppText(
                                txt: valueItem != null
                                    ? valueItem
                                    : 'default value',
                                color: Colors.black,
                                size: 15,
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
                    style: TextStyle(
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
