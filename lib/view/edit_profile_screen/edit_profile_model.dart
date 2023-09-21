class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? imagePath;
  String? skills;
  String? experience;

  ProfileModel(
      {this.id,
      this.name,
      this.email,
      this.imagePath,
      this.skills,
      this.experience});

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

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    imagePath = json['imagePath'];
    skills = json['skills'];
    experience = json['experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['imagePath'] = this.imagePath;
    data['skills'] = this.skills;
    data['experience'] = this.experience;
    return data;
  }
}
