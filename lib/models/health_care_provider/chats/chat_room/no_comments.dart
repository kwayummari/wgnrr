// ignore_for_file: unused_field, unused_local_variable
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/utils/widget/text/text.dart';

class No_comment extends StatefulWidget {
  const No_comment({super.key});

  @override
  State<No_comment> createState() => _No_commentState();
}

class _No_commentState extends State<No_comment> {
  Future send_comments() async {
    const url = 'https://mtokotz.com/mtoko/company_images/comments.php';
    var response = await http.post(Uri.parse(url), body: {
      "username": username.toString(),
      // "image": widget.image.toString(),
      "comments": comments.text,
    });
    if (response.statusCode == 200) {
      setState(() {
        // get_comments();
        // if (comment.text != null)
        // comment.clear();
        comments.clear();
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
  }

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  TextEditingController comments = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: AppText(txt: 'widget.caption',
        size: 20,
        color: Colors.white,),
        backgroundColor: Colors.grey.shade900,
      ),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: size.height,
            ),
            Center(
              child: AppText(
                txt: 'No Text available at the moment',
                size: 20,
                color: Colors.black,
                weight: FontWeight.w400,
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 100,
              child: Form(
                key: _formKey,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    maxWidth: MediaQuery.of(context).size.width,
                    minHeight: 30.0,
                    maxHeight: 250.0,
                  ),
                  child: Scrollbar(
                    child: TextFormField(
                      cursorColor: Theme.of(context).iconTheme.color,
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
                              color: Theme.of(context).iconTheme.color,
                            )),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: HexColor('#cbdd33')),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        enabledBorder: Theme.of(context)
                            .inputDecorationTheme
                            .enabledBorder,
                        fillColor: Theme.of(context).iconTheme.color,
                        hoverColor: Theme.of(context).iconTheme.color,
                        focusColor: Theme.of(context).iconTheme.color,
                        hintText: 'Message',
                        hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Theme.of(context).iconTheme.color),
                        contentPadding: EdgeInsets.only(
                            top: 5.0, left: 15.0, right: 15.0, bottom: 5.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
