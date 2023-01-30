import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedData with ChangeNotifier {
  var _language;
  bool _isLoading = false;

  SharedData() {
    _loadLanguage();
  }

  get language => _language;
  bool get isLoading => _isLoading;

  set language(value) {
    _language = value;
    _saveLanguage();
    notifyListeners();
  }

  _loadLanguage() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _language = sharedPreferences.get('language');
  }

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  _saveLanguage() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("language", _language);
  }
}
final sharedData = SharedData();