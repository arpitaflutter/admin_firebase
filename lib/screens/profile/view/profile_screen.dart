import 'package:admin_firebase/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/firebase_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    controller.userData.value = FirebaseHelper.firehelper.userDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffDDF1FA),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff2C3856),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage("${controller.userData['img']}"),
                  radius: 45,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "${controller.userData['name']}",
                style: TextStyle(
                    color: Color(0xff2C3856),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 18,
              ),
              SizedBox(height: 7,),
              Text(
                "${controller.userData['email']}",
                style: TextStyle(
                    color: Color(0xff2C3856),
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
