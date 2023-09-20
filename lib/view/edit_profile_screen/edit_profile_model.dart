

class ProfileModel {
  int id;
  String name;
  String email;
  String imagePath;
  String skills;
  String experience;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.imagePath,
    required   this.skills,
    required   this.experience,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imagePath': imagePath,
      'skills': skills,
      'experience': experience,
    };
  }
}
