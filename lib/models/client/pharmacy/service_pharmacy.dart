import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/models/health_care_provider/chats/table/table.dart';
import 'package:wgnrr/utils/widget/drawer/app_drawer.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class servicesChoices_pharmacy extends StatefulWidget {
  var facility_name;
  servicesChoices_pharmacy({Key? key, required this.facility_name});

  @override
  State<servicesChoices_pharmacy> createState() =>
      _servicesChoices_pharmacyState();
}

class _servicesChoices_pharmacyState extends State<servicesChoices_pharmacy> {
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
      get_doctor();
    });
  }

  TextEditingController option = TextEditingController();

  var doctor;
  List doctors = [];
  Future get_doctor() async {
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
    const url = '${murl}hcp/hcp_check.php';
    var response = await http.post(Uri.parse(url), body: {
      "facility": widget.facility_name.toString(),
    });
    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          doctors = json.decode(response.body);
        });
    }
  }

  Future create_chat() async {
    const url = '${murl}chats_pharmacy/create_chat.php';
    var response = await http.post(Uri.parse(url), body: {
      "client": username.toString(),
      "doctor": doctor.toString(),
      "topics": 'medicine'.toString(),
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data == "1") {
        setState(() {
          isloading = false;
        });
        Fluttertoast.showToast(
          msg: language == 'Kiswahili'
              ? 'Imepatikana'
              : 'Chats available chat box',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0,
        );
        Navigator.pop(context);
      } else if (data == "2") {
        setState(() {
          isloading = false;
        });
        Fluttertoast.showToast(
          msg: language == 'Kiswahili'
              ? 'Umefanikiwa'
              : 'Succefully generated chats',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15.0,
        );
        Navigator.pop(context);
      } else if (data == "3") {
        setState(() {
          isloading = false;
        });
        Fluttertoast.showToast(
          msg: language == 'Kiswahili' ? 'Kuna tatizo' : 'There was a problem',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0,
        );
      }
    } else {
      print(response.body.toString());
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  bool isloading = false;
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: AppDrawer(
        username: username,
        language: language,
        status: status,
      ),
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
            style: GoogleFonts.vesperLibre(
                fontSize: 15,
                color: HexColor('#ffffff'),
                fontWeight: FontWeight.w500)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 16),
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      color: HexColor('#f0f0f0'),
                      border: Border.all(color: HexColor("#415812"), width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButtonFormField(
                    menuMaxHeight: 300,
                    isExpanded: true,
                    focusColor: Colors.white,
                    dropdownColor: Colors.white,
                    style: TextStyle(color: Colors.black, fontSize: 22),
                    decoration: InputDecoration(
                      hoverColor: null,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                    // underline: SizedBox(),
                    hint: Text(
                      'Select Health Care Provider',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                    value: doctor,
                    items: doctors.map((list22) {
                      return DropdownMenuItem(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: AppText(
                                txt: list22['username'],
                                size: 15,
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                        value: list22['username'],
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        doctor = value;
                      });
                    },
                  ),
                ),
              ),
              isloading == true
                  ? SpinKitCircle(
                      // duration: const Duration(seconds: 3),
                      // size: 100,
                      color: HexColor('#F5841F'),
                    )
                  : Container(
                      width: 360,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          foregroundColor: HexColor('#742B90'),
                          backgroundColor: HexColor('#742B90'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                              side: BorderSide(color: Colors.black)),
                        ),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          setState(() {
                            isloading = true;
                          });
                          create_chat();
                        },
                        child: AppText(
                          txt: "Submit",
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
