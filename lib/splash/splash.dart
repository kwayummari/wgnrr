// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wgnrr/authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/models/client/home.dart';
import 'package:wgnrr/models/health_care_provider/home.dart';
import 'package:wgnrr/utils/routes/language.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatortohome();
  }

  var username;
  var status;
  var language;
  _navigatortohome() async {
    await getValidationData().whenComplete(() async {
      await Future.delayed(Duration(seconds: 1), () {});
      if (language == null && username == null && status == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Language()));
      } else if (username == null && language != null && status == null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      } else if (username != null && (status == 'client' || status == 'Community Based Mobilizers' || status == 'admin' || status == 'super-admin') && language != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Homepage('')));
      } else if (username != null &&
          status == 'Health Care Providers' &&
          language != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Homepage_hcp('')));
      }
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var u = sharedPreferences.get('username');
    var l = sharedPreferences.get('language');
    var s = sharedPreferences.get('status');
    setState(() {
      language = l;
      username = u;
      status = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#ffffff'),
      body: Center(
          child: SpinKitCircle(
        // duration: const Duration(seconds: 3),
        size: 70,
        color: HexColor('#742B90'),
      )),
    );
  }
}
