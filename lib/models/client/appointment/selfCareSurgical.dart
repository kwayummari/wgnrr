import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wgnrr/api/const.dart';
import 'package:wgnrr/utils/widget/button/button.dart';
import 'package:wgnrr/utils/widget/text/text.dart';
import 'package:http/http.dart' as http;
import 'package:wgnrr/utils/widget/textformfield/textformfield.dart';

class SurgicalSelfCare extends StatefulWidget {
  var doctor;
  var client;
  var reason;
  var language;
  SurgicalSelfCare({
    super.key,
    required this.client,
    required this.doctor,
    required this.reason,
    required this.language,
  });

  @override
  State<SurgicalSelfCare> createState() => _SurgicalSelfCareState();
}

var date_difference = 0;

class _SurgicalSelfCareState extends State<SurgicalSelfCare> {
  Future submit() async {
    if (pain == 'assets/noPain.jpg') {
      setState(() {
        pain = 'No Pain';
      });
    } else if (pain == 'assets/mild.jpg') {
      setState(() {
        pain = 'Mild';
      });
    } else if (pain == 'assets/moderate.jpg') {
      setState(() {
        pain = 'Moderate';
      });
    } else if (pain == 'assets/severe.jpg') {
      setState(() {
        pain = 'Severe';
      });
    } else if (pain == 'assets/verySevere.jpg') {
      setState(() {
        pain = 'Very Severe';
      });
    } else if (pain == 'assets/worst.jpg') {
      setState(() {
        pain = 'Worst Pain Possible';
      });
    }
    if (totalQuestions == null) {
      const url = '${murl}appointment/write_appointment.php';
      var response1 = await http.post(Uri.parse(url), body: {
        "client": widget.client.toString(),
        "doctor": widget.doctor.toString(),
        "procedure": widget.reason.toString(),
        "timeline": date_difference.toString(),
        "pain": pain.toString(),
        "blood": blood.toString(),
        "fever": fever.toString(),
        "smell": smell.toString(),
        "questionare": '-'.toString(),
      });
      if (response1.statusCode == 200) {
        Fluttertoast.showToast(
          msg: widget.language == 'Kiswahili' ? 'Imefanikiwa' : 'Successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0,
        );
        Navigator.pop(context);
      }
    } else {
      const url = '${murl}appointment/write_appointment.php';
      var response1 = await http.post(Uri.parse(url), body: {
        "client": widget.client.toString(),
        "doctor": widget.doctor.toString(),
        "procedure": widget.reason.toString(),
        "timeline": date_difference.toString(),
        "pain": pain.toString(),
        "blood": blood.toString(),
        "fever": fever.toString(),
        "smell": smell.toString(),
        "questionare": totalQuestions.toString(),
      });
      if (response1.statusCode == 200) {
        Fluttertoast.showToast(
          msg: widget.language == 'Kiswahili' ? 'Imefanikiwa' : 'Successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0,
        );
        Navigator.pop(context);
      }
    }
  }

  var question1;
  var question2;
  var question3;
  var question4;
  var question5;
  var question6;
  var question7;
  var question8;
  var question9;
  var question10;

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
  var five;
  List fives = [
    'Yes, quite a lot',
    'Yes,sometimes',
    'No, not much',
    'No, not at all'
  ];
  var six;
  List sixs = [
    'Yes, most of the time I haven\'t been able to cope at all',
    'Yes, sometimes I haven\'t been coping as well as usual',
    'No, most of the time I have coped quite well',
    'No, I have been coping ass well as ever'
  ];
  var seven;
  List sevens = [
    'Yes, most of the time',
    'Yes, sometimes',
    'Not, very often',
    'No not at all'
  ];
  var eight;
  List eights = [
    'Yes, most of the time',
    'Yes, quiet often',
    'Not very often',
    'No, not at all'
  ];
  var nine;
  List nines = [
    'Yes, most of the time',
    'Yes, quite often',
    'Only occasionally',
    'No never'
  ];
  var ten;
  List tens = ['Yes, quite often', 'Sometimes', 'Hardly ever', 'Never'];

  var totalQuestions;
  sum() {
    setState(() {
      totalQuestions = question1 +
          question2 +
          question3 +
          question4 +
          question5 +
          question6 +
          question7 +
          question8 +
          question9 +
          question10;
    });
  }

