import 'package:flutter/material.dart';


void customNavigator(BuildContext context,Widget page){
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ));
}