// ignore_for_file: prefer_const_constructors, prefer_if_null_operators, prefer_typing_uninitialized_variables, must_be_immutable, unused_local_variable, unused_element, prefer_const_constructors_in_immutables, body_might_complete_normally_nullable, use_function_type_syntax_for_parameters, non_constant_identifier_names, empty_constructor_bodies, prefer_equal_for_default_values, unnecessary_this, unnecessary_string_interpolations, depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/authentication/registration.dart';
import 'package:wgnrr/models/client/home.dart';
import 'package:wgnrr/models/health_care_provider/home.dart';

class Login extends StatefulWidget {
  Login({
    Key? key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future login() async {
    const url = '${murl}authentication/login.php';
    var response = await http.post(Uri.parse(url), body: {
      "username": username.text,
      "password": password.text,
    });
    var data = jsonDecode(response.body);

    if (data == "Client" ||
        data == 'admin' ||
        data == 'Community Based Mobilizers') {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', username.text);
      sharedPreferences.setString('status', 'Client');
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
          MaterialPageRoute(builder: (context) => Homepage('')));
    } else if (data == "Health Care Providers") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Homepage_hcp('')));
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', username.text);
      sharedPreferences.setString('status', 'Health Care Providers');
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
    } else if (data == "wrong") {
      await done();
      Fluttertoast.showToast(
        msg: language == 'Kiswahili'
            ? 'Umekosea Jina au Nywila'
            : 'Invalid Username or Password',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    }
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  done() async {
    await Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  var language;
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var l = sharedPreferences.get('language');
    setState(() {
      language = l;
    });
  }

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  bool dont_show_password = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor('#742B90'),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                  width: size.width,
                  child: Image.asset(
                    'assets/login.png',
                    // height: 200,
                  )),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 55,
                width: 340,
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: username,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: language == 'Kiswahili' ? 'Jina' : 'Username',
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
                    prefixIcon: Icon(
                      Icons.person_pin,
                      color: Colors.black,
                    ),
                    prefixIconColor: Colors.black,
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else if (value.isEmpty) {
                      return 'Username is Empty';
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                width: 340,
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: password,
                  obscureText: dont_show_password,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    hintText: language == 'Kiswahili' ? 'Nywila' : 'Password',
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
                    suffixIcon: IconButton(
                        onPressed: (() {
                          setState(() {
                            dont_show_password = !dont_show_password;
                          });
                        }),
                        icon: Icon(Icons.remove_red_eye)),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    prefixIconColor: Colors.black,
                  ),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else if (value.isEmpty) {
                      return 'Password is Empty';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50, top: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      child: Text(
                        language == 'Kiswahili'
                            ? 'Umesahau Nywila'
                            : 'Forgot Password?',
                        style: TextStyle(color: HexColor('#F5841F')),
                      ),
                      onTap: () {
                        //               Navigator.of(context).push(
                        // MaterialPageRoute(builder: (context) => Change('')));
                      }),
                ),
              ),
              SizedBox(
                height: 15,
              ),
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
                          onPressed: () async{
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            login();
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
              SizedBox(
                height: 15,
              ),
              InkWell(
                  child: Text(
                      language == 'Kiswahili'
                          ? 'Mwanachama Mpya ? Jisajili'
                          : 'New user ? Signup now',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Register('')));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