  var pain;
  List pains = [
    'assets/noPain.jpg',
    'assets/mild.jpg',
    'assets/moderate.jpg',
    'assets/severe.jpg',
    'assets/verySevere.jpg',
    'assets/worst.jpg'
  ];
  var blood;
  List bloods = ['0', '1-2', '2-3', '3-4', 'More'];
  var fever;
  List fevers = ['Yes', 'No'];
  var smell;
  List smells = ['Yes', 'No'];
  TextEditingController timeOfProcedure = TextEditingController();
  var tProcedure;
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
                AppText(
                  txt: 'Fill the timeline since the procedure',
                  size: 15,
                  weight: FontWeight.w700,
                  textdecoration: TextDecoration.underline,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, bottom: 10, top: 10, right: 30),
                  child: AppTextformfield(
                    type: TextInputType.number,
                    textfieldcontroller: timeOfProcedure,
                    onChange: (value) => {
                      setState(() {
                        date_difference = int.parse(value);
                      }),
                    },
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    label: 'Time since procedure in hours',
                    language: 'English',
                    obscure: false,
                  ),
                ),
                AppText(
                  txt: 'Physical Questionnaire',
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
                            'How much pain do you feel ${date_difference} hrs after Surgical Procedure ?',
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
                        child: Image.asset(valueItem),
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
                            'How many pads/kanga/kitenge  have you used ${date_difference} hrs after Surgical Procedure?',
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
                            'Do you have fever ${date_difference ?? 0} hrs after Surgical Procedure?',
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
                            'Do you have foul smelling in vaginal discharge ${date_difference ?? 0} hrs after Surgical Procedure?',
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
                if (int.parse(date_difference.toString()) >= 168)
                  Align(
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
                              padding:
                                  const EdgeInsets.only(left: 30, bottom: 10),
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
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.leak_remove,
                                    color: Colors.black,
                                  ),
                                  prefixIconColor: Colors.black,
                                ),
                                hint: AppText(
                                  txt: widget.language == 'Kiswahili'
                                      ? 'Select'
                                      : 'Chagua',
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
                                    if (newValue1 ==
                                        'As much as I always could') {
                                      setState(() {
                                        question1 = 0;
                                      });
                                    } else if (newValue1 ==
                                        'Not quite so much now') {
                                      setState(() {
                                        question1 = 1;
                                      });
                                    } else if (newValue1 ==
                                        'Definitely not so much now') {
                                      setState(() {
                                        question1 = 2;
                                      });
                                    } else if (newValue1 == 'Not at all') {
                                      setState(() {
                                        question1 = 3;
                                      });
                                    }
                                  });
                                },
                                items: ones.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: AppText(
                                      txt: valueItem != null
                                          ? valueItem
                                          : 'default value',
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
                              padding:
                                  const EdgeInsets.only(left: 30, bottom: 10),
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
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
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
                                  if (newValue1 == 'As much as I ever did') {
                                    setState(() {
                                      question2 = 0;
                                    });
                                  } else if (newValue1 ==
                                      'Rather less than I used') {
                                    setState(() {
                                      question2 = 1;
                                    });
                                  } else if (newValue1 ==
                                      'Definitely less than I used to') {
                                    setState(() {
                                      question2 = 2;
                                    });
                                  } else if (newValue1 == 'Hardly at all') {
                                    setState(() {
                                      question2 = 3;
                                    });
                                  }
                                },
                                items: twos.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: AppText(
                                      txt: valueItem != null
                                          ? valueItem
                                          : 'default value',
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
                              padding:
                                  const EdgeInsets.only(left: 30, bottom: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AppText(
                                    txt:
                                        'I have blamed myself unnecessarily when things',
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
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
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
                                  if (newValue1 == 'No never') {
                                    setState(() {
                                      question3 = 0;
                                    });
                                  } else if (newValue1 == 'Not very often') {
                                    setState(() {
                                      question3 = 1;
                                    });
                                  } else if (newValue1 ==
                                      'Yes, some of the time') {
                                    setState(() {
                                      question3 = 2;
                                    });
                                  } else if (newValue1 ==
                                      'Yes, most of the time') {
                                    setState(() {
                                      question3 = 3;
                                    });
                                  }
                                },
                                items: threes.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: AppText(
                                      txt: valueItem != null
                                          ? valueItem
                                          : 'default value',
                                      size: 15,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, bottom: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AppText(
                                    txt:
                                        'I have been anxious or worried for no good reasons',
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
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
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
                                  if (newValue1 == 'No, not at all') {
                                    setState(() {
                                      question4 = 0;
                                    });
                                  } else if (newValue1 == 'Hardly ever') {
                                    setState(() {
                                      question4 = 1;
                                    });
                                  } else if (newValue1 == 'Yes, sometimes') {
                                    setState(() {
                                      question4 = 2;
                                    });
                                  } else if (newValue1 == 'Yes, very often') {
                                    setState(() {
                                      question4 = 3;
                                    });
                                  }
                                },
                                items: fours.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: AppText(
                                      txt: valueItem != null
                                          ? valueItem
                                          : 'default value',
                                      size: 15,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, bottom: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AppText(
                                    txt:
                                        'I have felt scared or panicky for no very good reason',
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
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
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
                                value: five,
                                onChanged: (newValue1) {
                                  setState(() {
                                    five = newValue1;
                                  });
                                  if (newValue1 == 'No, not at all') {
                                    setState(() {
                                      question5 = 0;
                                    });
                                  } else if (newValue1 == 'No, not much') {
                                    setState(() {
                                      question5 = 1;
                                    });
                                  } else if (newValue1 == 'Yes,sometimes') {
                                    setState(() {
                                      question5 = 2;
                                    });
                                  } else if (newValue1 == 'Yes, quite a lot') {
                                    setState(() {
                                      question5 = 3;
                                    });
                                  }
                                },
                                items: fives.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: AppText(
                                      txt: valueItem != null
                                          ? valueItem
                                          : 'default value',
                                      size: 15,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, bottom: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AppText(
                                    txt:
                                        'Things have been getting on top of me',
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
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
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
                                value: six,
                                onChanged: (newValue1) {
                                  setState(() {
                                    six = newValue1;
                                  });
                                  if (newValue1 ==
                                      'No, I have been coping ass well as ever') {
                                    setState(() {
                                      question6 = 0;
                                    });
                                  } else if (newValue1 ==
                                      'No, most of the time I have coped quite well') {
                                    setState(() {
                                      question6 = 1;
                                    });
                                  } else if (newValue1 ==
                                      'Yes, sometimes I haven\'t been coping as well as usual') {
                                    setState(() {
                                      question6 = 2;
                                    });
                                  } else if (newValue1 ==
                                      'Yes, most of the time I haven\'t been able to cope at all') {
                                    setState(() {
                                      question6 = 3;
                                    });
                                  }
                                },
                                items: sixs.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: AppText(
                                      txt: valueItem != null
                                          ? valueItem
                                          : 'default value',
                                      size: 15,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, bottom: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AppText(
                                    txt:
                                        'I have been so unhappy that I have difficulty sleeping',
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
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
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
                                value: seven,
                                onChanged: (newValue1) {
                                  setState(() {
                                    seven = newValue1;
                                  });
                                  if (newValue1 == 'No not at all') {
                                    setState(() {
                                      question7 = 0;
                                    });
                                  } else if (newValue1 == 'Not, very often') {
                                    setState(() {
                                      question7 = 1;
                                    });
                                  } else if (newValue1 == 'Yes, sometimes') {
                                    setState(() {
                                      question7 = 2;
                                    });
                                  } else if (newValue1 ==
                                      'Yes, most of the time') {
                                    setState(() {
                                      question7 = 3;
                                    });
                                  }
                                },
                                items: sevens.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: AppText(
                                      txt: valueItem != null
                                          ? valueItem
                                          : 'default value',
                                      size: 15,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, bottom: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AppText(
                                    txt: 'I have been felt sad or miserable',
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
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
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
                                value: eight,
                                onChanged: (newValue1) {
                                  setState(() {
                                    eight = newValue1;
                                  });
                                  if (newValue1 == 'No, not at all') {
                                    setState(() {
                                      question8 = 0;
                                    });
                                  } else if (newValue1 == 'Not very often') {
                                    setState(() {
                                      question8 = 1;
                                    });
                                  } else if (newValue1 == 'Yes, quiet often') {
                                    setState(() {
                                      question8 = 2;
                                    });
                                  } else if (newValue1 ==
                                      'Yes, most of the time') {
                                    setState(() {
                                      question8 = 3;
                                    });
                                  }
                                },
                                items: eights.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: AppText(
                                      txt: valueItem != null
                                          ? valueItem
                                          : 'default value',
                                      size: 15,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, bottom: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AppText(
                                    txt:
                                        'I have been so unhappy that I have been crying',
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
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
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
                                value: nine,
                                onChanged: (newValue1) {
                                  setState(() {
                                    nine = newValue1;
                                  });
                                  if (newValue1 == 'No never') {
                                    setState(() {
                                      question9 = 0;
                                    });
                                  } else if (newValue1 == 'Only occasionally') {
                                    setState(() {
                                      question9 = 1;
                                    });
                                  } else if (newValue1 == 'Yes, quite often') {
                                    setState(() {
                                      question9 = 2;
                                    });
                                  } else if (newValue1 ==
                                      'Yes, most of the time') {
                                    setState(() {
                                      question9 = 3;
                                    });
                                  }
                                },
                                items: nines.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: AppText(
                                      txt: valueItem != null
                                          ? valueItem
                                          : 'default value',
                                      size: 15,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, bottom: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AppText(
                                    txt:
                                        'The thought of harming myself has occurred to me',
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
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        BorderSide(color: HexColor('#000000')),
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
                                value: ten,
                                onChanged: (newValue1) {
                                  setState(() {
                                    ten = newValue1;
                                  });
                                  if (newValue1 == 'Never') {
                                    setState(() {
                                      question10 = 0;
                                    });
                                  } else if (newValue1 == 'Hardly ever') {
                                    setState(() {
                                      question10 = 1;
                                    });
                                  } else if (newValue1 == 'Sometimes') {
                                    setState(() {
                                      question10 = 2;
                                    });
                                  } else if (newValue1 == 'Yes, quite often') {
                                    setState(() {
                                      question10 = 3;
                                    });
                                  }
                                },
                                items: tens.map((valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: AppText(
                                      txt: valueItem != null
                                          ? valueItem
                                          : 'default value',
                                      size: 15,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 330,
                  height: 50,
                  child: AppButton(
                      onPress: () async {
                        if (int.parse(date_difference.toString()) >= 168) {
                          await sum();
                          submit();
                        } else {
                          submit();
                        }
                      },
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
      ),
    );
  }
}
