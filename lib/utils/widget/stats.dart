import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/widget/animation/refresh_widget.dart';
import 'package:wgnrr/utils/widget/view/viewstats.dart';

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

  Future load_list() async {
    await Future.delayed(Duration(milliseconds: 1000));
    get_username();
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
                    child: Text(
                      language == 'Kiswahili' ? 'Takwimu' : 'Stats',
                      style:
                          TextStyle(color: HexColor('#F5841F'), fontSize: 15),
                    ))),
          ),
          Expanded(
            child: RefreshWidget(
              onRefresh: () => _refresh(),
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
                                )));
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Container(
                              height: 140.0,
                              width: MediaQuery.of(context).size.width / 2.4,
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
                            ),
                          ),
                          Text(
                            data[index]['title'].toString().length > 20
                                ? data[index]['title']
                                        .toString()
                                        .substring(0, 20) +
                                    '...'
                                : data[index]['title'].toString(),
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  language == 'Kiswahili'
                                      ? 'Soma zaidi'
                                      : 'Read More',
                                  style: TextStyle(color: HexColor('#800B24')),
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
          ),
        ],
      ),
    );
  }
}
