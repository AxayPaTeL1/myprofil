import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myprofile/utils/commen_method.dart';
import 'package:myprofile/view/edit_profile_screen/edit_profile_screen.dart';
import 'package:myprofile/view/login_screen/login_controller.dart';
import 'package:myprofile/view/login_screen/login_screen.dart';
import 'package:myprofile/view/profile_screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LoginController authController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: authController.isLoggedIn.value ? HomeScreen() : LoginScreen(),
      getPages: [
        GetPage(
            name: '/login',
            page: () => LoginScreen(),
            binding: LoginControllerBindings()),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: '/editProfile',
          page: () => EditProfileScreen(),
        ),
      ],
    );
  }
}

bool kDebugMode = true;
