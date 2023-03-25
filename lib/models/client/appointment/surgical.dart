import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wgnrr/models/client/appointment/questionnaire.dart';
import 'package:wgnrr/utils/widget/text/text.dart';

class Surgical extends StatefulWidget {
  var doctor;
  var client;
  var reason;
  var date_difference;
  var language;
  Surgical({
    super.key,
    required this.client,
    required this.doctor,
    required this.reason,
    required this.date_difference,
    required this.language,
  });

  @override
  State<Surgical> createState() => _SurgicalState();
}

class _SurgicalState extends State<Surgical> {
  var pain;
  List pains = [
    'No Pain',
    'Mild',
    'Moderate',
    'Severe',
    'Very Severe',
    'Worst Pain Possible'
  ];
  var blood;
  List bloods = ['0', '1-2', 'More'];
  var fever;
  List fevers = ['Yes', 'No'];
  var smell;
  List smells = ['Yes', 'No'];
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          shadowColor: Colors.grey.shade700,
          elevation: 4,
          child: Form(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AppText(
                        txt:
                            'How much pain do you feel ${widget.date_difference} hrs after Surgical Procedure ?',
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
                      txt: widget.language == 'Kiswahili'
                          ? 'Kiwango cha Maumivu'
                          : 'Pain Level',
                      size: 15,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return widget.language == 'Kiswahili'
                            ? 'Chagua Kiasi cha maumivu unayosikia'
                            : "Please select pain level";
                      } else {
                        return null;
                      }
                    },
                    value: pain,
                    onChanged: (newValue1) {
                      setState(() {
                        pain = newValue1;
                      });
                    },
                    items: pains.map((valueItem) {
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
                            'How many pads  have you used ${widget.date_difference} hrs after Surgical Procedure?',
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
                          ? 'Kiasi cha pedi ulizotumia'
                          : 'Number of pads used',
                      size: 15,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return widget.language == 'Kiswahili'
                            ? 'Chagua Kiasi cha pedi ulizotumia'
                            : "Number of pads used";
                      } else {
                        return null;
                      }
                    },
                    value: blood,
                    onChanged: (newValue1) {
                      setState(() {
                        blood = newValue1;
                      });
                    },
                    items: bloods.map((valueItem) {
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
                            'Do you have fever ${widget.date_difference} hrs after Surgical Procedure?',
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
                    hint: AppText(
                      txt: widget.language == 'Kiswahili'
                          ? 'Una homa'
                          : 'Do you have fever',
                      size: 15,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return widget.language == 'Kiswahili'
                            ? 'Una homa'
                            : "Do you have fever";
                      } else {
                        return null;
                      }
                    },
                    value: fever,
                    onChanged: (newValue1) {
                      setState(() {
                        fever = newValue1;
                      });
                    },
                    items: fevers.map((valueItem) {
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
                        txt:
                            'Do you have foul smelling in vaginal discharge ${widget.date_difference} hrs after Surgical Procedure?',
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
                          ? 'Una homa'
                          : 'Do you have foul smell in your vaginal discharge',
                      size: 15,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return widget.language == 'Kiswahili'
                            ? 'Una homa'
                            : "Do you have foul smell in your vaginal discharge";
                      } else {
                        return null;
                      }
                    },
                    value: smell,
                    onChanged: (newValue1) {
                      setState(() {
                        smell = newValue1;
                      });
                    },
                    items: smells.map((valueItem) {
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
                if (int.parse(widget.date_difference) >= 18)
                  Questions(
                      client: widget.client,
                      doctor: widget.doctor,
                      reason: widget.reason,
                      date_difference: widget.date_difference,
                      language: widget.language)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
