// // ignore_for_file: prefer_const_constructors, prefer_if_null_operators, prefer_typing_uninitialized_variables, must_be_immutable, unused_local_variable, unused_element, prefer_const_constructors_in_immutables, body_might_complete_normally_nullable, depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wgnrr/api/auth/login.dart';
// import 'package:wgnrr/api/auth/registration.dart';
// import 'package:wgnrr/authentication/login.dart';
// import 'package:wgnrr/provider/date_picker_provider.dart';
// import 'package:wgnrr/provider/shared_data.dart';

// class Register extends StatefulWidget {
//   Register(
//     String s, {
//     Key? key,
//   }) : super(key: key);

//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   TextEditingController username = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController control_password = TextEditingController();
//   TextEditingController fullname = TextEditingController();
//   bool isLoading = false;

//   var gender;
//   List genders = [
//     'Male',
//     'Female',
//   ];

//  var language;
//   Future getValidationData() async {
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     var l = sharedPreferences.get('language');
//     setState(() {
//       language = l;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getValidationData();
//   }

//   bool dont_show_password = true;

//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final isloading = Provider.of<SharedData>(context);
//     final newdate = Provider.of<SharedDate>(context);
//     return Scaffold(
//       backgroundColor: HexColor('#742B90'),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 55,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 130, left: 15),
//                     child: Text(
//                       language == 'Kiswahili' ? 'JISAJILI' : 'REGISTER',
//                       style: GoogleFonts.vesperLibre(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w900,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 00),
//                     child: InkWell(
//                       child: Text(
//                         language == 'Kiswahili'
//                             ? 'Teali mtumiaji ? Ingia'
//                             : 'Already a user ? Sign In',
//                         style: GoogleFonts.vesperLibre(
//                           color: HexColor('#F5841F'),
//                           fontSize: 13,
//                         ),
//                       ),
//                       onTap: () {
//                         Navigator.of(context).pushReplacement(
//                             MaterialPageRoute(builder: (context) => Login()));
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Center(
//                   child: Text(
//                 language == 'Kiswahili' ? 'Karibu' : 'Welcome!',
//                 style: GoogleFonts.vesperLibre(color: Colors.white),
//               )),
//               Center(
//                   child: Text(
//                       language == 'Kiswahili'
//                           ? 'Tafadhali jaza fomu ujisajili'
//                           : 'Please fill this form to create an account',
//                       style: GoogleFonts.vesperLibre(color: Colors.white))),
//               Padding(
//                 padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
//                 child: TextFormField(
//                   style: GoogleFonts.vesperLibre(
//                       color: Theme.of(context).iconTheme.color),
//                   controller: fullname,
//                   cursorColor: Theme.of(context).iconTheme.color,
//                   decoration: InputDecoration(
//                     errorStyle: GoogleFonts.vesperLibre(color: Colors.white),
//                     hintText:
//                         language == 'Kiswahili' ? 'Jina Kamili' : 'Fullname',
//                     hintStyle: GoogleFonts.vesperLibre(color: Colors.black),
//                     filled: true,
//                     fillColor: Colors.white,
//                     disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(0.0),
//                       borderSide: BorderSide(color: HexColor('#000000')),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(0.0),
//                       borderSide: BorderSide(color: HexColor('#000000')),
//                     ),
//                     prefixIcon: Icon(
//                       Icons.person_pin,
//                       color: Colors.black,
//                     ),
//                     prefixIconColor: Colors.black,
//                   ),
//                   validator: (value) {
//                     if (value!.isNotEmpty) {
//                       return null;
//                     } else if (value.isEmpty) {
//                       return language == 'Kiswahili'
//                           ? 'Jaza jina'
//                           : 'Username is Empty';
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 40, right: 40),
//                 child: TextFormField(
//                   style: GoogleFonts.vesperLibre(
//                       color: Theme.of(context).iconTheme.color),
//                   controller: username,
//                   cursorColor: Theme.of(context).iconTheme.color,
//                   decoration: InputDecoration(
//                     errorStyle: GoogleFonts.vesperLibre(color: Colors.white),
//                     hintText:
//                         language == 'Kiswahili' ? 'Jina la Utani' : 'Nickname',
//                     hintStyle: GoogleFonts.vesperLibre(color: Colors.black),
//                     filled: true,
//                     fillColor: Colors.white,
//                     disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(0.0),
//                       borderSide: BorderSide(color: HexColor('#000000')),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(0.0),
//                       borderSide: BorderSide(color: HexColor('#000000')),
//                     ),
//                     prefixIcon: Icon(
//                       Icons.person_pin,
//                       color: Colors.black,
//                     ),
//                     prefixIconColor: Colors.black,
//                   ),
//                   validator: (value) {
//                     if (value!.isNotEmpty) {
//                       return null;
//                     } else if (value.isEmpty) {
//                       return language == 'Kiswahili'
//                           ? 'Jaza jina'
//                           : 'Username is Empty';
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               InkWell(
//                 onTap: () => SharedDate().selectDate(context),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 40, right: 40),
//                   child: TextFormField(
//                     style: GoogleFonts.vesperLibre(color: HexColor('#742B90')),
//                     enabled: false,
//                     cursorColor: Theme.of(context).iconTheme.color,
//                     decoration: InputDecoration(
//                       errorStyle: GoogleFonts.vesperLibre(color: Colors.white),
//                       border: InputBorder.none,
//                       hintText: newdate.date == null
//                           ? language == 'Kiswahili'
//                               ? 'Chagua mwaka wa kuzaliwa'
//                               : 'Select date of birth'
//                           : newdate.date,
//                       hintStyle: GoogleFonts.vesperLibre(color: Colors.black),
//                       filled: true,
//                       fillColor: Colors.white,
//                       disabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(0.0),
//                         borderSide: BorderSide(color: HexColor('#000000')),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(0.0),
//                         borderSide: BorderSide(color: HexColor('#000000')),
//                       ),
//                       prefixIcon: Icon(
//                         Icons.calendar_month,
//                         color: Colors.black,
//                       ),
//                       prefixIconColor: Colors.black,
//                     ),
//                     validator: (newdate) {
//                       // if (newdate!.isNotEmpty) {
//                       //   return null;
//                       // } else if (newdate.isEmpty) {
//                       //   return language == 'Kiswahili'
//                       //       ? 'Mwaka haujajazwa'
//                       //       : 'Date is Empty';
//                       // }
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 40, right: 40),
//                 child: DropdownButtonFormField(
//                   elevation: 10,
//                   menuMaxHeight: 330,
//                   isExpanded: true,
//                   focusColor: Colors.white,
//                   style: GoogleFonts.vesperLibre(
//                       color: Colors.black, fontSize: 22),
//                   decoration: InputDecoration(
//                     errorStyle: GoogleFonts.vesperLibre(color: Colors.white),
//                     border: InputBorder.none,
//                     hintStyle: GoogleFonts.vesperLibre(color: Colors.black),
//                     filled: true,
//                     fillColor: Colors.white,
//                     disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(0.0),
//                       borderSide: BorderSide(color: HexColor('#000000')),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(0.0),
//                       borderSide: BorderSide(color: HexColor('#000000')),
//                     ),
//                     prefixIcon: Icon(
//                       Icons.male,
//                       color: Colors.black,
//                     ),
//                     prefixIconColor: Colors.black,
//                   ),
//                   hint: Text(
//                     language == 'Kiswahili' ? 'Jinsia' : 'Gender',
//                     style: GoogleFonts.vesperLibre(
//                         fontSize: 15, color: Colors.black),
//                   ),
//                   validator: (value) {
//                     if (value == null) {
//                       return language == 'Kiswahili'
//                           ? 'Chagua Jinsia'
//                           : "Please select Gender";
//                     } else {
//                       return null;
//                     }
//                   },
//                   value: gender,
//                   onChanged: (newValue1) {
//                     setState(() {
//                       gender = newValue1;
//                     });
//                   },
//                   items: genders.map((valueItem) {
//                     return DropdownMenuItem(
//                       value: valueItem,
//                       child: Text(
//                         valueItem != null ? valueItem : 'default value',
//                         style: GoogleFonts.vesperLibre(
//                             color: Colors.black, fontSize: 15),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 40, right: 40),
//                 child: TextFormField(
//                   keyboardType: TextInputType.phone,
//                   controller: phone,
//                   cursorColor: Theme.of(context).iconTheme.color,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText:
//                         language == 'Kiswahili' ? 'Namba ya simu' : 'Phone',
//                     filled: true,
//                     fillColor: Colors.white,
//                     disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(0.0),
//                       borderSide: BorderSide(color: HexColor('#000000')),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(0.0),
//                       borderSide: BorderSide(color: HexColor('#000000')),
//                     ),
//                     prefixIcon: Icon(
//                       Icons.phone_android,
//                       color: Colors.black,
//                     ),
//                     prefixIconColor: Colors.black,
//                   ),
//                   validator: (value) {
//                     String pattern = r'([0][6,7]\d{8})';
//                     RegExp regExp = new RegExp(pattern);
//                     if (value!.isEmpty) {
//                       return language == 'Kiswahili'
//                           ? 'Jaza namba ya simu'
//                           : 'Phone is Empty';
//                     } else if (value.length != 10) {
//                       return language == 'Kiswahili'
//                           ? 'Namba ya simu iwe na tarakimu 10'
//                           : 'Mobile Number must be of 10 digit';
//                     } else if (!regExp.hasMatch(value)) {
//                       return 'Please enter valid mobile number';
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 40, right: 40),
//                 child: TextFormField(
//                   style: GoogleFonts.vesperLibre(
//                       color: Theme.of(context).iconTheme.color),
//                   controller: password,
//                   cursorColor: Theme.of(context).iconTheme.color,
//                   obscureText: dont_show_password,
//                   obscuringCharacter: '*',
//                   decoration: InputDecoration(
//                     errorStyle: GoogleFonts.vesperLibre(color: Colors.white),
//                     border: InputBorder.none,
//                     hintText: language == 'Kiswahili' ? 'Nywila' : 'Password',
//                     hintStyle: GoogleFonts.vesperLibre(color: Colors.black),
//                     filled: true,
//                     fillColor: Colors.white,
//                     disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(0.0),
//                       borderSide: BorderSide(color: HexColor('#000000')),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(0.0),
//                       borderSide: BorderSide(color: HexColor('#000000')),
//                     ),
//                     prefixIcon: Icon(
//                       Icons.lock,
//                       color: Colors.black,
//                     ),
//                     suffixIcon: IconButton(
//                         onPressed: (() {
//                           setState(() {
//                             dont_show_password = !dont_show_password;
//                           });
//                         }),
//                         icon: Icon(Icons.remove_red_eye)),
//                     prefixIconColor: Colors.black,
//                   ),
//                   validator: (value) {
//                     RegExp regex = RegExp(
//                         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$');
//                     if (value!.isEmpty) {
//                       return null;
//                     } else if (!regex.hasMatch(value)) {
//                       return language == 'Kiswahili'
//                           ? 'Nywila inatakiwa \n -iwe na herufi kubwa moja \n -iwe na herufi ndogo moja \n -iwe na namba moja \n -iwe na herufi maalumu \n -iwe na urefu wa herufi kuanzia 8'
//                           : 'Password should contain \n -at least one upper case \n -at least one lower case \n -at least one digit \n -at least one Special character \n -Must be at least 8 characters in length';
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 40, right: 40),
//                 child: TextFormField(
//                   style: GoogleFonts.vesperLibre(
//                       color: Theme.of(context).iconTheme.color),
//                   controller: control_password,
//                   cursorColor: Theme.of(context).iconTheme.color,
//                   obscureText: dont_show_password,
//                   obscuringCharacter: '*',
//                   decoration: InputDecoration(
//                     errorStyle: GoogleFonts.vesperLibre(color: Colors.white),
//                     border: InputBorder.none,
//                     hintText: language == 'Kiswahili'
//                         ? 'Thibitisha nywila'
//                         : 'Confirm Password',
//                     hintStyle: GoogleFonts.vesperLibre(color: Colors.black),
//                     filled: true,
//                     fillColor: Colors.white,
//                     disabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(0.0),
//                       borderSide: BorderSide(color: HexColor('#000000')),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(0.0),
//                       borderSide: BorderSide(color: HexColor('#000000')),
//                     ),
//                     prefixIcon: Icon(
//                       Icons.lock,
//                       color: Colors.black,
//                     ),
//                     suffixIcon: IconButton(
//                         onPressed: (() {
//                           setState(() {
//                             dont_show_password = !dont_show_password;
//                           });
//                         }),
//                         icon: Icon(Icons.remove_red_eye)),
//                     prefixIconColor: Colors.black,
//                   ),
//                   validator: (value) {
//                     if (value!.isNotEmpty) {
//                       return null;
//                     } else if (value.isEmpty) {
//                       return language == 'Kiswahili'
//                           ? 'Jaza nywila'
//                           : 'Password is Empty';
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               isloading.isLoading
//                   ? SpinKitCircle(
//                       // duration: const Duration(seconds: 3),
//                       // size: 100,
//                       color: HexColor('#F5841F'),
//                     )
//                   : SizedBox(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25.0),
//                         ),
//                         height: 50,
//                         width: 340,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             elevation: 5,
//                             foregroundColor: HexColor('#F5841F'),
//                             backgroundColor: HexColor('#F5841F'),
//                             textStyle:
//                                 GoogleFonts.vesperLibre(color: Colors.white),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(0),
//                                 side: BorderSide(color: Colors.black)),
//                           ),
//                           onPressed: () {
//                             if (!_formKey.currentState!.validate()) {
//                               return;
//                             }
//                             isloading.isLoading = true;
//                             registeringAuth().Registering(
//                                 context,
//                                 username.text.toString(),
//                                 password.text.toString(),
//                                 control_password.text.toString(),
//                                 newdate.date.toString(),
//                                 gender.toString(),
//                                 phone.text.toString(),
//                                 fullname.text.toString(),
//                                 language.toString());
//                           },
//                           child: Text(
//                             language == 'Kiswahili' ? 'Jisajili' : 'Sign Up',
//                             style: GoogleFonts.vesperLibre(
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//               SizedBox(
//                 height: 50,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
