import 'dart:async';
import 'dart:convert';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/open_chat/individualcommunitychats.dart';
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
  TextEditingController comments = TextEditingController();
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
        if (_comments.isNotEmpty) {
          scrollToBottom();
        }
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
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 200),
                      Center(
                        child: AppText(
                          txt: 'No comments available at the moment',
                          size: 16,
                          weight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification &&
                          _scrollController.position.extentAfter == 0) {
                        // Fetch more comments here if needed
                        // e.g., paginate or load older comments
                      }
                      return false;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 70),
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
                                              : const EdgeInsets.only(
                                                  right: 150),
                                          child: InkWell(
                                            highlightColor: Colors.white,
                                            focusColor: Colors.white,
                                            hoverColor: Colors.white,
                                            onLongPress: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Stack(
                                                      children: <Widget>[
                                                        Positioned(
                                                          right: -40.0,
                                                          top: -40.0,
                                                          child: InkResponse(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: CircleAvatar(
                                                              child: Icon(
                                                                  Icons.close),
                                                              backgroundColor:
                                                                  HexColor(
                                                                      '#db5252'),
                                                            ),
                                                          ),
                                                        ),
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            if (isClientComment)
                                                              Row(
                                                                children: [
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Deletechat(
                                                                          comment[
                                                                              'id']);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    icon: Icon(Icons
                                                                        .delete),
                                                                  ),
                                                                  AppText(
                                                                    size: 15,
                                                                    txt:
                                                                        'Delete Text',
                                                                  ),
                                                                ],
                                                              ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
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
                                              : const EdgeInsets.only(
                                                  right: 150),
                                          child: Bubble(
                                            elevation: 4,
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
                                            child: Image.network(
                                              '${murl}message/image/${comment['image']}',
                                              height: 50,
                                              width: 50,
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
                  ),
                ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Individualcommunitychats(
                client: widget.client,
                topic: widget.topic_id,
                username: username,
              )),
        ],
      ),
    );
  }

  Future<void> Deletechat(int id) async {
    final url = '${murl}community/delete_text.php';
    await http.post(Uri.parse(url), body: {
      "id": id.toString(),
    });
    setState(() {
      _comments.removeWhere((comment) => comment['id'] == id);
    });
  }
}
