import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/animation/shimmers/topcircular-shimmer.dart';
import 'package:wgnrr/utils/database/initializing.dart';
import 'package:wgnrr/utils/database/models/feeds.dart';
import 'package:wgnrr/utils/screens/viewtopcircular.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class Topcircular extends StatefulWidget {
  const Topcircular({super.key});

  @override
  State<Topcircular> createState() => _TopcircularState();
}

class _TopcircularState extends State<Topcircular> {
  var data;
  var count;
  List datas = [];
  List photo = [];
  List photos = [];
  List rows = [];
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
    const url = '${murl}feeds/feeds.php';
    var response = await http.post(Uri.parse(url), body: {
      "language": l.toString(),
    });
    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          datas = json.decode(response.body);
          photo = [for (var i = 0; i < datas.length; i++) datas[i]['image']];
          addData();
        });
    } //
  }

  Future<String> convertImage(String url) async {
    http.Response response;
    final API_URL = url;
    response = await http.get(Uri.parse(API_URL));
    final img = base64Encode(response.bodyBytes);
    return img;
  }

  Future addData() async {
    for (var i = 0; i < datas.length; i++) {
      final images =
          await convertImage('${murl}feeds/image/${datas[i]['image']}');
      final feed = Feed(
          image: images,
          title: datas[i]['title'],
          date: datas[i]['date'],
          author: datas[i]['author'],
          caption: datas[i]['caption'],
          description: datas[i]['description']);
      await wgnrr.instance.create(feed);
    }
  }

  Future getData() async {
    rows = await wgnrr.instance.getRows();
    setState(() {
      rows = datas;
      photo = [
        for (var i = 0; i < datas.length; i++) base64Decode(datas[i]['image'])
      ];
    });
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
      checkConnection();
    });
  }

  var connectivityResult;
  Future checkConnection() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      get_datas();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      get_datas();
    } else {
      getData();
    }
  }

  @override
  void initState() {
    super.initState();
    get_username();
  }

  @override
  Widget build(BuildContext context) {
    return datas.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: topcircularShimmerLoading(
              borderRadius: 20,
              height: Platform.isIOS ? 200 : 170,
              width: Platform.isIOS ? 200 : 170,
            ),
          )
        : CarouselSlider(
            options: CarouselOptions(
              height: Platform.isIOS ? 200 : 170,
              aspectRatio: 16 / 9,
              viewportFraction: 0.9,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 8),
              autoPlayAnimationDuration: Duration(seconds: 5),
              autoPlayCurve: Curves.linear,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: <Widget>[
              for (var i = 0; i < photo.length; i++)
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Viewtopcircularcategory(
                              author: datas[i]['author'],
                              caption: datas[i]['caption'],
                              date: datas[i]['date'],
                              description: datas[i]['description'],
                              title: datas[i]['title'],
                              reference: datas[i]['reference'],
                              username: username,
                              image: datas[i]['image'],
                              language: language,
                            )));
                  },
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(116, 43, 144, 0.7),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(color: Colors.black),
                        ),
                        child: AppText(
                          txt: datas[i]['title'].toString().length > 40
                              ? datas[i]['title']
                                      .toString()
                                      .toUpperCase()
                                      .substring(0, 40) +
                                  '...'
                              : datas[i]['title'].toString(),
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width / 1.3,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: Colors.black),
                      image: DecorationImage(
                        image: (connectivityResult == ConnectivityResult.wifi)
                            ? NetworkImage('${murl}feeds/image/${photo[i]}')
                            : (connectivityResult == ConnectivityResult.mobile)
                                ? NetworkImage('${murl}feeds/image/${photo[i]}')
                                : MemoryImage(photos[i]) as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
            ],
          );
  }
}
