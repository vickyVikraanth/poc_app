import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_routes.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, ViewRoutes.homePage);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'POC Project',
          style: Get.theme.textTheme.bodyText1!.copyWith(
              color: Colors.black,
              fontSize: 35),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
