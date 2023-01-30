import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wgnrr/api/auth/login.dart';

class SharedDate with ChangeNotifier {
  var language = loginAuth().getValidationData();
  var _date;
  DateTime currentDate = DateTime.now();

  Future selectDate(BuildContext context) async {
    var _newDate;
    final newdate = Provider.of<SharedDate>(context, listen: false);
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(2007, 12, 31),
        firstDate: DateTime(1980),
        lastDate: DateTime(2007, 12, 31));
    if (pickedDate != null && pickedDate != currentDate) {
      var day = pickedDate.toString();
      var separated = day.split(" ");
      newdate.newDate = separated[0];
    }
    return _newDate == null
                          ? language == 'Kiswahili'
                              ? 'Chagua mwaka wa kuzaliwa'
                              : 'Select date of birth' :_newDate.toString();
  }

  String get date => _date == null
                          ? language == 'Kiswahili'
                              ? 'Chagua mwaka wa kuzaliwa'
                              : 'Select date of birth' : _date.toString();

  set newDate(val) {
    _date = val;
    notifyListeners();
  }
}

final sharedDate = SharedDate();
