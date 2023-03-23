// ignore_for_file: prefer_const_constructors, prefer_if_null_operators, prefer_typing_uninitialized_variables, must_be_immutable, unused_local_variable, unused_element, prefer_const_constructors_in_immutables, body_might_complete_normally_nullable, use_function_type_syntax_for_parameters, non_constant_identifier_names, empty_constructor_bodies, prefer_equal_for_default_values, unnecessary_this, unnecessary_string_interpolations, depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:wgnrr/api/auth/login.dart';
import 'package:wgnrr/authentication/registration.dart';
import 'package:wgnrr/provider/shared_data.dart';
import 'package:wgnrr/utils/widget/bottombar/bottombar.dart';
import 'package:wgnrr/utils/widget/button/button.dart';
import 'package:wgnrr/utils/widget/text/text.dart';
import 'package:wgnrr/utils/widget/textformfield/textformfield.dart';

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
      bottomNavigationBar: AppBottombar(),
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
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Image.asset(
                      'assets/logo3.png',
                      height: 30,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  AppText(txt: 'WGNRR ', color: HexColor('#ffffff'), size: 16),
                  AppText(
                    txt: 'AFRICA',
                    size: 16,
                    color: HexColor('#ffffff'),
                    weight: FontWeight.w700,
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  height: 55,
                  width: 340,
                  child: AppTextformfield(
                    obscure: false,
                    label: language == 'Kiswahili' ? 'Jina' : 'Username',
                    textfieldcontroller: username,
                    icon: Icon(
                      Icons.person_pin,
                      color: Colors.black,
                    ), language: language,
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 55,
                  width: 340,
                  child: AppTextformfield(
                    textfieldcontroller: password,
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    label: language == 'Kiswahili' ? 'Nywila' : 'Password',
                    obscure: dont_show_password,
                    suffixicon: IconButton(
                        onPressed: (() {
                          setState(() {
                            dont_show_password = !dont_show_password;
                          });
                        }),
                        icon: Icon(Icons.remove_red_eye)), language: language,
                  )),
              SizedBox(
                height: 15,
              ),
              isloading.isLoading
                  ? SpinKitCircle(
                      // duration: const Duration(seconds: 3),
                      // size: 100,
                      color: HexColor('#F5841F'),
                    )
                  : Container(
                      height: 50,
                      width: 340,
                      child: AppButton(
                        label: language == 'Kiswahili' ? 'Ingia' : 'Sign In',
                        onPress: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          isloading.isLoading = true;
                          loginAuth().login(context, username.text.toString(),
                              password.text.toString(), language.toString());
                        },
                      ),
                    ),
              // SizedBox(
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: Colors.black,
              //         borderRadius: BorderRadius.circular(25.0),
              //       ),
              //       height: 50,
              //       width: 340,
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           elevation: 5,
              //           foregroundColor: HexColor('#F5841F'),
              //           backgroundColor: HexColor('#F5841F'),
              //           textStyle:
              //               GoogleFonts.vesperLibre(color: Colors.white),
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(0),
              //               side: BorderSide(color: Colors.black)),
              //         ),
              //         onPressed: () async {
              //           if (!_formKey.currentState!.validate()) {
              //             return;
              //           }
              //           isloading.isLoading = true;
              //           loginAuth().login(context, username.text.toString(),
              //               password.text.toString(), language.toString());
              //         },
              //         child: Text(
              //           language == 'Kiswahili' ? 'Ingia' : 'Sign In',
              //           style: GoogleFonts.vesperLibre(
              //             color: Colors.white,
              //             fontSize: 25,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              SizedBox(
                height: 15,
              ),
              // InkWell(
              //     child: Text(
              //         language == 'Kiswahili'
              //             ? 'Mwanachama Mpya ? Jisajili'
              //             : 'New user ? Signup now',
              //         style: GoogleFonts.vesperLibre(color: Colors.white)),
              //     onTap: () {
              //       Navigator.of(context).pushReplacement(
              //           MaterialPageRoute(builder: (context) => Register('')));
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
