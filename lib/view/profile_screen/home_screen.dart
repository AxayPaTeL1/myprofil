import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myprofile/view/login_screen/login_controller.dart';

import 'home_controller.dart';

class HomeScreen extends GetView<HomeScreenController> {
   HomeScreen({super.key});

  final homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(onPressed: () {
            LoginController().logout();
          }, icon: const Icon(Icons.login))
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: CircleAvatar(
              radius: 50.0,
              child: Icon(Icons.person, color: Colors.grey.shade600, size: 45,),
              // backgroundImage: AssetImage('assets/avatar.png'),
            ),
          ),
          const SizedBox(height: 16.0),
          const ListTile(
            title: Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Your Name'),
          ),
          const ListTile(
            title: Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('your@email.com'),
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
          const ListTile(
            title: Text(
              'Work Experience',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                'Job Title 1, Company Name 1'
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
      ),


    );
  }
}
