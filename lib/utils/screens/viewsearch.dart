// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, duplicate_ignore, prefer_const_constructors, body_might_complete_normally_nullable, prefer_if_null_operators, no_leading_underscores_for_local_identifiers, unused_element, avoid_print, unused_label

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/chats/table/table.dart';
import 'package:wgnrr/utils/animation/fade_animation.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/utils/widget/button/button.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class Viewchoicesearch extends StatefulWidget {
  var title;
  // ignore: non_constant_identifier_names
  Viewchoicesearch({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<Viewchoicesearch> createState() => _ViewchoicesearchState();
}

class _ViewchoicesearchState extends State<Viewchoicesearch> {
  List data = [];
  Future fecth_data() async {
    const url =
        'http://localhost/wgnrr_api/choices/choices_specific_search.php';
    var response = await http.post(Uri.parse(url), body: {
      "title": widget.title.toString(),
    });
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    }
  }
  var language;
  var status;
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var l = sharedPreferences.get('language');
    var s = sharedPreferences.get('status');
    setState(() {
      language = l;
      status = s;
    });
  }

  @override
  void initState() {
    super.initState();
    fecth_data();
    getValidationData();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return data.isEmpty ? Scaffold(
      body: Center(
        child: SpinKitCircle(
        // duration: const Duration(seconds: 3),
        size: 70,
        color: HexColor('#742B90'),
      ),
      ),
    ) : Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FadeAnimation(
                1.2,
                Image.network('${murl}choices/image/${data[1]['image']}'),
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
            height: mediaQuery.size.height / 1.5,
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
                              color: HexColor('#F5841F'),
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
                            Icon(Icons.calendar_month,
                                color: HexColor('#981EE4')),
                            SizedBox(
                              width: 10,
                            ),
                            AppText(
                              txt: language == 'Kiswahili'
                                  ? 'Tarehe -${data[1]['date']}'
                                  : 'Date - ${data[1]['date']}',
                                color: HexColor('#F5841F'),
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
                            Icon(Icons.person, color: HexColor('#981EE4')),
                            SizedBox(
                              width: 10,
                            ),
                            AppText(
                              txt: language == 'Kiswahili'
                                  ? 'Mwandishi - ${data[1]['author']}'
                                  : 'Author - ${data[1]['author']}',
                                color: HexColor('#F5841F'),
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
                        txt: 'Caption',
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
                              txt: '${data[1]['caption']}',
                                color: HexColor('#F5841F'),
                                size: 15,
                                weight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      AppText(
                        txt: 'Description',
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
                            txt: '${data[1]['description']}',
                              color: HexColor('#F5841F'),
                              weight: FontWeight.w300,
                              size: 15,
                          ),
                        ),
                      ),
                      if (status != 'Health Care Providers')
                        AppButton(
                            onPress: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Chat_table())),
                            label:
                                'Click Here to chat with medical professional',
                            bcolor: HexColor('#742B90'),
                            borderCurve: 20),
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
