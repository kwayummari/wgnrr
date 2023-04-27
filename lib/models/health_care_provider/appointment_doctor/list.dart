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

  Future attended(id) async {
    const url = '${murl}appointment/update-reason.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "id": id.toString(),
      "status": '3'.toString(),
      "reason": abortion.toString(),
    });
    if (response1.statusCode == 200) {
      Navigator.pop(context);
      if (mounted)
        setState(() {
          chats = json.decode(response1.body);
        });
    }
  }

  Future missed(id) async {
    const url = '${murl}appointment/update.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "id": id.toString(),
      "status": '4'.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          chats = json.decode(response1.body);
        });
    }
  }

  var abortion;
  List abortions = [
    'Consultation and Investigation',
    'Treatment',
    'Procedure - Surgical',
    'Procedure - Medical'
  ];

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
    return StreamBuilder(
        stream: Stream.periodic(Duration(milliseconds: 5)).asyncMap(
            (i) => getValidationData()), // i is null here (check periodic docs)
        builder: (context, snapshot) => ListView.builder(
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
                                  txt: chats[index]['client']
                                      .toString()
                                      .toUpperCase(),
                                  size: 15,
                                  weight: FontWeight.w700,
                                )),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: AppText(
                                  txt: chats[index]['date']
                                      .toString()
                                      .toUpperCase(),
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
                          if (chats[index]['status'] != '2' &&
                              chats[index]['status'] != '1' &&
                              chats[index]['status'] != '3' &&
                              chats[index]['status'] != '4' &&
                              chats[index]['status'] != '5')
                            Container(
                              height: 20,
                              child: AppButton(
                                onPress: () => accept(chats[index]['id']),
                                label: 'Accept',
                                bcolor: Colors.green,
                                borderCurve: 5,
                              ),
                            ),
                          if (chats[index]['status'] != '2' &&
                              chats[index]['status'] != '1' &&
                              chats[index]['status'] != '3' &&
                              chats[index]['status'] != '4' &&
                              chats[index]['status'] != '5')
                            SizedBox(
                              height: 10,
                            ),
                          if (chats[index]['status'] != '2' &&
                              chats[index]['status'] != '1' &&
                              chats[index]['status'] != '3' &&
                              chats[index]['status'] != '4' &&
                              chats[index]['status'] != '5')
                            Container(
                              height: 20,
                              child: AppButton(
                                onPress: () => reject(chats[index]['id']),
                                label: 'Reject',
                                bcolor: Colors.red,
                                borderCurve: 5,
                              ),
                            ),
                          if (chats[index]['status'] == '1')
                            Container(
                              height: 20,
                              child: AppButton(
                                onPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: AppText(
                                          txt: "Select Service Done",
                                          size: 15,
                                        ),
                                        actions: [
                                          Container(
                                            height: 70,
                                            width: 330,
                                            child: DropdownButtonFormField(
                                              elevation: 10,
                                              menuMaxHeight: 330,
                                              isExpanded: true,
                                              focusColor: Colors.white,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                filled: true,
                                                fillColor: Colors.white,
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  borderSide: BorderSide(
                                                      color:
                                                          HexColor('#000000')),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  borderSide: BorderSide(
                                                      color:
                                                          HexColor('#000000')),
                                                ),
                                                prefixIcon: Icon(
                                                  Icons.male,
                                                  color: Colors.black,
                                                ),
                                                prefixIconColor: Colors.black,
                                              ),
                                              hint: AppText(
                                                txt: language == 'English'
                                                    ? 'Abortion services'
                                                    : 'Huduma za utoaji mimba',
                                                size: 15,
                                                color: Colors.black,
                                              ),
                                              validator: (value) {
                                                if (value == null) {
                                                  return language == 'Kiswahili'
                                                      ? 'Chagua'
                                                      : "Please select";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              value: abortion,
                                              onChanged: (newValue1) {
                                                setState(() {
                                                  abortion = newValue1;
                                                });
                                              },
                                              items: abortions.map((valueItem) {
                                                return DropdownMenuItem(
                                                  value: valueItem,
                                                  child: AppText(
                                                    txt: valueItem != null
                                                        ? valueItem
                                                        : 'default value',
                                                    color: Colors.black,
                                                    size: 15,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            width: 330,
                                            child: AppButton(
                                                onPress: () => attended(
                                                    chats[index]['id']),
                                                label: 'Submit',
                                                bcolor: HexColor('#F5841F'),
                                                borderCurve: 20),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Close"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                label: 'Attended',
                                bcolor: Colors.green,
                                borderCurve: 5,
                              ),
                            ),
                          if (chats[index]['status'] == '1')
                            SizedBox(
                              height: 10,
                            ),
                          if (chats[index]['status'] == '1')
                            Container(
                              height: 20,
                              child: AppButton(
                                onPress: () => missed(chats[index]['id']),
                                label: 'Missed',
                                bcolor: Colors.red,
                                borderCurve: 5,
                              ),
                            ),
                          if (chats[index]['status'] == '5')
                            Container(
                              height: 20,
                              child: AppButton(
                                onPress: () => null,
                                label: 'In Post Procedure',
                                bcolor: Colors.green,
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
            ));
  }
}
