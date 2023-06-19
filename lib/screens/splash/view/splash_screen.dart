import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/firebase_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  User? user;
  @override

  Widget build(BuildContext context) {

    Timer(Duration(seconds: 3), () async {
      user=await FirebaseHelper.firehelper.firebaseAuth.currentUser;
      if (user == null) {
        Get.offAndToNamed('/google');
      } else {
        Get.offAndToNamed('/home');
      }
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffDDF1FA),
        body: Center(
          child: Lottie.asset("assets/json/admin.json"),
        ),
      ),
    );
  }
}
