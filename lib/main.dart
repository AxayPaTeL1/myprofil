import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myprofile/view/home_view/home_view.dart';
import 'package:myprofile/view/login_view/login_view.dart';

import 'view/login_view/login_controller.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final LoginController authController = Get.put(LoginController());
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: authController.isLoggedIn.value ? '/home' : '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
      ],
    );
  }
}
