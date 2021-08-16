import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String? email;
  bool isTeacher;

  UserModel(
      {required this.name,
      required this.email,
      required this.id,
      required this.isTeacher});

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    return UserModel(
        name: map!['nome'],
        email: map['email'],
        id: map['id'],
        isTeacher: map['isTeacher']);
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'isTeacher': isTeacher
      };
  String toJson() => jsonEncode(toMap());
}
