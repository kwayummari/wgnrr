// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker_plus/image_picker_plus.dart';
import 'package:wgnrr/api/const.dart';
import 'package:http/http.dart' as http;


class Individualchatsp extends StatefulWidget {
  var username;
  var doctor;
  var client;
  Individualchatsp(
      {super.key,
      required this.client,
      required this.doctor,
      required this.username});

  @override
  State<Individualchatsp> createState() => _IndividualchatspState();
}

class _IndividualchatspState extends State<Individualchatsp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController comments = TextEditingController();
  Future send_comments() async {
    if (comments.text.isNotEmpty) {
      const url = '${murl}message/message_write.php';
      var response = await http.post(Uri.parse(url), body: {
        "username": widget.client.toString(),
        "doctor": widget.doctor.toString(),
        "comments": comments.text,
        "part": '1'.toString(),
        "type": '1'.toString(),
      });
      if (response.statusCode == 200) {
        setState(() {
          get_comments();
          comments.clear();
        });
      }
    }
  }

  var comment;
  Future get_comments() async {
    const url = '${murl}message/message.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "client": widget.client.toString(),
      "doctor": widget.doctor.toString()
    });
    if (response1.statusCode == 200) {
      if (mounted) setState(() {});
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
                    style: GoogleFonts.vesperLibre(
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
                      hintStyle: GoogleFonts.vesperLibre(
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
    );
  }

}
