import 'package:admin_firebase/screens/adddata/view/adddata_screen.dart';
import 'package:admin_firebase/screens/detail/view/detail_screen.dart';
import 'package:admin_firebase/screens/googlesignin/view/googlesignin_screen.dart';
import 'package:admin_firebase/screens/home/view/home_screen.dart';
import 'package:admin_firebase/screens/order/view/order_screen.dart';
import 'package:admin_firebase/screens/profile/view/profile_screen.dart';
import 'package:admin_firebase/screens/signin/view/signin_screen.dart';
import 'package:admin_firebase/screens/signup/view/signup_screen.dart';
import 'package:admin_firebase/screens/splash/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => SplashScreen(),),
        GetPage(name: '/home', page: () => HomeScreen(),),
        GetPage(name: '/details', page: () => DetailsScreen(),),
        GetPage(name: '/add', page: () => AddDataScreen(),),
        GetPage(name: '/google', page: () => GooglesihninScreen(),),
        GetPage(name: '/signin', page: () => SignInScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/order', page: () => OrderScreen()),
      ],
    ),
  );
}
