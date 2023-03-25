import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wgnrr/utils/widget/button/button.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class Questions extends StatefulWidget {
  var doctor;
  var client;
  var reason;
  var date_difference;
  var language;
  Questions({
    super.key,
    required this.client,
    required this.doctor,
    required this.reason,
    required this.date_difference,
    required this.language,
  });

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  var one;
  List ones = [
    'As much as I always could',
    'Not quite so much now',
    'Definitely not so much now',
    'Not at all',
  ];
  var two;
  List twos = [
    'As much as I ever did',
    'Rather less than I used',
    'Definitely less than I used to',
    'Hardly at all'
  ];
  var three;
  List threes = [
    'Yes, most of the time',
    'Yes, some of the time',
    'Not very often',
    'No never'
  ];
  var four;
  List fours = [
    'No, not at all',
    'Hardly ever',
    'Yes, sometimes',
    'Yes, very often'
  ];
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              AppText(
                txt: 'Emotional Questionnaire',
                size: 15,
                weight: FontWeight.w700,
                textdecoration: TextDecoration.underline,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                      txt:
                          'Have you been able to laugh and see funny side of things',
                      weight: FontWeight.w500,
                      size: 15),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                alignment: Alignment.center,
                height: 60,
                width: 330,
                child: DropdownButtonFormField(
                  elevation: 10,
                  menuMaxHeight: 330,
                  isExpanded: true,
                  focusColor: Colors.white,
                  decoration: InputDecoration(
                    border: InputBorder.none,
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
                      Icons.leak_remove,
                      color: Colors.black,
                    ),
                    prefixIconColor: Colors.black,
                  ),
                  hint: AppText(
                    txt: widget.language == 'Kiswahili' ? 'Select' : 'Chagua',
                    size: 15,
                  ),
                  validator: (value) {
                    if (value == null) {
                      return widget.language == 'Kiswahili'
                          ? 'Tafadhali chagua'
                          : "Please select";
                    } else {
                      return null;
                    }
                  },
                  value: one,
                  onChanged: (newValue1) {
                    setState(() {
                      one = newValue1;
                    });
                  },
                  items: ones.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: AppText(
                        txt: valueItem != null ? valueItem : 'default value',
                        size: 15,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                      txt:
                          'I have looked forward with enjoyment to this things',
                      weight: FontWeight.w500,
                      size: 15),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                alignment: Alignment.center,
                height: 60,
                width: 330,
                child: DropdownButtonFormField(
                  elevation: 10,
                  menuMaxHeight: 330,
                  isExpanded: true,
                  focusColor: Colors.white,
                  decoration: InputDecoration(
                    border: InputBorder.none,
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
                      Icons.padding,
                      color: Colors.black,
                    ),
                    prefixIconColor: Colors.black,
                  ),
                  hint: AppText(
                    txt: widget.language == 'Kiswahili'
                        ? 'Tafadhali chagua'
                        : 'Please select',
                    size: 15,
                  ),
                  validator: (value) {
                    if (value == null) {
                      return widget.language == 'Kiswahili'
                          ? 'Tafadhali jaza'
                          : 'Please select';
                    } else {
                      return null;
                    }
                  },
                  value: two,
                  onChanged: (newValue1) {
                    setState(() {
                      two = newValue1;
                    });
                  },
                  items: twos.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: AppText(
                        txt: valueItem != null ? valueItem : 'default value',
                        size: 15,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                      txt: 'I have blamed myself unnecessarily when things',
                      weight: FontWeight.w500,
                      size: 15),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                alignment: Alignment.center,
                height: 60,
                width: 330,
                child: DropdownButtonFormField(
                  elevation: 10,
                  menuMaxHeight: 330,
                  isExpanded: true,
                  focusColor: Colors.white,
                  decoration: InputDecoration(
                    border: InputBorder.none,
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
                      Icons.thermostat,
                      color: Colors.black,
                    ),
                    prefixIconColor: Colors.black,
                  ),
                  validator: (value) {
                    if (value == null) {
                      return widget.language == 'Kiswahili'
                          ? 'Please select'
                          : 'Tafadhali chagua';
                    } else {
                      return null;
                    }
                  },
                  value: three,
                  onChanged: (newValue1) {
                    setState(() {
                      three = newValue1;
                    });
                  },
                  items: threes.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: AppText(
                        txt: valueItem != null ? valueItem : 'default value',
                        size: 15,
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                      txt: 'I have been anxious or worried for no good reasons',
                      weight: FontWeight.w500,
                      size: 15),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                alignment: Alignment.center,
                height: 60,
                width: 330,
                child: DropdownButtonFormField(
                  elevation: 10,
                  menuMaxHeight: 330,
                  isExpanded: true,
                  focusColor: Colors.white,
                  decoration: InputDecoration(
                    border: InputBorder.none,
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
                      Icons.smoke_free,
                      color: Colors.black,
                    ),
                    prefixIconColor: Colors.black,
                  ),
                  hint: AppText(
                    txt: widget.language == 'Kiswahili'
                        ? 'Tafaddhali chagua'
                        : 'Please select',
                    size: 15,
                  ),
                  validator: (value) {
                    if (value == null) {
                      return widget.language == 'Kiswahili'
                          ? 'Tafadhali chagua'
                          : "Please select";
                    } else {
                      return null;
                    }
                  },
                  value: four,
                  onChanged: (newValue1) {
                    setState(() {
                      four = newValue1;
                    });
                  },
                  items: fours.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: AppText(
                        txt: valueItem != null ? valueItem : 'default value',
                        size: 15,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 330,
                height: 50,
                child: AppButton(
                    onPress: () {},
                    label: 'Submit',
                    bcolor: HexColor('#F5841F'),
                    borderCurve: 20),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
