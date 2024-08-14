import 'dart:io';

class User {
  late int user_id;
  late String name, phone, password, email, role;
  late String img_path;
  late File img;
  User(
      {this.user_id = -1,
      required this.name,
      required this.password,
      required this.phone,
      required this.email,
      required this.role,
      required this.img});

  User.fromMap(Map<String, dynamic> map) {
    user_id = map["user_id"];
    name = map["name"];
    phone = map["phone"];
    email = map["email"];
    password = map["passwoed"];
    role = map["role"];
    img = map["img"];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "phone": phone,
      "password": password,
      "email": email,
      "role": role,
      "img": img
    };
  }
}
