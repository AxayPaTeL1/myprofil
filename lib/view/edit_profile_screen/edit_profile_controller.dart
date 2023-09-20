import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  RxString imagePath = ''.obs;

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


}
