import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  final _languageCodeKey = 'language-Code';
  final _countryCodeKey = 'country-Code';

  Locale _currentLocale = Locale('en', 'US');

  Locale get currentLocale => _currentLocale;

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString(_languageCodeKey) ?? 'en';
    String? countryCode = prefs.getString(_countryCodeKey) ?? 'US';
    _currentLocale = Locale(languageCode, countryCode);
    updateLocale();
  }

  void changeLanguage(String languageCode, String countryCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_languageCodeKey, languageCode);
    prefs.setString(_countryCodeKey, countryCode);
    _currentLocale = Locale(languageCode, countryCode);
    updateLocale();
  }

  void updateLocale() {
    Get.updateLocale(currentLocale);
  }
}
