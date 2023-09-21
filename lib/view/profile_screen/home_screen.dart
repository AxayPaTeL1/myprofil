import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myprofile/view/edit_profile_screen/edit_profile_model.dart';
import 'package:myprofile/view/login_screen/login_controller.dart';

import 'home_controller.dart';

class HomeScreen extends GetView<HomeScreenController> {
   HomeScreen({super.key});

  final homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home Screen"),
        actions: [
          IconButton(onPressed: () {
            LoginController().logout();
          }, icon: const Icon(Icons.login))
        ],
      ),
      body: FutureBuilder<ProfileModel>(
        // stream: null,
        future: homeController.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No profile data available'));
          }
          return ListView(
            children: [
              Center(
                child:  controller.profileInfo!.imagePath!.isEmpty ? CircleAvatar(
                  radius: 50.0,
                  child :  Icon(Icons.person, color: Colors.grey.shade600, size: 45,)
                ):  CircleAvatar(
                  radius: 50.0,
                  backgroundImage: FileImage(File(controller.profileInfo!.imagePath!)),
                  // backgroundImage: AssetImage('assets/avatar.png'),
                ),
              ),
              const SizedBox(height: 16.0),
               ListTile(
                title: const Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(controller.profileInfo!.name!),
              ),
               ListTile(
                title: const Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(controller.profileInfo!.email!),
              ),
              ListTile(
                title: const Text(
                  'Skills',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Obx(() {
                  return Wrap(
                      children: List.generate(
                          homeController.skillsList.length, (index) =>
                      homeController.skillsList[index] == '' ? const SizedBox() : Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Text(
                              "${homeController.skillsList[index]}", style: const TextStyle(color: Colors
                                .white),),
                          ) )
                  );
                }),
              ),
               ListTile(
                title: const Text(
                  'Work Experience',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    controller.profileInfo!.experience!
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 50,
                  child: ElevatedButton(onPressed: () {
                    Get.toNamed("editProfile");
                  }, child: const Text("Edit Profile"))).paddingSymmetric(
                  horizontal: 12)
            ],
          );
        }
      ),


    );
  }
}
