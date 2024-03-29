import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/widget/button/button.dart';
import 'package:wgnrr/utils/widget/text/text.dart';
import 'package:http/http.dart' as http;

class Appointment extends StatefulWidget {
  var doctor;
  var client;
  Appointment({Key? key, required this.client, required this.doctor});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  var option;
  List options = [];
  Future get_topics() async {
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
    const url = '${murl}choices/choices.php';
    var response = await http.post(Uri.parse(url), body: {
      "language": l.toString(),
    });
    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          options = json.decode(response.body);
        });
    }
  }

  var newdate;
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        var day = pickedDate.toString();
        var separated = day.split(" ");
        newdate = separated[0];
      });
    }
  }

  var newTime;
  TimeOfDay currentTime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if (selectedTime != null && selectedTime != currentTime) {
      setState(() {
        newTime = selectedTime.format(context);
      });
    }
  }

  Future submit_appointment(newdate, newTime) async {
    const url = '${murl}appointment/write.php';
    var response = await http.post(Uri.parse(url), body: {
      "client": username.toString(),
      "doctor": widget.doctor.toString(),
      "service": option.toString(),
      "date": newdate.toString(),
      "time": newTime.toString(),
    });
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: language == 'Kiswahili' ? 'Umetuma maombi' : 'Successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15.0,
      );
      Navigator.pop(context);
    } else {
      print(response.statusCode);
    }
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
    get_topics();
  }

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: AppText(
          txt: 'MAKE APPOINTMENT WITH ${widget.doctor.toString()}',
          color: Colors.white,
          size: 15,
        ),
        backgroundColor: HexColor('#742B90'),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                      txt: 'Select Service',
                      size: 15,
                    ),
                    value: option,
                    items: options.map((list22) {
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
                        option = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                width: 330,
                child: InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: TextFormField(
                    enabled: false,
                    cursorColor: Theme.of(context).iconTheme.color,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: newdate == null
                          ? language == 'Kiswahili'
                              ? 'Chagua tarehe'
                              : 'Select date of appointment'
                          : newdate,
                      filled: true,
                      fillColor: Colors.white,
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                      prefixIconColor: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 70,
                width: 330,
                child: InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: TextFormField(
                    enabled: false,
                    cursorColor: Theme.of(context).iconTheme.color,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: newTime == null
                          ? language == 'Kiswahili'
                              ? 'Chagua muda'
                              : 'Select appointment time'
                          : newTime,
                      filled: true,
                      fillColor: Colors.white,
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: HexColor('#000000')),
                      ),
                      prefixIcon: Icon(
                        Icons.access_time,
                        color: Colors.black,
                      ),
                      prefixIconColor: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: 330,
                child: AppButton(
                  label: language == 'Kiswahili' ? 'Kusanya Chaguo' : 'Submit',
                  onPress: () async {
                    submit_appointment(newdate, newTime);
                  },
                  bcolor: HexColor('#F5841F'),
                  borderCurve: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
