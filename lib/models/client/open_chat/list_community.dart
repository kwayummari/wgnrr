// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/chats/chat_room/chats.dart';
import 'package:wgnrr/models/client/open_chat/chats_community.dart';
import 'package:wgnrr/utils/animation/shimmers/info-shimmer.dart';

class list_community extends StatefulWidget {
  const list_community({super.key});

  @override
  State<list_community> createState() => _list_communityState();
}

class _list_communityState extends State<list_community> {
  var chat;
  List chats = [];

  Future get_chats() async {
    const url = '${murl}community/community.php';
    var response1 = await http.get(Uri.parse(url));
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
    return chats.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
                SizedBox(
                  height: 20,
                ),
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
                SizedBox(
                  height: 20,
                ),
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
                SizedBox(
                  height: 20,
                ),
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
                SizedBox(
                  height: 20,
                ),
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
                SizedBox(
                  height: 20,
                ),
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
                SizedBox(
                  height: 20,
                ),
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
              ],
            ),
          )
        : ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => chatsCommunity(
                      client: username,
                      topic_id: chats[index]['id'],
                      topic_name: chats[index]['topic'],
                    )));
          },
          child: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              border: Border.all(color: HexColor('#742B90')),
            ),
            child: ListTile(
              title: Text(chats[index]['topic']),
            ),
          ),
        );
      },
      itemCount: chats == null ? 0 : chats.length,
    );
  }
}
