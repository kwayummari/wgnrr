// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/appointment/resultcard.dart';

class list_postporcedures extends StatefulWidget {
  const list_postporcedures({super.key});

  @override
  State<list_postporcedures> createState() => _list_postporceduresState();
}

class _list_postporceduresState extends State<list_postporcedures> {
  var chat;
  List chats = [];

  Future get_chats() async {
    const url = '${murl}appointment/results.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "client": username.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          chats = json.decode(response1.body);
        });
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  done() async {
    await Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

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
    });
    get_chats();
  }

  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  TextEditingController comments = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return PatientResultsCard(
          doctor: chats[index]['doctor'],
          blood: chats[index]['blood'],
          pain: chats[index]['pain'],
          fever: chats[index]['fever'],
          smell: chats[index]['smell'],
          client: username,
          procedure: chats[index]['procedure'],
          questionare: chats[index]['questionare'],
          timeline: chats[index]['timeline'],
        );
      },
      itemCount: chats == null ? 0 : chats.length,
    );
  }
}
