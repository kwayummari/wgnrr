// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, duplicate_ignore, prefer_const_constructors, body_might_complete_normally_nullable, prefer_if_null_operators, no_leading_underscores_for_local_identifiers, unused_element, avoid_print, unused_label

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/health_care_provider/feedback/feedback.dart';
import 'package:wgnrr/utils/animation/fade_animation.dart';
import 'package:wgnrr/utils/widget/button/button.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class Views extends StatefulWidget {
  var username;
  var author;
  var date;
  var title;
  var caption;
  var description;
  var image;
  var language;
  // ignore: non_constant_identifier_names
  Views(
      {Key? key,
      required this.language,
      required this.username,
      required this.author,
      required this.date,
      required this.title,
      required this.caption,
      required this.image,
      required this.description})
      : super(key: key);

  @override
  State<Views> createState() => _ViewsState();
}

class _ViewsState extends State<Views> {
  var language;
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var l = sharedPreferences.get('language');
    setState(() {
      language = l;
    });
  }

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FadeAnimation(
                1.2,
                Image.network('${murl}categories/image/${widget.image}'),
                ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: FadeAnimation(
              1.2,
              CircleAvatar(
                backgroundColor: HexColor('#981EE4'),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: mediaQuery.size.height / 1.28,
            child: FadeAnimation(
              1.2,
              Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: HexColor('#981EE4')),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeAnimation(
                        1.3,
                        Center(
                          child: AppText(
                            txt: '${widget.title}',
                              color: HexColor('#000000'),
                              size: 18,
                              weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: HexColor('#981EE4'),
                      ),
                      FadeAnimation(
                        1.3,
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: HexColor('#981EE4'),
                              child: Icon(Icons.calendar_month,
                                  color: HexColor('#ffffff')),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            AppText(
                              txt: language == 'Kiswahili'
                                  ? 'Tarehe -${widget.date}'
                                  : 'Date - ${widget.date}',
                                color: HexColor('#000000'),
                                size: 18,
                                weight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.3,
                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: HexColor('#981EE4'),
                                child: Icon(Icons.person,
                                    color: HexColor('#ffffff'))),
                            SizedBox(
                              width: 10,
                            ),
                            AppText(
                              txt: language == 'Kiswahili'
                                  ? 'Mwandishi - ${widget.author}'
                                  : 'Author - ${widget.author}',
                                color: HexColor('#000000'),
                                size: 15,
                                weight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: HexColor('#981EE4'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppText(
                        txt: language == 'Kiswahili' ? 'Muhtasari' : 'Caption',
                          color: HexColor('#981EE4'),
                          size: 18,
                      ),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: FadeAnimation(
                            1.3,
                            AppText(
                              txt: '${widget.caption}',
                                color: HexColor('#000000'),
                                size: 18,
                                weight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      AppText(
                        txt: language == 'Kiswahili' ? 'Maelezo' : 'Description',
                          color: HexColor('#981EE4'),
                          size: 18,
                      ),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: FadeAnimation(
                          1.4,
                          AppText(
                            txt:'${widget.description}',
                              color: HexColor('#000000'),
                              weight: FontWeight.w300,
                              size: 18,
                          ),
                        ),
                      ),
                      
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
