import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../language_controller.dart';
import '../widgets/language_tile.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  final LanguageController languageController = Get.put(LanguageController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text("Language"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height:16),
            Text(
              'Select your preferable language'.tr,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            LanguageTile(
              label: 'English',
              checked: languageController.currentLocale.languageCode == 'en',
              onChanged: (bool? checked) {
                if (checked == true) {
                  languageController.changeLanguage('en', 'US');
                }
              },
            ),
            LanguageTile(
              label: 'বাংলা',
              checked: languageController.currentLocale.languageCode == 'bn',
              onChanged: (bool? checked) {
                if (checked == true) {
                  languageController.changeLanguage('bn', 'BD');
                } else {
                  languageController.changeLanguage('en', 'US');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
