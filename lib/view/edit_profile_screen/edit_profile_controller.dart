import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myprofile/services/local_databse/profile_database.dart';
import 'package:sqflite/sqflite.dart';

import 'edit_profile_model.dart';

class EditProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController skillController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  RxString imagePath = ''.obs;
  final DatabaseHelpper dbHelper = DatabaseHelpper();


  @override
  void onInit() {
   getProfile();
    super.onInit();
  }


  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;

    }
  }

  RxList<String> skillsList = <String>[].obs;

  void splitSkillsText() {
    String text = "Dart,flutter,git,c++,";
    skillsList.value = text.split(',');
  }

  Future<void> insertProfile(ProfileModel profile) async {
    final Database? db = await dbHelper.databse;
    await db!.insert('profile', profile.toMap());
  }

  Future<Map<String, dynamic>> getProfile() async {
    final Database? db = await dbHelper.databse;
    final List<Map<String, dynamic>> maps = await db!.query('profile');
    ProfileModel profileInfo = ProfileModel.fromJson(maps.first);
    nameController.text = profileInfo.name!;
    emailController.text = profileInfo.email!;
    skillController.text = profileInfo.skills!;
    experienceController.text = profileInfo.experience!;
    imagePath.value = profileInfo.imagePath!;
    return maps.first;
    // return ProfileModel.fromMap(maps.first);
  }

  Future<void> updateProfile(ProfileModel profile) async {
    final Database? db = await dbHelper.databse;
    await db?.update(
      'profile',
      profile.toMap(),
      where: 'id = ?',
      whereArgs: [profile.id],
    ).then((value)  {
      // HomeScreenController().getProfile();
    Get.snackbar('Update', ' Update is successfully' , snackPosition: SnackPosition.BOTTOM);
    });
  }

  void saveProfile() {
    final profile = ProfileModel(
      name: nameController.text,
      email: emailController.text,
      imagePath: imagePath.value,
      skills: skillController.text,
      experience: experienceController.text,
      id: 111,
    );
    updateProfile(profile);
  }



}
