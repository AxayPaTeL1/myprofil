
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myprofile/view/edit_profile_screen/edit_profile_controller.dart';
import 'package:myprofile/view/login_screen/login_controller.dart';
import 'package:myprofile/view/profile_screen/home_controller.dart';

InputDecoration buildInputDecorationTextField({labelName}) {
  return InputDecoration(labelText: labelName,   border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),);
}



class LoginControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
