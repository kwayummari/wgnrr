import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/animation/shimmers/tips-shimmer.dart';
import 'package:wgnrr/utils/screens/viewstats.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  List data = [];
  Future get_datas() async {
    var l;
    if (language == 'Kiswahili') {
      setState(() {
        l = 2;
      });
    } else {
      setState(() {
        l = 1;
      });
    }
    const url = '${murl}stats/stats.php';
    var response = await http.post(Uri.parse(url), body: {
      "language": l.toString(),
    });
    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          data = json.decode(response.body);
        });
    } //
  }

  var username;
  var status;
  var language;

  Future get_username() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var u = sharedPreferences.get('username');
    var s = sharedPreferences.get('status');
    var l = sharedPreferences.get('language');
    setState(() {
      username = u;
      status = s;
      language = l;
      get_datas();
    });
  }

  Future<void> _refresh() async {
    await get_username();
  }

  @override
  void initState() {
    super.initState();
    get_username();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 207,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 8),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Title(
                    color: HexColor('#F5841F'),
                    child: AppText(
                      txt: language == 'Kiswahili' ? 'Takwimu' : 'Stats',
                      color: HexColor('#F5841F'),
                      size: 15,
                    ))),
          ),
          data.isEmpty
              ? tipShimmerLoading(
                  borderRadius: 20,
                  height: 150.0,
                  width: MediaQuery.of(context).size.width / 1.4,
                )
              : Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    primary: true,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewStats(
                                      author: data[index]['author'],
                                      caption: data[index]['caption'],
                                      date: data[index]['date'],
                                      description: data[index]['description'],
                                      title: data[index]['title'],
                                      username: username,
                                      image: data[index]['image'],
                                      reference: data[index]['reference'],
                                      language: language,
                                    )));
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Container(
                                  height: 150.0,
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color: Colors.black),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${murl}stats/image/${data[index]['image']}'),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: HexColor('#742B90')
                                            .withOpacity(0.5),
                                      ),
                                      child: AppText(
                                        txt: data[index]['title']
                                            .toString()
                                            .toUpperCase(),
                                        size: 15,
                                        weight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      size: 15,
                                      txt: language == 'Kiswahili'
                                          ? 'Soma zaidi'
                                          : 'Read More',
                                      color: HexColor('#800B24'),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: HexColor('#800B24'),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
