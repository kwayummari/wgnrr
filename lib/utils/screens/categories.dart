import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/animation/shimmers/tips-shimmer.dart';
import 'package:wgnrr/utils/screens/views.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

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

  Future<void> _refresh() async {
    await get_username();
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
                    child: AppText(
                      txt: language == 'Kiswahili' ? 'Majarida' : 'Daily Tips',
                          color: HexColor('#F5841F'), size: 15,
                    ))),
          ),
          data.isEmpty ? tipShimmerLoading(borderRadius: 20, height: 125.0, width: MediaQuery.of(context).size.width / 2.4,) : Expanded(
            child: StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 10)).asyncMap(
            (i) => get_username()), // i is null here (check periodic docs)
        builder: (context, snapshot) => ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Views(
                                author: data[index]['author'],
                                caption: data[index]['caption'],
                                date: data[index]['date'],
                                description: data[index]['description'],
                                title: data[index]['title'],
                                username: username,
                                image: data[index]['image'], language: language,
                              )));
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Container(
                            height: 125.0,
                            width: MediaQuery.of(context).size.width / 2.4,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(color: Colors.black),
                              image: DecorationImage(
                                image: NetworkImage(
                                    '${murl}categories/image/${data[index]['image']}'),
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
                              : data[index]['name'].toString(),
                          style: TextStyle(overflow: TextOverflow.ellipsis),
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
            ),)
          ),
        ],
      ),
    );
  }
}
