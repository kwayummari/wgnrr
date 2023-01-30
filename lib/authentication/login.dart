// ignore_for_file: prefer_const_constructors, prefer_if_null_operators, prefer_typing_uninitialized_variables, must_be_immutable, unused_local_variable, unused_element, prefer_const_constructors_in_immutables, body_might_complete_normally_nullable, use_function_type_syntax_for_parameters, non_constant_identifier_names, empty_constructor_bodies, prefer_equal_for_default_values, unnecessary_this, unnecessary_string_interpolations, depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:wgnrr/api/auth/login.dart';
import 'package:wgnrr/authentication/registration.dart';
import 'package:wgnrr/provider/shared_data.dart';

class Login extends StatefulWidget {
  Login({
    Key? key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var language;

  @override
  void initState() {
    super.initState();
    language = loginAuth().getValidationData();
  }

  bool dont_show_password = true;

  @override
  Widget build(BuildContext context) {
    final isloading = Provider.of<SharedData>(context);
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
                  style: GoogleFonts.vesperLibre(color: Colors.black),
                  controller: username,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: language == 'Kiswahili' ? 'Jina' : 'Username',
                    hintStyle: GoogleFonts.vesperLibre(color: Colors.black),
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
                  style: GoogleFonts.vesperLibre(color: Colors.black),
                  controller: password,
                  obscureText: dont_show_password,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    hintText: language == 'Kiswahili' ? 'Nywila' : 'Password',
                    hintStyle: GoogleFonts.vesperLibre(color: Colors.black),
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
                        style:
                            GoogleFonts.vesperLibre(color: HexColor('#F5841F')),
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
              isloading.isLoading
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
                            isloading.isLoading = true;
                            loginAuth().login(context, username.text.toString(),
                                password.text.toString(), language.toString());
                          },
                          child: Text(
                            language == 'Kiswahili' ? 'Ingia' : 'Sign In',
                            style: GoogleFonts.vesperLibre(
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
                      style: GoogleFonts.vesperLibre(color: Colors.white)),
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
