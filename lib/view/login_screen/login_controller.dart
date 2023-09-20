import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myprofile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final RxBool isLoggedIn = false.obs;
  RxBool passwordVisible = false.obs;
  final RxBool rememberMe = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    checkLoggedIn();
    super.onInit();
  }

  Future<void> checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    log("${isLoggedIn.value}");
    isLoggedIn.value ? loadSavedCredentials() : null;
  }
  Future<void> login(String username, String password) async {
    if (username == 'admin' && password == 'password') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      if(rememberMe.value){
        await prefs.setString('userName', username);
        await prefs.setString('password', password);
        if (kDebugMode) {
          print("Set Value >>>>>");
        }
      }
      isLoggedIn.value = true;
      Get.snackbar('Success', 'Logged in successfully' , snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed("home");
    }else{
      Get.snackbar('Unsuccessful', 'check password and name' , snackPosition: SnackPosition.BOTTOM);
    }
  }
  void loadSavedCredentials() async {
    print("loadSavedCredentials");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');
    if (savedEmail != null && savedPassword != null) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      rememberMe.value = true;
    }else{
      emailController.clear();
      passwordController.clear();
      if (kDebugMode) {
        log("value is Null >>>>>>>>>");
      }
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    isLoggedIn.value = false;
    emailController.clear();
    passwordController.clear();
    loadSavedCredentials();
    Get.offAllNamed('login');
  }


  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

}
