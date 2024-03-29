// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/health_care_provider/pharmacy/chatsp.dart';
import 'package:wgnrr/utils/animation/shimmers/info-shimmer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class list_chats_pharmacys extends StatefulWidget {
  const list_chats_pharmacys({super.key});

  @override
  State<list_chats_pharmacys> createState() => _list_chats_pharmacysState();
}

class _list_chats_pharmacysState extends State<list_chats_pharmacys> {
  var chat;
  List chats = [];

  Future get_chats() async {
    const url = '${murl}chats_pharmacy/chatsp.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "username": username.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          chats = json.decode(response1.body);
        });
    }
  }

  Future send_rates(rating, id) async {
    String rate = "$rating";
    String ids = "$id";
    const url = '${murl}rate/rate_write.php';
    var response1 = await http.post(Uri.parse(url), body: {
      "id": ids.toString(),
      "rating": rate.toString(),
    });
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          get_chats();
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
    get_chats();
  }

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  TextEditingController comments = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return chats.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
                SizedBox(
                  height: 20,
                ),
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
                SizedBox(
                  height: 20,
                ),
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
                SizedBox(
                  height: 20,
                ),
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
                SizedBox(
                  height: 20,
                ),
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
                SizedBox(
                  height: 20,
                ),
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
                SizedBox(
                  height: 20,
                ),
                infoShimmerLoading(width: 400, height: 50, borderRadius: 0),
              ],
            ),
          )
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Chatsp(
                            client: chats[index]['client'],
                            doctor: chats[index]['doctor'],
                          )));
                },
                child: Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: HexColor('#742B90')),
                  ),
                  child: ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          radius: 20.0,
                          child: AppText(
                              color: Colors.black,
                              txt: chats[index]['client'].substring(0, 2),
                              size: 15)),
                      title: AppText(
                        txt: chats[index]['client'],
                        size: 15,
                      ),
                      trailing: double.parse(chats[index]['rate']) > 0
                          ? Text(chats[index]['rate'].toString())
                          : InkWell(
                              onTap: () {
                                showCupertinoDialog(
                                    context: context,
                                    builder: ((context) => Center(
                                            child: RatingBar.builder(
                                          initialRating: 1,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: HexColor('#742B90'),
                                          ),
                                          onRatingUpdate: (rating) {
                                            send_rates(
                                              rating,
                                              chats[index]['id'],
                                            );
                                            Navigator.pop(context);
                                            get_chats();
                                          },
                                        ))));
                              },
                              child: Icon(Icons.star),
                            )),
                ),
              );
            },
            itemCount: chats == null ? 0 : chats.length,
          );
  }
}
