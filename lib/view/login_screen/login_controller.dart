import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final RxBool isLoggedIn = false.obs;
  RxBool passwordVisible = false.obs;
  final RxBool rememberMe = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    checkLoggedIn();
    emailController.text = "akpatel1031@gmail.com";
    passwordController.text = "akshay@123";
    super.onInit();
  }

  Future<void> checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> login(String username, String password) async {
    if (username == 'akpatel1031@gmail.com' && password == 'akshay@123') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      if (rememberMe.value) {
        await prefs.setBool('rememberMe', rememberMe.value);
        await prefs.setString('userName', username);
        await prefs.setString('password', password);
      }
      isLoggedIn.value = true;
      Get.snackbar('Success', 'Logged in successfully',
          snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed("home");
    } else {
      Get.snackbar('Incorrect', 'Check password and Email',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void loadSavedCredentials() async {
    print("loadSavedCredentials");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('userName');
    final savedPassword = prefs.getString('password');

    if (savedEmail != null && savedPassword != null) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      rememberMe.value = true;
    } else {
      emailController.clear();
      passwordController.clear();
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

  Future googleLogin({context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        // String googleUserEmail = googleUser.email;
        // var splitName = googleUser.displayName!.split(" ");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        Get.offAllNamed("home");

        return;
      }
    } catch (error) {
      print(error);
    } finally {
    }
    update();
  }
}
