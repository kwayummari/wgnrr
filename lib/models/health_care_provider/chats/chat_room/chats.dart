// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, curly_braces_in_flow_control_structures, constant_identifier_names, must_be_immutable, body_might_complete_normally_nullable, unused_local_variable, unnecessary_null_comparison, depend_on_referenced_packages

import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class Chats extends StatefulWidget {
  var doctor;
  var client;
  Chats({Key? key, required this.client, required this.doctor})
      : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  Future send_comments() async {
    const url = '${murl}message/message_hcp_write.php';
    var response = await http.post(Uri.parse(url), body: {
      "client": widget.client.toString(),
      "doctor": widget.doctor.toString(),
      "comments": comments.text,
      "part": '2'.toString(),
    });
    if (response.statusCode == 200) {
      setState(() {
        get_comments();
        comments.clear();
      });
    }
  }

  var comment;
  List _comments = [];

  Future get_comments() async {
    http.Response response;
    const url = '${murl}message/message.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "client": widget.client.toString(),
      "doctor": widget.doctor.toString()
    });
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          _comments = json.decode(response1.body);
        });
    }
  }

  Future update() async {
    http.Response response;
    const url = '${murl}message/update-seen.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "client": widget.client.toString(),
      "doctor": widget.doctor.toString()
    });
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
    get_comments();
  }

  Future Deletechat(id) async {
    http.Response response;
    const url = '${murl}message/delete.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "id": id.toString(),
    });
  }

  @override
  void initState() {
    super.initState();
    getValidationData();
    update();
  }

  TextEditingController comments = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: AppText(
          txt: 'Chat Room',
          size: 15,
          color: Colors.white,
        ),
        backgroundColor: HexColor('#742B90'),
      ),
      body: Stack(children: [
        _comments.isEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    Center(
                      child: AppText(
                        txt: 'No comments available at the moment',
                        size: 20,
                      ),
                    )
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      StreamBuilder(
                        stream: Stream.periodic(Duration(seconds: 5)).asyncMap(
                            (i) =>
                                getValidationData()), // i is null here (check periodic docs)
                        builder: (context, snapshot) => ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // bool isplaying = false;
                            return Column(
                              children: [
                                Align(
                                  alignment: _comments[index]['part'] == '2'
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: AppText(
                                      txt: _comments[index]['part'] == '2'
                                          ? username.toString()
                                          : _comments[index]['username'],
                                      size: 15),
                                ),
                                _comments[index]['type'] == '1'
                                    ? Align(
                                        alignment:
                                            _comments[index]['part'] == '2'
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                        child: Align(
                                          alignment:
                                              _comments[index]['part'] == '2'
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                          child: Padding(
                                            padding:
                                                _comments[index]['part'] == '2'
                                                    ? const EdgeInsets.only(
                                                        left: 150)
                                                    : const EdgeInsets.only(
                                                        right: 150),
                                            child: InkWell(
                                                highlightColor: Colors.white,
                                                focusColor: Colors.white,
                                                hoverColor: Colors.white,
                                                onLongPress: () {
                                                  if (_comments[index]
                                                          ['part'] ==
                                                      '2')
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            content: Stack(
                                                              children: <Widget>[
                                                                Positioned(
                                                                  right: -40.0,
                                                                  top: -40.0,
                                                                  child:
                                                                      InkResponse(
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        CircleAvatar(
                                                                      child: Icon(
                                                                          Icons
                                                                              .close),
                                                                      backgroundColor:
                                                                          HexColor(
                                                                              '#db5252'),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    if (_comments[index]
                                                                            [
                                                                            'part'] ==
                                                                        '2')
                                                                      Row(
                                                                        children: [
                                                                          IconButton(
                                                                              onPressed: () {
                                                                                Deletechat(_comments[index]['id']);
                                                                                Navigator.pop(context);
                                                                              },
                                                                              icon: Icon(Icons.delete)),
                                                                        ],
                                                                      )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                },
                                                child: Stack(
                                                  children: [
                                                    Bubble(
                                                      color: _comments[index]
                                                                  ['part'] ==
                                                              '2'
                                                          ? HexColor('#742B90')
                                                          : HexColor('#772255'),
                                                      margin: BubbleEdges.only(
                                                          top: 10),
                                                      alignment: _comments[
                                                                      index]
                                                                  ['part'] ==
                                                              '2'
                                                          ? Alignment.topRight
                                                          : Alignment.topLeft,
                                                      nip: _comments[index]
                                                                  ['part'] ==
                                                              '2'
                                                          ? BubbleNip.rightTop
                                                          : BubbleNip.leftTop,
                                                      child: AppText(
                                                        txt: _comments[index]
                                                            ['comment'],
                                                        size: 15,
                                                        color: _comments[index]
                                                                    ['part'] ==
                                                                '2'
                                                            ? Colors.white
                                                            : Colors.white,
                                                        weight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ),
                                      )
                                    : Align(
                                        alignment:
                                            _comments[index]['part'] == '2'
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                        child: Align(
                                          alignment:
                                              _comments[index]['part'] == '2'
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                          child: Padding(
                                              padding: _comments[index]
                                                          ['part'] ==
                                                      '2'
                                                  ? const EdgeInsets.only(
                                                      left: 150)
                                                  : const EdgeInsets.only(
                                                      right: 150),
                                              child: InkWell(
                                                highlightColor: Colors.white,
                                                focusColor: Colors.white,
                                                hoverColor: Colors.white,
                                                onLongPress: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          content: Stack(
                                                            children: <Widget>[
                                                              Positioned(
                                                                right: -40.0,
                                                                top: -40.0,
                                                                child:
                                                                    InkResponse(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child:
                                                                      CircleAvatar(
                                                                    child: Icon(
                                                                        Icons
                                                                            .close),
                                                                    backgroundColor:
                                                                        HexColor(
                                                                            '#db5252'),
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  if (_comments[
                                                                              index]
                                                                          [
                                                                          'part'] ==
                                                                      '2')
                                                                    Row(
                                                                      children: [
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              Deletechat(_comments[index]['id']);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            icon:
                                                                                Icon(Icons.delete)),
                                                                      ],
                                                                    )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Align(
                                                  alignment: _comments[index]
                                                              ['part'] ==
                                                          '2'
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: _comments[index]
                                                                    ['part'] ==
                                                                '2'
                                                            ? HexColor(
                                                                '#742B90')
                                                            : HexColor(
                                                                '#772255'),
                                                        border: Border.all(
                                                          color: Colors
                                                              .black, // Set the desired border color here
                                                          width:
                                                              2, // Set the desired border width
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Image.network(
                                                            '${murl}message/image/${_comments[index]['image']}',
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          AppText(
                                                            size: 15,
                                                            txt:
                                                                _comments[index]
                                                                    ['comment'],
                                                            color: Colors.white,
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              )),
                                        ),
                                      ),
                                SizedBox(
                                  height: 3,
                                ),
                              ],
                            );
                          },
                          itemCount: _comments == null ? 0 : _comments.length,
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      )
                    ],
                  ),
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
                        style: TextStyle(
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
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                send_comments();
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              )),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: HexColor('#742B90')),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          fillColor: Colors.white,
                          hoverColor: HexColor('#742B90'),
                          focusColor: HexColor('#742B90'),
                          hintText: 'Message',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                          contentPadding: EdgeInsets.only(
                              top: 5.0, left: 15.0, right: 15.0, bottom: 5.0),
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
    );
  }
}
