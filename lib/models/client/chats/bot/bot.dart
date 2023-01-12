// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/chats/table/table.dart';

class Bot extends StatefulWidget {
  const Bot({super.key});

  @override
  State<Bot> createState() => _BotState();
}

class _BotState extends State<Bot> {
  Future send_comments() async {
    const url = '${murl}bot/bot_write.php';
    var response = await http.post(Uri.parse(url), body: {
      "username": username.toString(),
      "comments": comments.text,
    });
    if (response.statusCode == 200) {
      setState(() {
        get_bot_comments();
        comments.clear();
      });
    }
  }

  Future delete() async {
    const url = '${murl}bot/bot_delete.php';
    var response = await http.post(Uri.parse(url), body: {
      "username": username.toString(),
    });
    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Chat_table()));
    }
  }

  var comment;
  List _comments = [];

  Future get_bot_comments() async {
    http.Response response;
    const url = '${murl}bot/bot.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "username": username.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          _comments = json.decode(response1.body);
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
    get_bot_comments();
  }

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  TextEditingController comments = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _comments == null
        ? WillPopScope(
            onWillPop: () async => await delete(),
            child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: HexColor('#742B90'),
                centerTitle: true,
                automaticallyImplyLeading: true,
                title: Text(
                    language == 'Kiswahili'
                        ? 'Anza kwa hi'
                        : 'Initialize with hi',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                    )),
              ),
              body: Stack(children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(language == 'Kiswahili'
                            ? 'Hamna maoni kwa sasa'
                            : 'No comment available'),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Container(
                          decoration: BoxDecoration(
                              color: HexColor('#742B90'),
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(color: HexColor('#742B90'))),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width / 1.2,
                              maxWidth: MediaQuery.of(context).size.width / 1.2,
                              // minHeight: 30.0,
                              // maxHeight: 250.0,
                            ),
                            child: Scrollbar(
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: HexColor('#742B90')),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: TextFormField(
                                  cursorColor: HexColor('#742B90'),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: comments,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          send_comments();
                                        },
                                        icon: Icon(
                                          Icons.send,
                                          color: HexColor('#742B90'),
                                        )),
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor('#742B90')),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    fillColor: Colors.white,
                                    hoverColor: HexColor('#742B90'),
                                    focusColor: HexColor('#742B90'),
                                    hintText: language == 'Kiswahili'
                                        ? 'Ujumbe'
                                        : 'Message',
                                    hintStyle: TextStyle(
                                        fontSize: 15.0,
                                        color: HexColor('#742B90')),
                                    contentPadding: EdgeInsets.only(
                                        top: 5.0,
                                        left: 15.0,
                                        right: 15.0,
                                        bottom: 5.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          )
        : WillPopScope(
            onWillPop: () async => await delete(),
            child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: HexColor('#742B90'),
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading: InkWell(
                    onTap: () {
                      delete();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                title: Text(
                    language == 'Kiswahili'
                        ? 'Anza kwa hi'
                        : 'Initialize with hi',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                    )),
              ),
              body: Stack(children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Align(
                                alignment: _comments[index]['part'] == '1'
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Text(
                                    _comments[index]['part'] == '1'
                                        ? _comments[index]['username']
                                        : 'Kwayu',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    )),
                              ),
                              Align(
                                alignment: _comments[index]['part'] == '1'
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Align(
                                  alignment: _comments[index]['part'] == '1'
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Padding(
                                      padding: _comments[index]['part'] == '1'
                                          ? const EdgeInsets.only(left: 150)
                                          : const EdgeInsets.only(right: 150),
                                      child: Bubble(
                                        color: _comments[index]['part'] == '1'
                                            ? HexColor('#742B90')
                                            : HexColor('#772255'),
                                        margin: BubbleEdges.only(top: 10),
                                        alignment:
                                            _comments[index]['part'] == '1'
                                                ? Alignment.topRight
                                                : Alignment.topLeft,
                                        nip: _comments[index]['part'] == '1'
                                            ? BubbleNip.rightTop
                                            : BubbleNip.leftTop,
                                        child: Text(
                                          _comments[index]['part'] == '1'
                                              ? _comments[index]['comment']
                                              : _comments[index]['reply'],
                                          style: GoogleFonts.poppins(
                                              color: _comments[index]['part'] ==
                                                      '1'
                                                  ? Colors.white
                                                  : Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15),
                                        ),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          );
                          // <!-- android:usesCleartextTraffic="true" -->
                        },
                        itemCount: _comments == null ? 0 : _comments.length,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Container(
                          decoration: BoxDecoration(
                              color: HexColor('#742B90'),
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(color: HexColor('#742B90'))),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width / 1.3,
                              maxWidth: MediaQuery.of(context).size.width / 1.2,
                              minHeight: 30.0,
                              maxHeight: 250.0,
                            ),
                            child: Scrollbar(
                              child: TextFormField(
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: comments,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          return;
                                        }
                                        send_comments();
                                      },
                                      icon: Icon(
                                        Icons.send,
                                        color: HexColor('#ffffff'),
                                      )),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: HexColor('#742B90')),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  fillColor: Colors.white,
                                  hoverColor: HexColor('#742B90'),
                                  focusColor: HexColor('#742B90'),
                                  hintText: language == 'Kiswahili'
                                      ? 'Ujumbe'
                                      : 'Message',
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 15.0,
                                      color: HexColor('#ffffff')),
                                  contentPadding: EdgeInsets.only(
                                      top: 5.0,
                                      left: 15.0,
                                      right: 15.0,
                                      bottom: 5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
  }
}
