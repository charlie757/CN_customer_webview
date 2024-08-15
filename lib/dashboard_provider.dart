import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardProvider extends ChangeNotifier {
  bool isIntro = true;
    callInitFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isIntro') != null && prefs.getBool('isIntro') == true) {
      isIntro = false;
    } else {
      isIntro = true;
    }
    notifyListeners();
  }
}
