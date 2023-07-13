// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, curly_braces_in_flow_control_structures, constant_identifier_names, must_be_immutable, body_might_complete_normally_nullable, unused_local_variable, unnecessary_null_comparison, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/chats/chat_room/add_image.dart';
import 'package:wgnrr/models/client/chats/chat_room/appointment.dart';
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
  ScrollController _scrollController = ScrollController();

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
  final _formKey1 = GlobalKey<FormState>();
  TextEditingController comments = TextEditingController();

  bool isLoading = false;
  done() async {
    await Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

Future send_comments() async {
    if (comments.text.isNotEmpty) {
      const url = '${murl}message/message_write.php';
      var response = await http.post(Uri.parse(url), body: {
        "username": username.toString(),
        "doctor": widget.doctor.toString(),
        "comments": comments.text,
        "part": '1'.toString(),
        "type": '1'.toString(),
      });
      get_comments();
    }
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
  bool allowScreenshots = false;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    get_comments();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      get_comments();
    });
    allowScreenshots = false;
  FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    getValidationData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  allowScreenshots = true;
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
                       ListView.builder(
                        controller: _scrollController, 
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
                              ],
                            );
                          },
                          itemCount: _comments == null ? 0 : _comments.length,
                        ),
                      SizedBox(
                        height: 100,
                      ),
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
                      suffixIcon: Container(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  send_comments();
                                  comments.clear();
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Add(
                                            client: widget.client,
                                            doctor: widget.doctor,
                                            username: username,
                                          )));
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
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
    )
      ]),
    );
  }
}
