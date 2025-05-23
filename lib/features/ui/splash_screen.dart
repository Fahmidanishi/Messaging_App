import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/constrants.dart';
import '../../common/custom_navigator.dart';
import '../auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: background,
            ),
            child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        SvgPicture.asset('assets/images/splash_logo.svg'),
                        const Text(
                          'Stay connected with your friends and family',
                          style: TextStyle(
                              fontSize: 38, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            customNavigator(context, const LoginPage());
                          },
                          child: const Text('Start Messaging'),

                        ),
                      ],
                    ),),),),);
  }
}
