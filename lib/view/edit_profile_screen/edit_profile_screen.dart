import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myprofile/utils/commen_method.dart';
import 'edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  EditProfileScreen({super.key});

  final editController = Get.put(EditProfileController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await showConfirmationDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              Center(
                child: InkWell(
                  onTap: () async {
                    await editController.pickImage();
                  },
                  child: Obx(() {
                    return editController.imagePath.value.isEmpty
                        ? const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.black12,
                            child: Icon(Icons.edit , size: 45,),
                          )
                        : CircleAvatar(
                            radius: 50.0,
                            backgroundImage:
                                FileImage(File(editController.imagePath.value)),
                            // backgroundImage: editController.imagePath.value.isEmpty
                            //     ? Icon(Icons.edit)
                            //     : FileImage(_imageController.imagePath.value as File),
                            // child: editController.imagePath.value.isEmpty ? const Icon(Icons.edit) : Image.file(File(editController.imagePath.value) , fit: BoxFit.cover,),
                          );
                  }),
                ),
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: editController.nameController,
                decoration: buildInputDecorationTextField(labelName: "Name"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Name';
                  }
                  return null;
                },
              ).paddingSymmetric(vertical: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Email';
                  }
                  return null;
                },
                controller: editController.emailController,
                decoration: buildInputDecorationTextField(labelName: 'Email'),
              ).paddingSymmetric(vertical: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Add Skill';
                  }
                  return null;
                },
                controller: editController.skillController,
                decoration:
                    buildInputDecorationTextField(labelName: 'Add Skill'),
              ).paddingSymmetric(vertical: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Add Experience';
                  }
                  return null;
                },
                controller: editController.experienceController,
                decoration:
                    buildInputDecorationTextField(labelName: 'Add Experience'),
              ).paddingSymmetric(vertical: 10),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await showConfirmationDialog(context);
                        }
                      },
                      child: const Text("Save Profile"))),
            ],
          ).paddingSymmetric(horizontal: 12),
        ),
      ),
    );
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog with a tap
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Changes?'),
          content:
              const Text('Do you want to save your changes before leaving?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                editController.saveProfile();
                Get.offNamed('home');
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
