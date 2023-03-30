import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/widget/text/text.dart';
import 'package:wgnrr/utils/widget/textformfield/textformfield.dart';

class changePhonenumber extends StatefulWidget {
  var phone;
  changePhonenumber({super.key, required this.phone});

  @override
  State<changePhonenumber> createState() => _changePhonenumberState();
}

class _changePhonenumberState extends State<changePhonenumber> {
  var username;
  var status;
  var bot;
  var language;
  var oldusername;
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
      oldusername = u;
      get_userdata();
    });
  }

  var user;
  List users = [];

  Future get_userdata() async {
    const url = '${murl}user/user.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "user": username.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          users = json.decode(response1.body);
        });
    }
  }

  Future changeUsername() async {
    const url = '${murl}user/phone.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "newphone": newphone.text,
      "id": users[0]['id'].toString(),
    });
    if (response1.statusCode == 200) {
      Navigator.pop(context);
    }
  }

  TextEditingController newphone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 25, left: 9),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: AppText(
              txt: 'Cancel',
              size: 15,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 25, right: 9),
            child: GestureDetector(
              onTap: () => changeUsername(),
              child: AppText(
                txt: 'Done',
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
        shape: Border(bottom: BorderSide(color: Colors.orange, width: 0.2)),
        elevation: 4,
        toolbarHeight: 70,
        backgroundColor: HexColor('#742B90'),
        title: AppText(
          txt: 'Update phone',
          size: 15,
          weight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  txt: 'Current',
                  size: 15,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(txt: widget.phone, size: 15)),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText(
                  txt: 'New',
                  size: 15,
                  weight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                  key: _formKey,
                  child: AppTextformfield(
                      textfieldcontroller: newphone,
                      language: language,
                      label: 'Phone number',
                      obscure: false))
            ],
          ),
        ),
      ),
    );
  }
}
