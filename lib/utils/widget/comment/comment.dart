// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, curly_braces_in_flow_control_structures, constant_identifier_names, must_be_immutable, body_might_complete_normally_nullable, unused_local_variable, unnecessary_null_comparison, depend_on_referenced_packages

import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';

class Comment extends StatefulWidget {
  var choice_id;
  var choice_specific_id;
  var title;
  Comment({Key? key, required this.choice_id, required this.choice_specific_id, required this.title})
      : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  Future send_comments() async {
    const url = '${murl}comment/comment_write.php';
    var response = await http.post(Uri.parse(url), body: {
      "username": username.toString(),
      "choice_id": widget.choice_id.toString(),
      "choice_specific_id": widget.choice_specific_id.toString(),
      "comment": comments.text,
    });
    if (response.statusCode == 200) {
      setState(() {
        get_comments();
      });
    }
  }

  var comment;
  List _comments = [];

  Future get_comments() async {
    http.Response response;
    const url = '${murl}comment/comment.php';
    var response1 = await http
        .post(Uri.parse(url), body: {
          "choice_id": widget.choice_id.toString(),
          "choice_specific_id": widget.choice_specific_id.toString()
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
        title: Text(widget.title,
            style: GoogleFonts.poppins(
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
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
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
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // bool isplaying = false;
                        return Column(
                          children: [
                            Align(
                              alignment:
                                  _comments[index]['username'] == username
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: Text(
                                  _comments[index]['username'] == username
                                      ? username.toString()
                                      : _comments[index]['username'],
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  )),
                            ),
                            Align(
                              alignment:
                                  _comments[index]['username'] == username
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: Align(
                                alignment:
                                    _comments[index]['username'] == username
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                child: Padding(
                                    padding:
                                        _comments[index]['username'] == username
                                            ? const EdgeInsets.only(left: 150)
                                            : const EdgeInsets.only(right: 150),
                                    child: Bubble(
                                      color: _comments[index]['username'] ==
                                              username
                                          ? HexColor('#742B90')
                                          : HexColor('#772255'),
                                      margin: BubbleEdges.only(top: 10),
                                      alignment: _comments[index]['username'] ==
                                              username
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      nip: _comments[index]['username'] ==
                                              username
                                          ? BubbleNip.rightTop
                                          : BubbleNip.leftTop,
                                      child: Text(
                                        _comments[index]['comment'],
                                        style: GoogleFonts.poppins(
                                          color: _comments[index]['username'] ==
                                                  username
                                              ? Colors.white
                                              : Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
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
                          hintStyle: GoogleFonts.poppins(
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
