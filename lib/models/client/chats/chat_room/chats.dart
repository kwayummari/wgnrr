// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, curly_braces_in_flow_control_structures, constant_identifier_names, must_be_immutable, body_might_complete_normally_nullable, unused_local_variable, unnecessary_null_comparison, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/chats/chat_room/appointment.dart';
import 'package:wgnrr/utils/screens/individual_chat.dart';
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

  bool isLoading = false;
  done() async {
    await Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  final ScrollController _scrollController = ScrollController();
  void scrollToBottom() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
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
  }

  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      get_comments();
    });
    getValidationData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future Deletechat(id) async {
    http.Response response;
    const url = '${murl}message/delete.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "id": id.toString(),
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Appointment(
                          client: widget.client,
                          doctor: widget.doctor,
                        )));
              },
              icon: Icon(Icons.notifications))
        ],
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: AppText(
          txt: 'Chat Room',
          color: Colors.white,
          size: 15,
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
                        color: Colors.black,
                        size: 16,
                        weight: FontWeight.w400,
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
                      NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification &&
                              _scrollController.position.extentAfter == 0) {
                            // Fetch more comments here if needed
                            // e.g., paginate or load older comments
                          }
                          return false;
                        },
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Align(
                                  alignment: _comments[index]['part'] == '1'
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: AppText(
                                    txt: _comments[index]['part'] == '1'
                                        ? username.toString()
                                        : _comments[index]['doctor'],
                                    size: 15,
                                    color: Colors.black,
                                    weight: FontWeight.w400,
                                  ),
                                ),
                                _comments[index]['type'] == '1'
                                    ? Align(
                                        alignment:
                                            _comments[index]['part'] == '1'
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                        child: Align(
                                          alignment:
                                              _comments[index]['part'] == '1'
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                          child: Padding(
                                              padding: _comments[index]
                                                          ['part'] ==
                                                      '1'
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
                                                                    if (_comments[index]
                                                                            [
                                                                            'part'] ==
                                                                        '1')
                                                                      Row(
                                                                        children: [
                                                                          IconButton(
                                                                              onPressed: () {
                                                                                Deletechat(_comments[index]['id']);
                                                                                Navigator.pop(context);
                                                                              },
                                                                              icon: Icon(Icons.delete)),
                                                                          AppText(
                                                                            size:
                                                                                15,
                                                                            txt:
                                                                                'Delete Text',
                                                                          )
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
                                                                '1'
                                                            ? HexColor(
                                                                '#742B90')
                                                            : HexColor(
                                                                '#772255'),
                                                        margin:
                                                            BubbleEdges.only(
                                                                top: 10),
                                                        alignment: _comments[
                                                                        index]
                                                                    ['part'] ==
                                                                '1'
                                                            ? Alignment.topRight
                                                            : Alignment.topLeft,
                                                        nip: _comments[index]
                                                                    ['part'] ==
                                                                '1'
                                                            ? BubbleNip.rightTop
                                                            : BubbleNip.leftTop,
                                                        child: AppText(
                                                          txt: _comments[index]
                                                              ['comment'],
                                                          size: 15,
                                                          color: _comments[
                                                                          index]
                                                                      [
                                                                      'part'] ==
                                                                  '1'
                                                              ? Colors.white
                                                              : Colors.white,
                                                          weight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      if (_comments[index]
                                                                  ['seen'] !=
                                                              null &&
                                                          _comments[index]
                                                                  ['part'] ==
                                                              '1') // add a checkmark icon if message is read
                                                        Positioned(
                                                          bottom: 0,
                                                          right: 10,
                                                          child: Icon(
                                                            Icons.done_all,
                                                            color: _comments[
                                                                            index]
                                                                        [
                                                                        'seen'] ==
                                                                    '0'
                                                                ? Colors.grey
                                                                : Colors.green,
                                                            size: 16,
                                                          ),
                                                        ),
                                                    ],
                                                  ))),
                                        ),
                                      )
                                    : Align(
                                        alignment:
                                            _comments[index]['part'] == '1'
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                        child: Align(
                                          alignment:
                                              _comments[index]['part'] == '1'
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                          child: Padding(
                                              padding: _comments[index]
                                                          ['part'] ==
                                                      '1'
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
                                                                      '1')
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
                                                                        AppText(
                                                                          size:
                                                                              15,
                                                                          txt:
                                                                              'Delete Text',
                                                                        )
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
                                                          '1'
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: _comments[index]
                                                                    ['part'] ==
                                                                '1'
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
                                                            height: 20,
                                                          ),
                                                          AppText(
                                                            size: 15,
                                                            txt:
                                                                _comments[index]
                                                                    ['comment'],
                                                            color: Colors.black,
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              )),
                                        ),
                                      ),
                              ],
                            );
                          },
                          itemCount: _comments == null ? 0 : _comments.length,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
        Individualchats(
            client: widget.client, doctor: widget.doctor, username: username)
      ]),
    );
  }
}
