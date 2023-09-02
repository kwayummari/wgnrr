import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/client/open_chat/table.dart';
import 'package:wgnrr/utils/widget/button/button.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class medication extends StatefulWidget {
  const medication({super.key});

  @override
  State<medication> createState() => _medicationState();
}

class _medicationState extends State<medication> {
  @override
  void initState() {
    super.initState();
    getValidationData();
    update();
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

  setAlarm() async {
    var tabs;
    var hours;
    var next_time;
    if (drug == 'Paracetamol') {
      if (pth == '1 tablet every 8 hours') {
        DateTime now = DateTime.now();
        setState(() {
          tabs = '1';
          hours = 8;
          next_time == now.add(Duration(hours: hours)).toIso8601String();
        });
      } else if (pth == '2 tablet every 8 hours') {
        DateTime now = DateTime.now();
        setState(() {
          tabs = '2';
          hours = 8;
          next_time == now.add(Duration(hours: hours)).toIso8601String();
        });
      } else if (pth == '2 tablet every 6 hours') {
        DateTime now = DateTime.now();
        setState(() {
          tabs = '1';
          hours = 6;
          next_time == now.add(Duration(hours: hours)).toIso8601String();
        });
      }
    } else {
      if (mth ==
          '4 tabs every 3 hours, max 3doses, (total of 12 tablets) administered sublingually, buccal or vaginally') {
        DateTime now = DateTime.now();
        setState(() {
          tabs = '4';
          hours = 3;
          next_time == now.add(Duration(hours: hours)).toIso8601String();
        });
      } else if (mth ==
          '3 tabs every 3 hours, max 2doses (total of 6 tablets) administered sublingually.') {
        DateTime now = DateTime.now();
        setState(() {
          tabs = '3';
          hours = 3;
          next_time == now.add(Duration(hours: hours)).toIso8601String();
        });
      }
    }
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('tabs', tabs);
    sharedPreferences.setString('hours', tabs);
    sharedPreferences.setString('next_time', next_time);
    sharedPreferences.setString('isMedication', '1');
    Navigator.pop(context);
  }

  var isDoctor;
  List doctors = [
    {'name': 'Yes'},
    {'name': 'No'}
  ];
  var drug;
  List drugs = [
    {'name': 'Paracetamol'},
    {'name': 'Misoprostol'}
  ];
  var pth;
  List pths = [
    {'name': '1 tablet every 8 hours'},
    {'name': '2 tablet every 8 hours'},
    {'name': '2 tablet every 6 hours'}
  ];
  var mth;
  List mths = [
    {
      'name':
          '4 tabs every 3 hours, max 3doses, (total of 12 tablets) administered sublingually, buccal or vaginally'
    },
    {
      'name':
          '3 tabs every 3 hours, max 2doses (total of 6 tablets) administered sublingually.'
    },
  ];

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
        title: Text(
            language == 'Kiswahili'
                ? 'Karibu ${username}'
                : 'Welcome ${username}',
            style: TextStyle(
                fontSize: 15,
                color: HexColor('#ffffff'),
                fontWeight: FontWeight.w500)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Community())),
            icon: Image.asset(
              'assets/community.png',
              height: 40,
            ),
          )
          // : Container()
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            AppText(
              txt: 'Please fill the  form below',
              size: 15,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: 330,
                child: DropdownButtonFormField(
                  menuMaxHeight: 300,
                  isExpanded: true,
                  focusColor: Colors.white,
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    hoverColor: null,
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: HexColor('#000000')),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: HexColor('#000000')),
                    ),
                    errorBorder: InputBorder.none,
                  ),
                  hint: AppText(
                    txt: 'Prescribed by the doctor?',
                    size: 15,
                  ),
                  value: isDoctor,
                  items: doctors.map((list22) {
                    return DropdownMenuItem(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              txt: list22['name'],
                              size: 15,
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          )
                        ],
                      ),
                      value: list22['name'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      isDoctor = value;
                    });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: 330,
                child: DropdownButtonFormField(
                  menuMaxHeight: 300,
                  isExpanded: true,
                  focusColor: Colors.white,
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    hoverColor: null,
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: HexColor('#000000')),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: HexColor('#000000')),
                    ),
                    errorBorder: InputBorder.none,
                  ),
                  hint: AppText(
                    txt: 'Name of the drug',
                    size: 15,
                  ),
                  value: drug,
                  items: drugs.map((list22) {
                    return DropdownMenuItem(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              txt: list22['name'],
                              size: 15,
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          )
                        ],
                      ),
                      value: list22['name'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      drug = value;
                    });
                  },
                ),
              ),
            ),
            if (drug == 'Paracetamol')
              Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  height: 70,
                  width: 330,
                  child: DropdownButtonFormField(
                    menuMaxHeight: 300,
                    isExpanded: true,
                    focusColor: Colors.white,
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      hoverColor: null,
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      errorBorder: InputBorder.none,
                    ),
                    hint: AppText(
                      txt: 'Number of tablets prescribed',
                      size: 15,
                    ),
                    value: pth,
                    items: pths.map((list22) {
                      return DropdownMenuItem(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: AppText(
                                txt: list22['name'],
                                size: 15,
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                        value: list22['name'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        pth = value;
                      });
                    },
                  ),
                ),
              ),
            if (drug == 'Misoprostol')
              Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  height: 70,
                  width: 330,
                  child: DropdownButtonFormField(
                    menuMaxHeight: 300,
                    isExpanded: true,
                    focusColor: Colors.white,
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      hoverColor: null,
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      errorBorder: InputBorder.none,
                    ),
                    hint: AppText(
                      txt: 'Number of tablets prescribed',
                      size: 15,
                    ),
                    value: mth,
                    items: mths.map((list22) {
                      return DropdownMenuItem(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: AppText(
                                txt: list22['name'],
                                size: 15,
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                        value: list22['name'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        mth = value;
                      });
                    },
                  ),
                ),
              ),
            Container(
              height: 60,
              width: 330,
              child: AppButton(
                label: language == 'Kiswahili' ? 'Kusanya Chaguo' : 'Submit',
                onPress: () async {
                  if ((pth != null || mth != null) && isDoctor != null ||
                      drug != null) {
                    setAlarm();
                  }
                },
                bcolor: HexColor('#F5841F'),
                borderCurve: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
