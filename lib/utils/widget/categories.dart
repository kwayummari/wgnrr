import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/widget/view/views.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
    const url = '${murl}categories/categories.php';
    var response = await http.post(Uri.parse(url), body: {
      "language": l.toString(),
    });
    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          data = json.decode(response.body);
        });
    }
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
                      language == 'Kiswahili' ? 'Majarida' : 'Daily Tips',
                      style:
                          TextStyle(color: HexColor('#F5841F'), fontSize: 15),
                    ))),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => View(
                                author: data[index]['author'],
                                caption: data[index]['caption'],
                                date: data[index]['date'],
                                description: data[index]['description'],
                                title: data[index]['title'],
                                username: username,
                                image: data[index]['image'],
                              )));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(color: Colors.black)),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.network(
                              '${murl}categories/image/${data[index]['image']}',
                              height: 100,
                              width: 100,
                            ),
                          ),
                          Text(
                            data[index]['title'].toString().length > 10
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
