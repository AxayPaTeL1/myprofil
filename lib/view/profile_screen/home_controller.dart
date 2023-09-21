import 'package:get/get.dart';
import 'package:myprofile/services/local_databse/profile_database.dart';
import 'package:myprofile/view/edit_profile_screen/edit_profile_model.dart';
import 'package:sqflite/sqlite_api.dart';

class HomeScreenController extends GetxController {
  RxList skillsList = [].obs;
  final DatabaseHelpper dbHelper = DatabaseHelpper();
  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  void splitSkillsText({text}) {
    skillsList.value = profileInfo!.skills!.split(',');
  }

  ProfileModel? profileInfo;

  Future<ProfileModel> getProfile() async {
    final Database? db = await dbHelper.databse;
    final List<Map<String, dynamic>> maps = await db!.query('profile');
    if (maps.isEmpty) {
      print("Database is Empty");
      ProfileModel demoProfile = ProfileModel(
        name: "AkshayPatel",
        email: "akshay1031@Gmail.com",
        imagePath: "",
        experience: "2 Year",
        skills: "Flutter,Dart,GitHub,Firebase,SqlLite",
        id: 111
      );
      insertProfile(demoProfile);
      // return null;
    }
    profileInfo = ProfileModel.fromJson(maps.first);
    splitSkillsText();
    return ProfileModel.fromJson(maps.first);
  }


  Future<void> insertProfile(ProfileModel profile) async {
    final Database? db = await dbHelper.databse;
    await db!.insert('profile', profile.toMap());
  }

}
