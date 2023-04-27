import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/home.dart';
import 'package:wgnrr/models/health_care_provider/home.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class updatePasswordDoctor extends StatefulWidget {
  var username;
  var status;
  updatePasswordDoctor({Key? key, required this.status, required this.username})
      : super(key: key);

  @override
  State<updatePasswordDoctor> createState() => _updatePasswordDoctorState();
}

class _updatePasswordDoctorState extends State<updatePasswordDoctor> {
  var language;
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var u = sharedPreferences.get('username');
    var s = sharedPreferences.get('status');
    var b = sharedPreferences.get('bot');
    var l = sharedPreferences.get('language');
    setState(() {
      language = l;
      get_userdata();
    });
  }

  var user;
  List users = [];

  Future get_userdata() async {
    const url = '${murl}user/user.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "user": widget.username.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          users = json.decode(response1.body);
        });
    }
  }

  Future changeUsername() async {
    const url = '${murl}user/changePasswordDoctor.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "newpassword": newpassword.text,
      "username": widget.username.toString(),
    });
    if (response1.statusCode == 200) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', widget.username.toString());
      sharedPreferences.setString('status', '${widget.status}');
      Fluttertoast.showToast(
        msg: language == 'Kiswahili'
            ? 'Umefanikiwa Kuingia'
            : 'Login Succefully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Homepage_hcp('')));
    }
  }

  TextEditingController oldpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  bool check = true;
  bool checknew = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 25, right: 9),
              child: GestureDetector(
                onTap: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  } else {
                    changeUsername();
                  }
                },
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
            txt: 'Update password',
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
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: newpassword,
                  cursorColor: Theme.of(context).iconTheme.color,
                  obscureText: checknew,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: Container(
                      color: Colors.white,
                      child: AppText(
                        txt:
                            language == 'Kiswahili' ? 'Nywila' : 'New Password',
                        size: 15,
                        color: Colors.black,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: HexColor('#000000')),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: HexColor('#000000')),
                    ),
                    suffixIcon: IconButton(
                        onPressed: (() {
                          setState(() {
                            checknew = !checknew;
                          });
                        }),
                        icon: Icon(Icons.remove_red_eye)),
                    prefixIconColor: Colors.black,
                  ),
                  validator: (value) {
                    RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$');
                    if (value!.isEmpty) {
                      return null;
                    } else if (!regex.hasMatch(value)) {
                      return language == 'Kiswahili'
                          ? 'Nywila inatakiwa \n -iwe na herufi kubwa moja \n -iwe na herufi ndogo moja \n -iwe na namba moja \n -iwe na herufi maalumu \n -iwe na urefu wa herufi kuanzia 8'
                          : 'Password should contain \n -at least one upper case \n -at least one lower case \n -at least one digit \n -at least one Special character \n -Must be at least 8 characters in length';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
