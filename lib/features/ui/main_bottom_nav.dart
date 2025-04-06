import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/features/ui/setting_page.dart';

import 'group_chat.dart';
import 'home_page.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({super.key});

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomePage(),
    GroupChat(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int value) {
            _selectedIndex = value;
            setState(() {});
          },
          elevation: 0,
          selectedItemColor: Colors.amber,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_2_fill), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.group_solid), label: 'Group'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: 'Setting'),
          ]),
    );
  }
}
