// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/appointment/post_procedures.dart';

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
      itemBuilder: (context, index) => Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        margin: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      chats[index]['doctor'].toString().toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: chats[index]['status'] == '0'
                          ? Colors.orange.shade800
                          : (chats[index]['status'] == '2' ||
                                  chats[index]['status'] == '4')
                              ? Colors.red
                              : Colors.green,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      _getStatus(chats[index]['status']),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                chats[index]['service'],
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10.0),
              Text(
                chats[index]['date'].toString().toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                chats[index]['reason'] ?? 'Unknown',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10.0),
              if (chats[index]['status'] == '1')
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 20,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Accepted'),
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      height: 20,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Print Appointment'),
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                      ),
                    ),
                  ],
                ),
              if (chats[index]['status'] == '3' &&
                  (chats[index]['reason'] == 'Procedure - Medical' ||
                      chats[index]['reason'] == 'Procedure - Surgical'))
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => postProcedures(
                            client: chats[index]['client'],
                            doctor: chats[index]['doctor'],
                            reason: chats[index]['reason'],
                            date_attended: chats[index]['date_attended'],
                          ),
                        ),
                      );
                    },
                    child: Text('Post Procedures'),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                ),
              if (chats[index]['status'] == '4')
                Container(
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Missed'),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
      itemCount: chats?.length ?? 0,
    );
  }

  String _getStatus(String status) {
    switch (status) {
      case '0':
        return 'Pending';
      case '1':
        return 'Accepted';
      case '2':
        return 'Rejected';
      case '3':
        return 'Attended';
      case '4':
        return 'Did not attend';
      case '5':
        return 'In post procedure';
      default:
        return 'Rejected';
    }
  }
}
