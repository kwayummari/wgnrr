// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/appointment/post_procedures.dart';
import 'package:wgnrr/utils/widget/button/button.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class list_appointment extends StatefulWidget {
  const list_appointment({super.key});

  @override
  State<list_appointment> createState() => _list_appointmentState();
}

class _list_appointmentState extends State<list_appointment> {
  var chat;
  List chats = [];

  Future get_chats() async {
    const url = '${murl}appointment/appointment-client.php';
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
        return Badge(
          backgroundColor: chats[index]['status'] == '0'
              ? Colors.orange.shade800
              : chats[index]['status'] == '2'
                  ? Colors.red
                  : chats[index]['status'] == '4'
                      ? Colors.red
                      : Colors.green,
          label: AppText(
              txt: chats[index]['status'] == '0'
                  ? 'Pending'
                  : chats[index]['status'] == '1'
                      ? 'Accepted'
                      : chats[index]['status'] == '2'
                          ? 'Rejected'
                          : chats[index]['status'] == '3'
                              ? 'Attended'
                              : chats[index]['status'] == '4'
                                  ? 'Did not attend'
                                  : chats[index]['status'] == '5'
                                      ? 'In post procedure'
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
                          txt: chats[index]['doctor'].toString().toUpperCase(),
                          size: 15,
                          weight: FontWeight.w700,
                        )),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          txt: chats[index]['date'].toString().toUpperCase(),
                          size: 15,
                          weight: FontWeight.w300,
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
                  if (chats[index]['status'] == '1')
                    Container(
                      height: 20,
                      child: AppButton(
                        onPress: () => null,
                        label: 'Accepted',
                        bcolor: Colors.green,
                        borderCurve: 5,
                      ),
                    ),
                  if (chats[index]['status'] == '3' &&
                          chats[index]['reason'] == 'Procedure - Medical' ||
                      chats[index]['reason'] == 'Procedure - Surgical')
                    Container(
                      height: 20,
                      child: AppButton(
                        onPress: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => postProcedures(
                                      client: chats[index]['client'],
                                      doctor: chats[index]['doctor'],
                                      reason: chats[index]['reason'],
                                      date_attended: chats[index]
                                          ['date_attended'],
                                    ))),
                        label: 'post procedures',
                        bcolor: Colors.green,
                        borderCurve: 5,
                      ),
                    ),
                  if (chats[index]['status'] == '3')
                    SizedBox(
                      height: 10,
                    ),
                  if (chats[index]['status'] == '1')
                    Container(
                      height: 20,
                      child: AppButton(
                        onPress: () => null,
                        label: 'Print Appointment',
                        bcolor: Colors.green,
                        borderCurve: 5,
                      ),
                    ),
                  if (chats[index]['status'] == '4')
                    Container(
                      height: 20,
                      child: AppButton(
                        onPress: () => null,
                        label: 'Missed',
                        bcolor: Colors.red,
                        borderCurve: 5,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: chats == null ? 0 : chats.length,
    );
  }
}
