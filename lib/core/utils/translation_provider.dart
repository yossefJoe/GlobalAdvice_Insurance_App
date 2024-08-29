import 'package:flutter/material.dart';
import 'package:global_advice_new/features/home/presentation/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:global_advice_new/features/auth/presentation/login_screen.dart';

class TranslationProvider with ChangeNotifier {
  TranslationProvider(bool isArabic) {
    //}, bool isLogin, String uid_success) {
    if (isArabic) {
      _locale = Locale('ar', '');
    } else {
      _locale = Locale('en', '');
    }

  }

  Locale _locale = Locale('en', '');
  Locale get locale => _locale;
  void change_language() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_locale.languageCode == 'ar') {
      _locale = Locale('en', '');
      prefs.setBool("is_arabic", false);
    } else if (_locale.languageCode == 'en') {
      _locale = Locale('ar', '');
      prefs.setBool("is_arabic", true);
    }
    notifyListeners();
  }

  bool is_Login = false;
  Widget homePage = const LoginScreen();
  void check_login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isUser = prefs.getString('user_uid') != null;

    if (is_Login == false) {
      is_Login = true;
      homePage = const HomeScreen();
      prefs.setBool("is_login", true);
    } else if (is_Login == true) {
      is_Login = false;
      homePage = const LoginScreen();
      prefs.setBool("is_login", false);
    }
    notifyListeners();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_uid');
  }

  void setUID(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_uid', uid);
  }

}
