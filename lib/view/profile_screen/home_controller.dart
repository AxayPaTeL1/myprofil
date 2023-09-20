import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxList skillsList = [].obs;

  @override
  void onInit() {
    splitSkillsText();
    super.onInit();
  }

  void splitSkillsText() {
    String text = "Dart,flutter,git,c++,";
    skillsList.value = text.split(',');
  }
}
