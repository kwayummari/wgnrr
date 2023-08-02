import 'dart:async';
import 'dart:convert';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class ChatsCommunity extends StatefulWidget {
  final int topic_id;
  final String topic_name;
  final String client;

  const ChatsCommunity({
    Key? key,
    required this.client,
    required this.topic_id,
    required this.topic_name,
  }) : super(key: key);

  @override
  _ChatsCommunityState createState() => _ChatsCommunityState();
}

class _ChatsCommunityState extends State<ChatsCommunity> {
  List<dynamic> _comments = [];
  final ScrollController _scrollController = ScrollController();

  Future<void> getComments() async {
    final url = '${murl}community/community_text.php';
    final response1 = await http.post(Uri.parse(url), body: {
      "topic": widget.topic_id.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted) {
        setState(() {
          _comments = json.decode(response1.body);
        });
        if (_comments.isNotEmpty) {}
      }
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

  final _formKey = GlobalKey<FormState>();
  TextEditingController commentss = TextEditingController();
  Future send_comments() async {
    if (commentss.text.isNotEmpty) {
      var commentsss = commentss.text.toString();
      commentss.clear();
      if (!replying) {
        const url = '${murl}community/create_community_text.php';
        var response = await http.post(Uri.parse(url), body: {
          "username": username.toString(),
          "topic": widget.topic_id.toString(),
          "message": commentsss,
        });
        if (response.statusCode == 200) {
          setState(() {
            getComments();
          });
        }
      } else {
        const url = '${murl}community/create_community_text_reply.php';
        var response = await http.post(Uri.parse(url), body: {
          "username": username.toString(),
          "topic": widget.topic_id.toString(),
          "message": commentsss,
          "repliedMessage": repliedMessage.toString(),
        });
        if (response.statusCode == 200) {
          setState(() {
            getComments();
            replying = !replying;
            repliedMessage = '';
          });
        }
      }
    }
  }

  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getComments();
    });
    getValidationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Change your color here
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: AppText(
          txt: widget.topic_name.toString().toUpperCase(),
          size: 15,
          color: Colors.white,
        ),
        backgroundColor: HexColor('#742B90'),
      ),
      body: Stack(
        children: [
          _comments.isEmpty
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: AppText(
                      txt: 'No comments available at the moment',
                      size: 16,
                      weight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                )
              : Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _comments.length,
                    itemBuilder: (context, index) {
                      final comment = _comments[index];
                      final isClientComment =
                          comment['username'] == widget.client;
                      return Column(
                        children: [
                          Align(
                            alignment: isClientComment
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: AppText(
                              txt: comment['username'].toString(),
                              size: 15,
                            ),
                          ),
                          comment['type'] == '1'
                              ? Align(
                                  alignment: isClientComment
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Align(
                                    alignment: isClientComment
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Padding(
                                      padding: isClientComment
                                          ? const EdgeInsets.only(left: 150)
                                          : const EdgeInsets.only(right: 150),
                                      child: Slidable(
                                        endActionPane: ActionPane(
                                          motion: ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              // An action can be bigger than the others.
                                              flex: 2,
                                              onPressed: (value) {
                                                deleteChat(comment['id']);
                                              },
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                            ),
                                            SlidableAction(
                                              onPressed: (value) {
                                                reply(comment['message']);
                                              },
                                              backgroundColor: Colors.green,
                                              foregroundColor: Colors.white,
                                              icon: Icons.reply,
                                            ),
                                          ],
                                        ),
                                        child: Bubble(
                                          color: isClientComment
                                              ? HexColor('#742B90')
                                              : HexColor('#772255'),
                                          margin: BubbleEdges.only(top: 10),
                                          alignment: isClientComment
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          nip: isClientComment
                                              ? BubbleNip.rightTop
                                              : BubbleNip.leftTop,
                                          child: AppText(
                                            txt: comment['message'],
                                            color: isClientComment
                                                ? Colors.white
                                                : Colors.white,
                                            weight: FontWeight.w400,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Align(
                                  alignment: isClientComment
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Align(
                                    alignment: isClientComment
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Padding(
                                      padding: isClientComment
                                          ? const EdgeInsets.only(left: 150)
                                          : const EdgeInsets.only(right: 150),
                                      child: Slidable(
                                        endActionPane: ActionPane(
                                          motion: ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              // An action can be bigger than the others.
                                              flex: 2,
                                              onPressed: (value) {
                                                deleteChat(comment['id']);
                                              },
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                            ),
                                            SlidableAction(
                                              onPressed: (value) {
                                                reply(comment['message']);
                                              },
                                              backgroundColor: Colors.green,
                                              foregroundColor: Colors.white,
                                              icon: Icons.reply,
                                            ),
                                          ],
                                        ),
                                        child: Bubble(
                                          color: isClientComment
                                              ? HexColor('#742B90')
                                              : HexColor('#772255'),
                                          alignment: isClientComment
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          nip: isClientComment
                                              ? BubbleNip.rightTop
                                              : BubbleNip.leftTop,
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: HexColor('#aa42ad'),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(5.0),
                                                      topRight:
                                                          Radius.circular(5.0),
                                                    ),
                                                    border: Border.all(
                                                        color: HexColor(
                                                            '#742B90'))),
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                    minWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.3,
                                                    minHeight: 30.0,
                                                    maxHeight: 250.0,
                                                  ),
                                                  child: Scrollbar(
                                                    child: AppText(
                                                      txt: comment['oldtext'],
                                                      color: isClientComment
                                                          ? Colors.white
                                                          : Colors.white,
                                                      weight: FontWeight.w400,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: AppText(
                                                  txt: comment['message'],
                                                  color: isClientComment
                                                      ? Colors.white
                                                      : Colors.white,
                                                  weight: FontWeight.w400,
                                                  size: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (replying)
                    Container(
                      decoration: BoxDecoration(
                          color: HexColor('#aa42ad'),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                          border: Border.all(color: HexColor('#742B90'))),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width / 1.4,
                          maxWidth: MediaQuery.of(context).size.width / 1.3,
                          minHeight: 30.0,
                          maxHeight: 250.0,
                        ),
                        child: Scrollbar(
                          child: AppText(
                            txt: repliedMessage,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  Container(
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
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: commentss,
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
                              borderSide:
                                  BorderSide(color: HexColor('#742B90')),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            fillColor: Colors.white,
                            hoverColor: HexColor('#742B90'),
                            focusColor: HexColor('#742B90'),
                            hintText: 'Message',
                            hintStyle: TextStyle(color: Colors.white),
                            contentPadding: EdgeInsets.only(
                                top: 5.0, left: 15.0, right: 15.0, bottom: 5.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteChat(int id) async {
    final url = '${murl}community/delete_text.php';
    await http.post(Uri.parse(url), body: {
      "id": id.toString(),
    });
    setState(() {
      _comments.removeWhere((comment) => comment['id'] == id);
    });
  }

  var repliedMessage;
  bool replying = false;
  void reply(String message) async {
    setState(() {
      repliedMessage = message;
      replying = true;
    });
  }
}
