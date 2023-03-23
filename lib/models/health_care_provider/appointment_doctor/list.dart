// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/chats/chat_room/chats.dart';
import 'package:wgnrr/utils/widget/button/button.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class list_appointment_doctor extends StatefulWidget {
  const list_appointment_doctor({super.key});

  @override
  State<list_appointment_doctor> createState() =>
      _list_appointment_doctorState();
}

class _list_appointment_doctorState extends State<list_appointment_doctor> {
  var chat;
  List chats = [];

  Future get_chats() async {
    const url = '${murl}appointment/appointment-doctor.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "doctor": username.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          chats = json.decode(response1.body);
        });
    }
  }

  Future accept(id) async {
    const url = '${murl}appointment/update.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "id": id.toString(),
      "status": '1'.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          chats = json.decode(response1.body);
        });
    }
  }

  Future reject(id) async {
    const url = '${murl}appointment/update.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "id": id.toString(),
      "status": '2'.toString(),
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
                      client: username,
                      doctor: chats[index]['doctor'],
                    )));
          },
          child: Badge(
            backgroundColor: chats[index]['status'] == '0'
                ? Colors.orange.shade800
                : chats[index]['status'] == '1'
                    ? Colors.green
                    : Colors.red,
            label: AppText(
                txt: chats[index]['status'] == '0'
                    ? 'Pending'
                    : chats[index]['status'] == '1'
                        ? 'Accepted'
                        : 'Rejected',
                size: 15),
            child: Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                border: Border.all(color: HexColor('#742B90')),
              ),
              child: ListTile(
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: AppText(
                            txt:
                                chats[index]['client'].toString().toUpperCase(),
                            size: 15,
                            weight: FontWeight.w700,
                          )),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          txt: chats[index]['service'],
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: AppText(txt: chats[index]['reason'], size: 15),
                trailing: Column(
                  children: [
                    Container(
                      height: 20,
                      child: AppButton(
                        onPress: () => accept(chats[index]['id']),
                        label: 'Accept',
                        bcolor: Colors.green,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 20,
                      child: AppButton(
                        onPress: () => reject(chats[index]['id']),
                        label: 'Reject',
                        bcolor: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: chats == null ? 0 : chats.length,
    );
  }
}
