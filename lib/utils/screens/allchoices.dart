// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, duplicate_ignore, prefer_const_constructors, body_might_complete_normally_nullable, prefer_if_null_operators, no_leading_underscores_for_local_identifiers, unused_element, avoid_print, unused_label

import 'dart:convert';
import 'dart:io';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/animation/shimmers/allchoices-shimmer.dart';
import 'package:wgnrr/utils/animation/shimmers/image-shimmer.dart';
import 'package:wgnrr/utils/screens/comment/comment.dart';
import 'package:wgnrr/utils/screens/viewchoice.dart';
import 'package:wgnrr/utils/screens/viewsearch.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

enum MenuItem {
  item1,
  item2,
  item3,
  item4,
}

List datas = [];

class All extends StatefulWidget {
  var id;
  var title;
  // ignore: non_constant_identifier_names
  All({Key? key, required this.id, required this.title}) : super(key: key);

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
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
      fecth_data();
    });
  }

  List data = [];
  Future fecth_data() async {
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
    const url = '${murl}choices/choices_specific.php';
    var response = await http.post(Uri.parse(url), body: {
      "category_id": widget.id.toString(),
      "language": l.toString(),
    });
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        for (int i = 0; i < data.length; i++) {
          datas.add(data[i]['name']);
        }
      });
    }
  }

  Future<Widget> Count(choice_id, choice_specific_id) async {
    List sourcename = [];
    const url = '${murl}comment/comment.php';
    var response = await http.post(Uri.parse(url), body: {
      "choice_id": choice_id.toString(),
      "choice_specific_id": choice_specific_id.toString()
    });
    if (response.statusCode == 200) {
      setState(() {
        sourcename = json.decode(response.body);
      });
    }
    return Text(
      sourcename.length.toString(),
      textScaleFactor: 1.3,
      textAlign: TextAlign.center,
    );
  }

  Future<Widget> checkvp(link) async {
    var file_type = lookupMimeType(link);
    final names = file_type.toString().split("/");
    final type = names[0];
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: MyImageWidget(
        imageUrl: link,
        width: MediaQuery.of(context).size.width,
        height: 300,
      ),
    );
  }

  TextEditingController search = TextEditingController();
  @override
  void initState() {
    super.initState();
    getValidationData();
    update();
  }

  List updates = [];
  Future update() async {
    http.Response response;
    const url = '${murl}version/get.php';
    var response1 = await http.get(Uri.parse(url));
    if (response1.statusCode == 200) {
      if (mounted)
        setState(() {
          updates = json.decode(response1.body);
        });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: updates.isNotEmpty
          ? AppDrawer(
              username: username,
              language: language,
              status: status,
              update: updates[0]['version'],
            )
          : null,
      appBar: AppBar(
        leading: Builder(
            builder: (context) => // Ensure Scaffold is in context
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                )),
        automaticallyImplyLeading: false,
        shape: Border(bottom: BorderSide(color: Colors.orange, width: 0.2)),
        elevation: 4,
        toolbarHeight: 70,
        backgroundColor: HexColor('#742B90'),
        title: AppText(
          txt: language == 'Kiswahili'
              ? 'Karibu ${username}'
              : 'Welcome ${username}',
          size: 15,
          color: HexColor('#ffffff'),
          weight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          data.isEmpty
              ? allchoicesShimmerLoading(
                  borderRadius: 20,
                  commentheight: 20,
                  commentwidth: MediaQuery.of(context).size.width,
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                )
              : Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: Image.asset('assets/icon.ico')),
                              AppText(
                                txt: 'MimiCare',
                                color: Colors.black,
                                size: 15,
                                weight: FontWeight.w500,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FutureBuilder<Widget>(
                            future: checkvp(
                              '${murl}choices/image/${data[index]['image']}',
                            ),
                            builder: (BuildContext _, snapshot) {
                              if (snapshot.hasError) {
                                // Error
                                return Text('', textScaleFactor: 1);
                              } else if (!(snapshot.hasData)) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                    child: Icon(Icons.error),
                                  ),
                                );
                              }
                              return Center(child: snapshot.data);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(children: [
                              IconButton(
                                  onPressed: () async {
                                    final urlImage =
                                        '${murl}choices/image/${data[index]['image']}';
                                    final url = Uri.parse(urlImage);
                                    final response = await http.get(url);
                                    final bytes = response.bodyBytes;

                                    final temp = await getTemporaryDirectory();
                                    final path = '${temp.path}/image.jpg';
                                    File(path).writeAsBytesSync(bytes);

                                    await Share.shareXFiles([XFile(path)],
                                        text:
                                            '${data[index]['name']} \n ${data[index]['caption']} \n wgnrr.org');
                                  },
                                  icon: Icon(
                                    Icons.share_rounded,
                                    color: HexColor('#742B90'),
                                  )),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Viewchoice(
                                            author: data[index]['author'],
                                            caption: data[index]['caption'],
                                            date: data[index]['date'],
                                            description: data[index]
                                                ['description'],
                                            title: data[index]['name'],
                                            username: username,
                                            image: data[index]['image'],
                                            reference: data[index]['reference'],
                                            language: language,
                                          )));
                                },
                                icon: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: ((context) => Comment(
                                                  choice_id: widget.id,
                                                  title: data[index]['name'],
                                                  choice_specific_id:
                                                      data[index]['id'],
                                                ))));
                                  },
                                  child: Badge(
                                    backgroundColor: HexColor('#f5841f'),
                                    label: FutureBuilder<Widget>(
                                      future: Count(
                                        widget.id,
                                        data[index]['id'],
                                      ),
                                      builder: (BuildContext _, snapshot) {
                                        if (snapshot.hasError) {
                                          // Error
                                          return Text('', textScaleFactor: 1);
                                        } else if (!(snapshot.hasData)) {
                                          return Text('');
                                        }
                                        return Center(child: snapshot.data);
                                      },
                                    ),
                                    child: Icon(
                                      Icons.chat_bubble,
                                      color: HexColor('#742B90'),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: HexColor('#742B90'),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(
                                            color: Colors.grey.shade500))
                                    // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                                    ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Viewchoice(
                                            author: data[index]['author'],
                                            caption: data[index]['caption'],
                                            date: data[index]['date'],
                                            description: data[index]
                                                ['description'],
                                            title: data[index]['name'],
                                            username: username,
                                            image: data[index]['image'],
                                            reference: data[index]['reference'],
                                            language: language,
                                          )));
                                },
                                child: AppText(
                                  txt: 'View',
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Viewchoice(
                                          author: data[index]['author'],
                                          caption: data[index]['caption'],
                                          date: data[index]['date'],
                                          description: data[index]
                                              ['description'],
                                          reference: data[index]['reference'],
                                          title: data[index]['name'],
                                          username: username,
                                          image: data[index]['image'],
                                          language: language,
                                        )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AppText(
                                      txt: data[index]['name'].toUpperCase(),
                                      size: 15,
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      );
                    },
                    itemCount: data.length,
                  ),
                ),
        ],
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  List searchResult = datas;
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back));
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: Icon(Icons.cancel))
      ];
  @override
  Widget buildResults(BuildContext context) => Center(
        child: AppText(
          txt: query,
          color: Colors.black,
          size: 15,
        ),
      );
  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestions = searchResult.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
              showResults(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Viewchoicesearch(
                        title: suggestion,
                      )));
            },
          );
        });
  }
}
