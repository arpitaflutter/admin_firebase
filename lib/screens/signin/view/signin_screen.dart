import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/firebase_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffDDF1FA),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Lottie.asset("assets/json/signup.json",
                  height: 250, width: 250),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(14),
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    // topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Sign In",
                      style: TextStyle(
                          color: Color(0xff17282F),
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextField(
                      controller: txtEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Email"),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff17282F),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: txtPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Password"),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff17282F),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    InkWell(
                      onTap: () async {
                        String email = txtEmail.text;
                        String password = txtPassword.text;

                        String? msg = await FirebaseHelper.firehelper.signIN(email: email, password: password);

                        if(msg == "Success")
                        {
                          Get.snackbar("$msg", "successfully login");
                          Get.toNamed('/home');
                        }
                        else
                        {
                          Get.snackbar("Filed login", "Enter the correct email or password");
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 260,
                        decoration: BoxDecoration(
                          color: Color(0xff17282F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Create an account?",style: TextStyle(
                            color: Color(0xff17282F), fontSize: 17),),
                        TextButton(
                          onPressed: () {
                            Get.toNamed('/signup');
                          },
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                                color: Color(0xff17282F), fontSize: 17),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}