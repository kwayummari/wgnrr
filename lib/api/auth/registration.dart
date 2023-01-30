import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/authentication/login.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/provider/shared_data.dart';

class registeringAuth {
  Future Registering(BuildContext context, String username, String password,
      String control_password, String newdate, String gender, String phone, String fullname,language) async {
    if (password.toString() == control_password.toString()) {
      const url = '${murl}authentication/registration.php';
      var response = await http.post(Uri.parse(url), body: {
        "username": username.toString(),
        "age": newdate.toString(),
        "gender": gender.toString(),
        "phone": phone.toString,
        "password": password.toString,
        "fullname": fullname.toString,
      });
      var data = jsonDecode(response.body);

      if (data == "success") {
        await done(context);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
        Fluttertoast.showToast(
          msg: language == 'Kiswahili'
              ? 'Umefanikiwa kujisajili'
              : 'Registered Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0,
        );
      } else if (data == "username") {
        await done(context);
        Fluttertoast.showToast(
          msg: language == 'Kiswahili'
              ? 'Jina limeshachukuliwa'
              : 'Username already exists',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0,
        );
      } else if (data == "phone") {
        await done(context);
        Fluttertoast.showToast(
          msg: language == 'Kiswahili'
              ? 'Namba ya simu imeshachukuliwa'
              : 'Phone number already exists',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0,
        );
      }
    } else {
     await done(context);
      Fluttertoast.showToast(
        msg: language == 'Kiswahili'
            ? 'Nywila hazianani'
            : 'Passwords do not match',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15.0,
      );
    }
  }

  done(BuildContext context) async {
    await Future.delayed(Duration(seconds: 5), () {
      final isloading = Provider.of<SharedData>(context, listen: false);
                isloading.isLoading = false;
    });
  }
  
}
