// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, curly_braces_in_flow_control_structures, constant_identifier_names, must_be_immutable, body_might_complete_normally_nullable, unused_local_variable, unnecessary_null_comparison, depend_on_referenced_packages

import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/open_chat/individualcommunitychats.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class chatsCommunity extends StatefulWidget {
  var topic_id;
  var topic_name;
  var client;
  chatsCommunity(
      {Key? key,
      required this.client,
      required this.topic_id,
      required this.topic_name})
      : super(key: key);

  @override
  State<chatsCommunity> createState() => _chatsCommunityState();
}

class _chatsCommunityState extends State<chatsCommunity> {
  var comment;
  List _comments = [];

  Future get_comments() async {
    http.Response response;
    const url = '${murl}community/community_text.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "topic": widget.topic_id.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          _comments = json.decode(response1.body);
          if (_comments.isNotEmpty) _goToBottomPage();
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

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  void _goToBottomPage() {
    if (_scrollController.hasClients)
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  Future Deletechat(id) async {
    http.Response response;
    const url = '${murl}community/delete_text.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "id": id.toString(),
    });
  }

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(widget.topic_name.toString().toUpperCase(),
            style: GoogleFonts.vesperLibre(
              color: Colors.white,
              fontSize: 15,
            )),
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
                      child: Text(
                        'No comments available at the moment',
                        style: GoogleFonts.vesperLibre(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              )
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    StreamBuilder(
                      stream: Stream.periodic(Duration(milliseconds: 100))
                          .asyncMap((i) =>
                              getValidationData()), // i is null here (check periodic docs)
                      builder: (context, snapshot) => Scrollbar(
                        controller: _scrollController,
                        child: ListView.builder(
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Align(
                                  alignment: _comments[index]['username'] ==
                                          widget.client.toString()
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: AppText(
                                    txt:
                                        _comments[index]['username'].toString(),
                                    size: 15,
                                  ),
                                ),
                                _comments[index]['type'] == '1'
                                    ? Align(
                                        alignment: _comments[index]
                                                    ['username'] ==
                                                widget.client.toString()
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Align(
                                          alignment: _comments[index]
                                                      ['username'] ==
                                                  widget.client.toString()
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Padding(
                                              padding: _comments[index]
                                                          ['username'] ==
                                                      widget.client.toString()
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
                                                                          'username'] ==
                                                                      widget
                                                                          .client
                                                                          .toString())
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
                                                child: Bubble(
                                                  color: _comments[index]
                                                              ['username'] ==
                                                          widget.client
                                                              .toString()
                                                      ? HexColor('#742B90')
                                                      : HexColor('#772255'),
                                                  margin:
                                                      BubbleEdges.only(top: 10),
                                                  alignment: _comments[index]
                                                              ['username'] ==
                                                          widget.client
                                                              .toString()
                                                      ? Alignment.topRight
                                                      : Alignment.topLeft,
                                                  nip: _comments[index]
                                                              ['username'] ==
                                                          widget.client
                                                              .toString()
                                                      ? BubbleNip.rightTop
                                                      : BubbleNip.leftTop,
                                                  child: AppText(
                                                    txt: _comments[index]
                                                        ['message'],
                                                    color: _comments[index]
                                                                ['username'] ==
                                                            widget.client
                                                                .toString()
                                                        ? Colors.white
                                                        : Colors.white,
                                                    weight: FontWeight.w400,
                                                    size: 15,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      )
                                    : Align(
                                        alignment: _comments[index]
                                                    ['username'] ==
                                                widget.client.toString()
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Align(
                                          alignment: _comments[index]
                                                      ['username'] ==
                                                  widget.client.toString()
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Padding(
                                              padding: _comments[index]['username'] ==
                                                      widget.client.toString()
                                                  ? const EdgeInsets.only(
                                                      left: 150)
                                                  : const EdgeInsets.only(
                                                      right: 150),
                                              child: Bubble(
                                                  elevation: 4,
                                                  color: _comments[index]
                                                              ['username'] ==
                                                          widget.client
                                                              .toString()
                                                      ? HexColor('#742B90')
                                                      : HexColor('#772255'),
                                                  margin:
                                                      BubbleEdges.only(top: 10),
                                                  alignment: _comments[index]
                                                              ['username'] ==
                                                          widget.client
                                                              .toString()
                                                      ? Alignment.topRight
                                                      : Alignment.topLeft,
                                                  nip: _comments[index]
                                                              ['username'] ==
                                                          widget.client.toString()
                                                      ? BubbleNip.rightTop
                                                      : BubbleNip.leftTop,
                                                  child: Image.network(
                                                    '${murl}message/image/${_comments[index]['image']}',
                                                    height: 50,
                                                    width: 50,
                                                  ))),
                                        ),
                                      ),
                              ],
                            );
                          },
                          itemCount: _comments == null ? 0 : _comments.length,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
        Individualcommunitychats(
            client: widget.client, topic: widget.topic_id, username: username)
      ]),
    );
  }
}
