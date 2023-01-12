// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/health_care_provider/chats/chat_room/chats.dart';

class list_chats extends StatefulWidget {
  const list_chats({super.key});

  @override
  State<list_chats> createState() => _list_chatsState();
}

class _list_chatsState extends State<list_chats> {
  var chat;
  List chats = [];

  Future get_chats() async {
    const url = '${murl}chats/chats_hcp.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "username": username.toString(),
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
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var u = sharedPreferences.get('username');
    var s = sharedPreferences.get('status');
    var b = sharedPreferences.get('bot');
    setState(() {
      username = u;
      status = s;
      bot = b;
    });
    get_chats();
  }

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
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Chats(
                      client: chats[index]['client'],
                      doctor: chats[index]['doctor'],
                    )));
          },
          child: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              border: Border.all(color: HexColor('#742B90')),
            ),
            child: ListTile(
              title: Text(chats[index]['client']),
            ),
          ),
        );
      },
      itemCount: chats == null ? 0 : chats.length,
    );
  }
}
