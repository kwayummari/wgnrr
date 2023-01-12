// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wgnrr/api/const.dart';
import 'package:http/http.dart' as http;

class Individualchats extends StatefulWidget {
  var username;
  var doctor;
  var client;
  void get_comments;
  Individualchats(
      {super.key,
      required this.client,
      required this.doctor,
      required this.get_comments,
      required this.username});

  @override
  State<Individualchats> createState() => _IndividualchatsState();
}

class _IndividualchatsState extends State<Individualchats> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController comments = TextEditingController();
  Future send_comments() async {
    const url = '${murl}message/message_write.php';
    var response = await http.post(Uri.parse(url), body: {
      "username": widget.username.toString(),
      "doctor": widget.doctor.toString(),
      "comments": comments.text,
      "part": '1'.toString(),
    });
    if (response.statusCode == 200) {
      setState(() {
        widget.get_comments;
        comments.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              children: [
                Spacer(),
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
                Spacer(),
                CircleAvatar(
                    backgroundColor: HexColor('#742B90'),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ))),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
