


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myprofile/utils/commen_method.dart';

import 'edit_profile_controller.dart';
import 'edit_profile_model.dart';

class EditProfileScreen extends GetView {
   EditProfileScreen({super.key});

  // final _imageController = Get.put(EditProfileController());

   final TextEditingController nameController = TextEditingController();
   final TextEditingController emailController = TextEditingController();
   final TextEditingController skillController = TextEditingController();
   final TextEditingController experienceController = TextEditingController();

   final controller = Get.put(EditProfileController());


   @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: ()async{
        await showConfirmationDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Edit Profile"), centerTitle: true,),
      body: ListView(
        children: [
          Center(
            child: InkWell(
              onTap: () async {
                await controller.pickImage();
              },
              child: CircleAvatar(
                radius: 50.0,
                // backgroundImage: _imageController.imagePath.value.isEmpty
                //     ? AssetImage('assets/avatar.png')
                //     : FileImage(_imageController.imagePath.value as File),
              ),
            ),
          ),

          const SizedBox(height: 50),

          TextFormField(
            controller: nameController,
            decoration: buildInputDecorationTextField(labelName: "Name")
          ).paddingSymmetric(vertical: 10),
          TextFormField(
            controller: emailController,
            decoration: buildInputDecorationTextField(labelName: 'Email'),
          ).paddingSymmetric(vertical: 10),
          TextFormField(
            controller: skillController,
            decoration: buildInputDecorationTextField(labelName: 'Add Skill'),
          ).paddingSymmetric(vertical: 10),

          TextFormField(
            controller: experienceController,
            decoration: buildInputDecorationTextField(labelName: 'Add Experience'),
          ).paddingSymmetric(vertical: 10),

          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(onPressed: ()async {
                editProfile ();
                return;
                await showConfirmationDialog(context);
              }, child: const Text("Save Profile")))
        ],
      ).paddingSymmetric(horizontal: 12),

      ),
    );
  }

   Future<void> showConfirmationDialog(BuildContext context) async {
     return showDialog(
       context: context,
       barrierDismissible: false, // Prevent dismissing the dialog with a tap
       builder: (BuildContext context) {
         return AlertDialog(
           title: Text('Save Changes?'),
           content: Text('Do you want to save your changes before leaving?'),
           actions: <Widget>[
             TextButton(
               onPressed: () {
                 // Discard changes and pop the screen
                 Navigator.of(context).pop();
                 Get.back();
               },
               child: Text('Cancel'),
             ),
             TextButton(
               onPressed: () {
                 // Save changes and pop the screen
                 // Implement your save logic here
                 Navigator.of(context).pop();
                 Get.back();
               },
               child: Text('Save'),
             ),
           ],
         );
       },
     );
   }




   void editProfile (){
     final profile = ProfileModel(
       name: nameController.text,
       email: emailController.text,
       imagePath: controller.imagePath.value,
       skills: skillController.text,
       experience: experienceController.text, id: 111,
     );
   }
}
