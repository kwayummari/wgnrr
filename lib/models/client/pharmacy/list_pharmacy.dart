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

class list_chats_pharmacy extends StatefulWidget {
  const list_chats_pharmacy({super.key});

  @override
  State<list_chats_pharmacy> createState() => _list_chats_pharmacyState();
}

class _list_chats_pharmacyState extends State<list_chats_pharmacy> {
  var chat;
  List chats = [];

  Future get_chats() async {
    const url = '${murl}chats_pharmacy/chats.php';
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

  Future send_rates(rating, id) async {
    String rate = "$rating";
    String ids = "$id";
    const url = '${murl}rate/rate_write.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "id": ids.toString(),
      "rating": rate.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          get_chats();
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
          child: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              border: Border.all(color: HexColor('#742B90')),
            ),
            child: ListTile(
                title: Text(chats[index]['doctor']),
                trailing: double.parse(chats[index]['rate']) > 0
                    ? Text(chats[index]['rate'].toString())
                    : InkWell(
                        onTap: () {
                          showCupertinoDialog(
                              context: context,
                              builder: ((context) => Center(
                                      child: RatingBar.builder(
                                    initialRating: 1,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: HexColor('#742B90'),
                                    ),
                                    onRatingUpdate: (rating) {
                                      send_rates(
                                        rating,
                                        chats[index]['id'],
                                      );
                                      Navigator.pop(context);
                                      get_chats();
                                    },
                                  ))));
                        },
                        child: Icon(Icons.star),
                      )),
          ),
        );
      },
      itemCount: chats == null ? 0 : chats.length,
    );
  }
}
